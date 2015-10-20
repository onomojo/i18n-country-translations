require 'i18n_country_translations/locale_files_pattern_generator'
require 'i18n_country_translations/railtie'

module I18nCountryTranslations
  def self.root
    File.expand_path('../..', __FILE__)
  end
end
