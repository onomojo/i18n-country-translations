module I18nCountryTranslations

  # Generates patterns for locale files, bases on a list of supported locales
  class LocaleFilesPatternGenerator

    attr_reader :base_pattern, :extension

    def initialize(base_pattern, extension = '.yml')
      @base_pattern = base_pattern
      @extension = extension
    end

    # Generates a glob file pattern for the specified list of locales (i.e. IETF language tags)
    def pattern_from(locales)
      locales = Array(locales || [])
      locales = locales.map { |locale| subpatterns_from locale }.flatten
      pattern = locales.blank? ? '*' : "{#{locales.join ','}}"
      "#{base_pattern}#{pattern}#{extension}"
    end

    protected

    # Generates subpatterns for the specified locale (i.e. IETF language tag).
    # Subpatterns are all more generic variations of a locale.
    # E.g. subpatterns for en-US are en-US and en. Subpatterns for az-Latn-IR are az-Latn-IR, az-Latn and az
    def subpatterns_from(locale)
      parts = locale.to_s.split('-')
      parts.map.with_index { |part,index| parts[0..index].join('-') }
    end

  end
end