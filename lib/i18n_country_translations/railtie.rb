require 'rails'

module I18nCountryTranslations
  class Railtie < ::Rails::Railtie #:nodoc:
    initializer 'i18n-country-translations' do |app|
      I18nCountryTranslations::Railtie.instance_eval do
        generator = LocaleFilesPatternGenerator.new('rails/locale/**/')
        add generator.pattern_from app.config.i18n.available_locales
      end
    end

    protected

    def self.add(pattern)
      files = Dir[File.join(File.dirname(__FILE__), '../..', pattern)]
      I18n.load_path.concat(files)
    end

  end
end
