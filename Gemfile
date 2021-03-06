source 'https://rubygems.org'
ruby '2.1.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'

gem 'rails-api'

# Use postgresql as the database for Active Record
gem 'pg'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# serialize json
gem 'active_model_serializers', github: 'rails-api/active_model_serializers'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'has_secure_token'

# User Warden for authentication
gem 'warden'

# Use CanCanCan for authorization
gem 'cancancan', '~> 1.10'

# tzinfo for windows
gem 'tzinfo-data'

# paperclip for attachments
gem 'paperclip', '~> 4.3'

# aws for storage
gem 'aws-sdk-v1'

# Factory Girl for test data
gem 'factory_girl_rails'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem "codeclimate-test-reporter", group: :test, require: nil

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'rspec-rails', '~> 3.0'
  gem 'rspec_junit'
end

group :test do
  gem 'shoulda-matchers', '~> 2.5.0', require: false
end
