OmniAuth.config.test_mode = true

class OmniAuthTestConsumer
  def key
    'somekey'
  end

  def secret
    'somesecret'
  end
end

class OmnuAuthTest
  def consumer
    OmniAuthTestConsumer.new
  end
end

OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
  provider: 'twitter',
  uid: '999',
  extra: { access_token: OmnuAuthTest.new },
  credentials: { token: 'sometoken', secret: 'somesecret' }
})
