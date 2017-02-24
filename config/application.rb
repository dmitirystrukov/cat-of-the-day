require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Catday
  class Application < Rails::Application

  end
end

require Rails.root.join 'lib', 'modules', 'omniauthable'
