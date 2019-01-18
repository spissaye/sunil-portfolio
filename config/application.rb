require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SunilPortfolio
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.sass.preferred_syntax = :sass
    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    #loads /config/*.const.yml and assigns ENV-specific data into a constant based on file name
    def self.load_configs
      puts "*"*30
      puts ENV.inspect
      puts "*"*30

      paths = Dir.glob(File.join(Rails.root, "config", "*.const.yml"))
      paths.each do |path|
        module_eval <<-code
          ::#{ path.split("/").last.split(".").first.upcase } = YAML::load_file(path)[Rails.env]
        code
      end
    end

    self.load_configs
  end
end
