# -*- encoding : utf-8 -*-
require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Sitron
  class Application < Rails::Application

    config.generators do |g|
      g.stylesheets false
    end
    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.autoload_paths += %W(#{config.root}/lib)
    config.encoding = "utf-8"
    config.time_zone = 'Brasilia'
    config.i18n.enforce_available_locales = false
    config.i18n.available_locales = ["pt-BR"]
    config.i18n.default_locale = :'pt-BR'

    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    config.assets.paths << "#{Rails.root}/app/assets/sounds"

=begin
    config.middleware.use FayeRails::Middleware, mount: '/faye', :timeout => 25 do
      map '/widgets/**' => WidgetsController 
      map :default => :block
    end
    config.middleware.delete Rack::Lock
=end

  end
end
