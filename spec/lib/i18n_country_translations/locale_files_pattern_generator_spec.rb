require 'i18n_country_translations/locale_files_pattern_generator'

describe I18nCountryTranslations::LocaleFilesPatternGenerator do

  context "with given locale" do
    let(:generator) { I18nCountryTranslations::LocaleFilesPatternGenerator.new('base/', '.yml') }

    it "generates a pattern for simple locales" do
      locales = ['en', 'fr']
      pattern = generator.pattern_from(locales)

      # Make sure pattern matches locales
      locales.each do |locale|
        expect(File.fnmatch(pattern, "base/#{locale}.yml", File::FNM_EXTGLOB)).to be true
      end

      # Make sure pattern does not match other locales
      ['nl', 'en-US', 'fra', 'cen'].each do |locale|
        expect(File.fnmatch(pattern, "base/#{locale}.yml", File::FNM_EXTGLOB)).to be false
      end
    end

    it "generates a pattern for locales with tags" do
      locales = ['en-US', 'az-Latn-IR']
      sublocales = ['en', 'en-US', 'az', 'az-Latn', 'az-Latn-IR']
      pattern = generator.pattern_from(locales)

      # Make sure pattern matches locales
      sublocales.each do |locale|
        expect(File.fnmatch(pattern, "base/#{locale}.yml", File::FNM_EXTGLOB)).to be true
      end

      # Make sure pattern does not match other locales
      ['en-AU', 'az-IR'].each do |locale|
        expect(File.fnmatch(pattern, "base/#{locale}.yml", File::FNM_EXTGLOB)).to be false
      end
    end
  end

end