require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Uberzilla
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.generators do |g|
      g.template_engine :haml
      g.test_framework :rspec, fixture: false
      g.helper_specs false
      g.fixture_replacement :factory_girl
      g.factory_girl false
      g.javascripts false
      g.stylesheets false
      g.helpers false
    end

    Warden::Manager.serialize_into_session do |user|
      user.id
    end

    Warden::Manager.serialize_from_session do |id|
      User.find_by_id(id)
    end

    Warden::Strategies.add :password do
      def valid?
        params['login'] && params['password']
      end

      def user
        User.find_by(email: params['login']) || User.new
      end

      def authenticate!
        if user.valid_password?(params['password'])
          success!(user)
        else
          fail!(user)
        end
      end
    end

    config.middleware.use RailsWarden::Manager do |m|
      m.failure_app = SessionsController.action(:unauthenticated)
      m.default_strategies :password
    end
  end
end
