module Images
  class GetUploadAttrs
    attr_reader :direct_upload_url

    def initialize(direct_upload_url)
      @direct_upload_url = direct_upload_url
    end

    def call
      tries ||= 5
      direct_upload_url_data = Image::DIRECT_UPLOAD_URL_FORMAT.match(direct_upload_url)
      s3 = Aws::S3::Resource.new
      bucket = s3.buckets[Image::BUCKET_NAME]
      obj = bucket.objects[direct_upload_url_data[:path]]
      direct_upload_head = obj.head

      {
        image_file_name: direct_upload_url_data[:filename],
        image_file_size: direct_upload_head.content_length,
        image_content_type: direct_upload_head.content_type,
        image_updated_at: direct_upload_head.last_modified
      }
    rescue Aws::S3::Errors::NoSuchKey => e
      tries -= 1
      if tries > 0
        sleep(3)
        retry
      else
        raise e
      end
    end
  end
end
