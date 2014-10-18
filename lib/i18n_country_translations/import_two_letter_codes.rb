require 'yaml'
require 'open-uri'
require 'nokogiri'
# Imports ISO 639-1 country codes
# It parses a HTML file from Unicode.org for given locale and saves the
# Rails' I18n hash in the plugin +locale+ directory
module I18nCountryTranslations
  class ImportTwoLetterCodes
    attr_accessor :output_dir
    attr_reader :locales

    def initialize(locales = nil)
      @locales = if locales
        [locales]
      else
        present_locales
      end

      @output_dir = file_location
    end

    def process
      @locales.each_with_index do |locale, index|
        # ----- Get the CLDR HTML     --------------------------------------------------
        begin
          doc = Nokogiri::HTML(open("http://www.unicode.org/cldr/charts/latest/summary/#{locale}.html"))
        rescue => e
          puts "[!] Invalid locale name '#{locale}'! Not found in CLDR (#{e})"
          return if index == @locales.length - 1
        end
        # ----- Parse the HTML with Nokogiri ----------------------------------------
        output = { locale => { "countries" => search_for_countries(doc) } }
        # ----- Write the parsed values into file      ---------------------------------
        write_for(locale, output)
      end
    end

    private

      def search_for_countries(doc)
        result = {}
        doc.search("//tr").each do |row|
          if row.search("td[@class='n']") &&
             row.search("td[@class='n']").first &&
             (row.search("td[@class='n']").first.inner_text =~ /^Locale Display Names$/) &&
             row.search("td[@class='g']") &&
             row.search("td[@class='g']").last &&
             (row.search("td[@class='g']").last.inner_text =~ /^\s*[A-Z]{2}\s*$/) &&
             row.search("td[@class='v']") &&
             row.search("td[@class='v']").first
            code   = row.search("td[@class='g']").last.inner_text
            code   = code[-code.size, 2]
            name   = row.search("td[@class='v']").first.inner_text
            result.update({ code.to_s => name.to_s })
          end
        end
        # result.sort_by { |key, value| key }.to_h works in Ruby 2.x
        Hash[result.sort_by { |key, value| key }]
      end

      def present_locales
        locale_files = Dir.glob(file_location + "/*")
        locale_files.map{ |f| f.split("/").last.split(".")[0] }
      end

      def file_location
        File.join(File.dirname(__FILE__), "..", "..", "rails", "locale", "iso_639-1")
      end

      def write_for(locale, output)
        puts "\n... writing the output"
        filename = File.join(@output_dir, "#{locale}.yml")
        File.rename(filename, filename + ".OLD") if File.exists?(filename) # Rename by appending 'OLD' if file exists
        File.open(filename, "w+") { |f| f << output.to_yaml }
        puts "\n---\nWritten values for the '#{locale}' into file: #{filename}\n"
      end
  end
end