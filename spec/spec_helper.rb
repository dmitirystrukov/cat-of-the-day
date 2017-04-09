RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:each) do
    stub_request(:get, "https://api.twitter.com/1.1/account/verify_credentials.json").
             with(:headers => {'Accept'=>'application/json', 'User-Agent'=>'TwitterRubyGem/6.0.0'}).
             to_return(status: 200, body: "{\"id\":1}", headers: {})
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
