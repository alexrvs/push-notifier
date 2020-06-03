Apipie.configure do |config|
  config.app_name                = "Notifier"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/apidoc"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  config.validate = false
  config.reload_controllers = Rails.env.development?
  config.api_routes = Rails.application.routes
  config.app_info["1.0"] = ""
end
