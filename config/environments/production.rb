Jets.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.log_level = :info
  config.logging.event = false # can be useful for CloudWatch

end
