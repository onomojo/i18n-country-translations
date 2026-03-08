# frozen_string_literal: true

require "rails/railtie"
require "json"
require "i18n_country_translations_data"

module I18nCountryTranslations
  class Railtie < ::Rails::Railtie
    config.after_initialize do
      data_dir = I18nCountryTranslationsData.data_dir
      locales = Rails.application.config.i18n.available_locales

      Dir[File.join(data_dir, "*.json")].each do |file|
        locale = File.basename(file, ".json").to_sym
        next if locales.present? && !locales.include?(locale)

        translations = JSON.parse(File.read(file))
        I18n.backend.store_translations(locale, countries: translations)
      end
    end
  end
end
