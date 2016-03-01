source 'https://rubygems.org'

ruby '2.3.0'

gem 'rails', '~> 4.2.5.2'

# views
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'jbuilder'
gem 'bootstrap-sass'
gem 'bootswatch-rails'
gem 'font-awesome-sass'
gem 'high_voltage'

# data
gem 'aws-sdk-v1'
gem 'paperclip'
gem 's3_direct_upload'
gem 'pg'
gem 'annotate'

# other
gem 'devise'
gem 'puma', '~> 2.16.0'
gem 'rack-timeout'
gem 'awesome_print'
gem 'newrelic_rpm'
gem 'rollbar'
gem 'sucker_punch', '~> 1.6.0' # upgrade 2.0 with Rails 5: https://github.com/brandonhilkert/sucker_punch/issues/159
gem 'money-rails'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'foreman'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'codeclimate-test-reporter', require: nil
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'rspec-rails'
  gem 'rubocop', require: false
end

group :production do
  gem 'rails_12factor'
end

group :doc do
  gem 'sdoc'
end
