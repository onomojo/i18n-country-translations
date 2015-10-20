require 'i18n_country_translations/locale_files_pattern_generator'

describe I18nCountryTranslations::LocaleFilesPatternGenerator do

  context "with given locale" do
    let(:generator) { I18nCountryTranslations::LocaleFilesPatternGenerator.new('base/', '.yml') }

    def test_pattern(pattern, sample)
      if defined? File::FNM_EXTGLOB
        # Use proper way to test, by calling fnmatch and actually executing the pattern.
        # This only works in Ruby 2.1.0 and upwards
        File.fnmatch(pattern, sample, File::FNM_EXTGLOB)
      else
        # Roughly approximate pattern matching using regular expressions. Only recognizes the braces { } syntax.
        # Other glob syntax (e.g. * and ** is not recognized). So keep test cases simple!
        pattern = '^' + pattern.split(/\{(.+?)\}/).each_with_index.map do |part, index|
          if index.even?
            # Pattern part outside of { }
            Regexp.escape(part)
          else
            '(' + part.split(',').map { |option| Regexp.escape(option) }.join('|') + ')'
          end
        end.join + '$'

        # Test against regular expression pattern
        (sample =~ Regexp.new(pattern)) == 0
      end
    end

    it "generates a pattern for simple locales" do
      locales = ['en', 'fr']
      pattern = generator.pattern_from(locales)

      # Make sure pattern matches locales
      locales.each do |locale|
        expect(test_pattern(pattern, "base/#{locale}.yml")).to be true
      end

      # Make sure pattern does not match other locales
      ['nl', 'en-US', 'fra', 'cen'].each do |locale|
        expect(test_pattern(pattern, "base/#{locale}.yml")).to be false
      end
    end

    it "generates a pattern for locales with tags" do
      locales = ['en-US', 'az-Latn-IR']
      sublocales = ['en', 'en-US', 'az', 'az-Latn', 'az-Latn-IR']
      pattern = generator.pattern_from(locales)

      # Make sure pattern matches locales
      sublocales.each do |locale|
        expect(test_pattern(pattern, "base/#{locale}.yml")).to be true
      end

      # Make sure pattern does not match other locales
      ['en-AU', 'az-IR'].each do |locale|
        expect(test_pattern(pattern, "base/#{locale}.yml")).to be false
      end
    end
  end

end