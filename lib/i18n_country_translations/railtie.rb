# frozen_string_literal: true

require "rails/railtie"
require "json"
require "i18n_country_translations_data"

module I18nCountryTranslations
  class Railtie < ::Rails::Railtie
    config.after_initialize do
      I18nCountryTranslations::Railtie.load_translations(
        Rails.application.config.i18n.available_locales
      )
    end

    # Re-store translations after every reload. I18n.reload! (triggered in
    # development by editing config/locales files) clears the backend and
    # rebuilds it only from I18n.load_path, dropping our store_translations data.
    initializer "i18n_country_translations.reload" do |app|
      app.reloader.to_prepare do
        I18nCountryTranslations::Railtie.load_translations(
          app.config.i18n.available_locales
        )
      end
    end

    def self.load_translations(locales = nil)
      data_dir = I18nCountryTranslationsData.data_dir
      locales = locales.map(&:to_sym) if locales.present?

      Dir[File.join(data_dir, "*.json")].each do |file|
        locale = File.basename(file, ".json").to_sym
        next if locales.present? && !locales.include?(locale)

        translations = JSON.parse(File.read(file))
        I18n.backend.store_translations(locale, countries: translations)
      end
    end
  end
end
