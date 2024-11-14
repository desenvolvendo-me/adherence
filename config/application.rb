require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"

# Require propshaft explicitly
require "propshaft"

Bundler.require(*Rails.groups)

module ProductionAdherence
  class Application < Rails::Application
    config.load_defaults 7.1  # Use a versão mais recente dos defaults

    # Configuração do timezone
    config.time_zone = "Brasilia"
    config.active_record.default_timezone = :local

    # Configuração do idioma
    config.i18n.default_locale = :'pt-BR'
    config.i18n.available_locales = [:'pt-BR', :en]

    # Configuração do gerador
    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_bot
      g.factory_bot dir: 'spec/factories'
      g.assets false
      g.helper false
      g.jbuilder false
    end
  end
end
