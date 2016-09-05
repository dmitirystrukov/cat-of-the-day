source 'https://rubygems.org'

ruby '2.3.0'

gem 'rails', '4.2.7'

gem 'puma'

gem 'draper'
gem 'devise'
gem 'rolify'
gem 'cancancan'

gem 'pg'
gem 'simple_form'
gem 'friendly_id'
gem 'kaminari'

gem 'carrierwave'
gem 'mini_magick'

gem 'sass'
gem 'haml'

gem 'jquery-rails'
gem 'jquery-ui-rails'

gem 'koala'
gem 'twitter'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'omniauth-vkontakte'

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
end

group :development, :test do
  gem 'rspec-rails', '~> 3.5'
  gem 'rails_dt'
  gem 'pry-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'dotenv-rails', require: 'dotenv/rails-now'
end
