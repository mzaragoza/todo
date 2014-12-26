require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Todo
  class Application < Rails::Application
    #configure generators
    config.generators do |g|
      g.template_engine :haml
      g.test_framework      :rspec, fixture: true
      g.fixture_replacement :fabrication, dir: "spec/fabricators"
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Eastern Time (US & Canada)'
    config.active_record.default_timezone = :local

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    config.assets.precompile += %w( .svg .eot .woff .ttf )
    config.autoload_paths += %W(#{config.root}/lib)

    config.before_initialize do
      dev = File.join(Rails.root, 'config', 'config.yml')
      YAML.load(File.open(dev)).each do |key,value|
      ENV[key.to_s] = value
      end if File.exists?(dev)
    end

    config.to_prepare do
      Devise::Mailer.layout "email" # email.haml or email.erb
    end

    def load_console
      super
      if File.exists?(project_specific_irbrc = File.join(Rails.root, ".irbrc"))
        load(project_specific_irbrc)
      end
      if File.exists?(project_specific_awesome_print = File.join(Rails.root, ".aprrc"))
        load(project_specific_awesome_print)
      end
    end
  end
end
