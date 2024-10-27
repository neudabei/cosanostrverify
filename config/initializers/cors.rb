Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '/.well-known', 
      headers: :any,
      methods: [:get],
      :max_age => 0
  end
end
