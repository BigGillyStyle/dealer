module Images
  class GetUploadAttrs
    attr_reader :direct_upload_url

    def initialize(direct_upload_url)
      @direct_upload_url = direct_upload_url
    end

    def call
      tries ||= 5
      direct_upload_url_data = Image::DIRECT_UPLOAD_URL_FORMAT.match(direct_upload_url)
      aws_client = Aws::S3::Client.new(region: Rails.configuration.aws[:region])
      obj = aws_client.get_object(bucket: Image::BUCKET_NAME, key: direct_upload_url_data[:path])

      {
        image_file_name: direct_upload_url_data[:filename],
        image_file_size: obj.content_length,
        image_content_type: obj.content_type,
        image_updated_at: obj.last_modified
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
