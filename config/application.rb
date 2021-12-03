# frozen_string_literal: true
require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  # Application
  class Application < Rails::Application
    config.load_defaults 6.1
    config.api_only = true
    config.autoload_paths << 'lib'
    config.hosts << '.example.com'
    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end

    # タイムゾーン(ruby側は東京にして, DBはUTCに)
    config.time_zone = 'Tokyo'

    # Cookieのsamesite
    Rails.application.config.action_dispatch.cookies_same_site_protection = :strict

    app_host = Rails.env.test? ? 'localhost:3000' : ENV.fetch('APP_HOST')
    Rails.application.routes.default_url_options = {
      host: app_host,
      protocol: app_host.match?(/localhost/) ? 'http' : 'https'
    }
  end
end
