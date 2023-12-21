module Testapp
  class Application < Jets::Application
    config.load_defaults 5.0

    config.project_name = "testapp"
    config.mode = "job"

    config.prewarm.enable = false
    # Docs:
    # https://rubyonjets.com/docs/config/
    # https://rubyonjets.com/docs/config/reference/
  end
end
