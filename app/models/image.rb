# Heavily influenced by:
#
# Article: http://blog.littleblimp.com/post/53942611764/direct-uploads-to-s3-with-rails-paperclip-and
# Code: https://github.com/uberllama/s3_direct_upload_example/blob/master/app/models/document.rb
#
# Article: http://helabs.com/blog/2014/02/21/how-to-upload-big-files-to-amazon-s3-through-heroku/
# Code: https://github.com/aliismayilov/bigphotoblog
class Image < ApplicationRecord
  BUCKET_NAME = Rails.configuration.aws[:bucket]
  DIRECT_UPLOAD_URL_FORMAT = %r{\Ahttps:\/\/#{BUCKET_NAME}.s3\.amazonaws\.com\/(?<path>uploads\/.+\/(?<filename>.+))\z}.freeze

  belongs_to :vehicle

  has_attached_file :image,
                    styles: {medium: '300x300>', thumb: '100x100>'},
                    default_url: '/images/:style/missing.png'

  validates :direct_upload_url, presence: true # , format: {with: DIRECT_UPLOAD_URL_FORMAT}
  validates :vehicle_id, presence: true
  validates_attachment :image, content_type: {content_type: ['image/jpeg', 'image/gif', 'image/png']}

  # Store an unescaped version of the escaped URL that Amazon returns from direct upload.
  def direct_upload_url=(escaped_url)
    self[:direct_upload_url] = (
      begin
        CGI.unescape(escaped_url)
      rescue
        nil
      end
    )
  end

  # Determines if file requires post-processing (image resizing, etc)
  def post_process_required?
    %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png)$}.match(image_content_type).present?
  end
end

# == Schema Information
#
# Table name: images
#
#  id                 :integer          not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  vehicle_id         :integer          not null
#  direct_upload_url  :string           not null
#  processed          :boolean          default("false"), not null
#  primary            :boolean          default("false")
#
# Indexes
#
#  index_images_on_vehicle_id  (vehicle_id)
#
