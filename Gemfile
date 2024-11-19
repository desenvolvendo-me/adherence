source "https://rubygems.org"
ruby "3.2.2"

gem "rails", github: "rails/rails", branch: "7-2-stable"
gem "pg", "~> 1.1"
gem "puma", "~> 6.0"
gem "propshaft"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "bootsnap", require: false
gem "kaminari"

# Testing
gem "rspec-rails"
gem "factory_bot_rails"
gem "faker"
gem "shoulda-matchers"
gem "database_cleaner-active_record"

# Debug
gem "pry-rails"
gem "awesome_print"

# Security
gem "brakeman"
gem "bundler-audit"

group :development do
  gem "rubocop"
  gem "rubocop-rails"
  gem "rubocop-rspec"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
