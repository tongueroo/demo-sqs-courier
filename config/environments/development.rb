Jets.application.configure do
  # Docs: https://rubyonjets.com/docs/config/reference/

  config.cache_classes = false
  config.eager_load = false
  config.logging.event = false # can be useful for CloudWatch

end
