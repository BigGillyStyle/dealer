timeout = Rails.env.test? ? 60 : 20 # Travis tests need more time to run (they execute slowly)
Rack::Timeout.timeout = timeout # seconds
Rack::Timeout.unregister_state_change_observer(:logger) if Rails.env.development?
