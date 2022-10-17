# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Rails instalation gems
gem 'bootsnap', '>= 1.4.2', require: false
gem 'jbuilder', '~> 2.11'
gem 'jquery-rails'
gem 'pg'
gem 'puma', '~> 5.6'
gem 'rails', '~> 7.0.2'
gem 'turbolinks', '~> 5'
gem 'tzinfo-data'
gem 'webpacker', '~> 5.4'

# Gems needed for the app, outside rails
gem 'browser'
gem 'devise', '~> 4.8.1'
gem 'mimemagic'
gem 'i18n_lazy_scope'
gem 'image_processing', '~> 1.12'
gem 'shrine', '~> 3.4.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'i18n-tasks'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 6.0.0'
  gem 'shoulda-matchers'
  gem 'with_model'
end

group :development, :test, :staging do
  gem 'factory_bot_rails'
  gem 'faker'
end

group :development do
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.8'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
