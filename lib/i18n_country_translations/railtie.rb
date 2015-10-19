require 'rails'
require "active_support"

module I18nCountryTranslations
  class Railtie < ::Rails::Railtie #:nodoc:
    config.i18n_countries_translations = ActiveSupport::OrderedOptions.new

    initializer 'i18n-country-translations' do |app|
      I18nCountryTranslations::Railtie.instance_eval do
        locales = app.config.i18n_countries_translations.delete(:locales) ||
          app.config.i18n.available_locales
        pattern = pattern_from locales

        add("rails/locale/**/#{pattern}.yml")
      end
    end

    protected

    def self.add(pattern)
      files = Dir[File.join(File.dirname(__FILE__), '../..', pattern)]
      I18n.load_path.concat(files)
    end

    def self.pattern_from(args)
      array = Array(args || [])
      array.blank? ? '*' : "{#{array.join ','}}"
    end
  end
end
