require 'simplecov'

SimpleCov.start

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'capybara-screenshot/rspec'

abort("The Rails environment is running in production mode!") if Rails.env.production?

Capybara::Screenshot.autosave_on_failure = false

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.include FactoryGirl::Syntax::Methods

  config.include Devise::TestHelpers, type: :view
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include FeatureHelpers,      type: :feature
end

RSpec::Expectations.configuration.on_potential_false_positives = :nothing
