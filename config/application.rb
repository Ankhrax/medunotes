require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Notepadweb
  class Application < Rails::Application
    config.load_defaults 8.0
    config.i18n.available_locales = [ :en, :es ]
    config.i18n.default_locale = :es

    config.autoload_lib(ignore: %w[assets tasks])
  end
end
