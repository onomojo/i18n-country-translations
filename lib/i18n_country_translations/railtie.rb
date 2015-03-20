require 'rails'

module I18nCountryTranslations
  class Railtie < ::Rails::Railtie #:nodoc:
    initializer 'i18n-country-translations' do |app|
      I18nCountryTranslations::Railtie.instance_eval do
        pattern = pattern_from app.config.i18n.available_locales

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
      array = array.map { |locale| subpatterns_from locale }.flatten
      array.blank? ? '*' : "{#{array.join ','}}"
    end

    def self.subpatterns_from(locale)
      parts = locale.to_s.split('-')
      parts.map.with_index { |part,index| parts[0..index].join('-') }
    end
  end
end
