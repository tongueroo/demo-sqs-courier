Jets.application.configure do
  config.cache_classes = false
  config.eager_load = ENV["CI"].present?
  config.cache_store = :null_store

end
