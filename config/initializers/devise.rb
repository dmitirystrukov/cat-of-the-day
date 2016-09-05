Devise.setup do |config|
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage  = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 11
  config.reconfirmable = true
  config.password_length = 6..128

  config.secret_key = '198d63fe12ae3e2bc4070610f226d7ed9ef912ff660fcfb353e3ffe1cd6529b09068ff05e527edacdc54cec8617630dbe6fefab10c9de37cd6fc788d032d6b3c'

  config.expire_all_remember_me_on_sign_out = true
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  config.reset_password_within = 6.hours
  config.sign_out_via = :get
end
