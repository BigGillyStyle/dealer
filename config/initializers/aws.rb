require 'aws-sdk'
# Rails.configuration.aws is used by AWS, Paperclip, and S3DirectUpload
Rails.configuration.aws = YAML.load(ERB.new(File.read("#{Rails.root}/config/aws.yml")).result)[Rails.env].symbolize_keys!
Aws.config[:logger] = Rails.logger
valid_aws_config = Rails.configuration.aws.reject {|k,v| k == :bucket}
Aws.config.merge!(valid_aws_config)
