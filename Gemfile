source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', '4.2.7.1'

gem 'puma'
gem 'active_model_serializers'
gem 'chart-js-rails'

gem 'draper'
gem 'devise'
gem 'rolify'
gem 'cancancan'

gem 'pg'
gem 'simple_form'
gem 'friendly_id'
gem 'kaminari'
gem 'mimemagic'

gem 'carrierwave'
gem 'mini_magick'
gem 'fog'
gem 'sidetiq'
gem 'sidekiq'

gem 'aasm'

gem 'responders'
gem 'sass'
gem 'bootstrap'
gem 'hamlit'
gem 'coffee-rails'

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'geocomplete_rails'

gem 'koala'
gem 'twitter'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'

source 'https://rails-assets.org' do
  gem 'rails-assets-tether'
end

group :production, :release, :staging do
  gem 'uglifier'
  gem 'factory_girl_rails'
  gem 'rails_12factor'
  gem 'heroku_rails_deflate'
end

group :development do
  gem 'bullet'
  gem 'byebug'
  gem 'better_errors'
  gem 'rubocop', require: false
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers', '3.1.1'
  gem 'capybara', '~> 2.5'
  gem 'capybara-screenshot'
  gem 'cucumber-rails', require: false
  gem 'capybara-webkit'
  gem 'launchy'
  gem 'fuubar'
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'webmock'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.5'
  gem 'rails_dt'
  gem 'pry-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'dotenv-rails', require: 'dotenv/rails-now'
end
