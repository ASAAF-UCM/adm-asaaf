# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

# Rails instalation gems
gem 'bootsnap', '>= 1.4.2', require: false
gem 'bootstrap', '~> 5.0.0.beta2'
gem 'jbuilder', '~> 2.11'
gem 'pg'
gem 'puma', '~> 5.2'
gem 'rails', '~> 6.1.3'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.2'

# Gems needed for the app, outside rails
gem 'browser'
gem 'devise', '~> 4.7.1'
gem 'i18n_lazy_scope'
gem 'image_processing', '~> 1.12'
gem 'shrine', '~> 3.3.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'i18n-tasks'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 4.0.2'
  gem 'shoulda-matchers'
  gem 'with_model'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
