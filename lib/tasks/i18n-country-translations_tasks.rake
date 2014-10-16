require 'rubygems'
require 'open-uri'
require 'i18n_country_translations/import_two_letter_codes'
# Rake task for importing country names from Unicode.org's CLDR repository
# (http://www.unicode.org/cldr/data/charts/summary/root.html).
#
# It parses a HTML file from Unicode.org for given locale and saves the
# Rails' I18n hash in the plugin +locale+ directory
#

namespace :import do

  desc "Import country codes and names for various languages from the Unicode.org CLDR archive. Depends on Hpricot gem."
  task :country_translation do
    begin
      require 'nokogiri'
    rescue LoadError
      puts "Error: Nokogiri library required to use this task (import:country_select)"
      exit
    end

    import = I18nCountryTranslations::ImportTwoLetterCodes.new(ENV['IMPORT_LOCALE'])
    import.process
  end
end