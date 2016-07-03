# Heavily influenced by:
#
# Article: http://blog.littleblimp.com/post/53942611764/direct-uploads-to-s3-with-rails-paperclip-and
# Code: https://github.com/uberllama/s3_direct_upload_example/blob/master/app/models/document.rb
class ImageProcessingJob < ActiveJob::Base
  queue_as :default

  # Final upload processing step:
  #
  # 1) If the file does not require processing, manually copy direct upload to
  #   the location that Paperclip expects, saving transfer time/cost.
  #   If the file requires post-processing, set the direct_upload_url as the image's remote source,
  #   which instantiates download, process, and re-upload of the file via Paperclip callbacks.
  # 2) Flag image as processed
  # 3) Delete the temp upload from s3.
  #
  # @see http://docs.aws.amazon.com/AmazonS3/latest/dev/CopyingObjectUsingRuby.html
  def perform(image)
    unless image.processed # don't re-process image
      ActiveRecord::Base.connection_pool.with_connection do
        direct_upload_url_data = Image::DIRECT_UPLOAD_URL_FORMAT.match(image.direct_upload_url)
        s3 = Aws::S3::Resource.new

        if image.post_process_required?
          image.image = URI.parse(URI.escape(image.direct_upload_url))
        else
          paperclip_file_path = "images/images/#{id}/original/#{direct_upload_url_data[:filename]}"
          s3.buckets[Image::BUCKET_NAME].objects[paperclip_file_path].copy_from(direct_upload_url_data[:path])
        end

        image.processed = true
        image.save!

        s3.buckets[Image::BUCKET_NAME].objects[direct_upload_url_data[:path]].delete
      end
    end
  end
end
