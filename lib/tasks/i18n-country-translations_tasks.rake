require 'rubygems'
require 'open-uri'

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
      require 'hpricot'
    rescue LoadError
      puts "Error: Hpricot library required to use this task (import:country_select)"
      exit
    end
    
    # Setup variables
    if ENV['IMPORT_LOCALE']
      locales = [ENV['IMPORT_LOCALE']]
    else
      locale_files = Dir.glob("rails/locale/iso_639-1/*")
      locales = locale_files.map{|f| f.split('/')[2].split('.')[0] }
    end


    locales.each_with_index do |locale, index|
      # ----- Get the CLDR HTML     --------------------------------------------------
      begin
        doc = Hpricot( open("http://www.unicode.org/cldr/data/charts/summary/#{locale}.html") )
      rescue => e
        puts "[!] Invalid locale name '#{locale}'! Not found in CLDR (#{e})"
        exit 0 if index == locales.length - 1
        next
      end


      # ----- Parse the HTML with Hpricot     ----------------------------------------
      countries = []
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
          countries << { :code => code.to_sym, :name => name.to_s }
        end
      end

      # ----- Prepare the output format     ------------------------------------------
      output =<<HEAD
#{locale}:
  countries:
HEAD
      countries.sort { |x,y| x[:code] <=> y[:code] }.each do |country|
        country_code = country[:code] == :NO ? "\'NO\'" : country[:code]
        country_name = country[:name].gsub("; [draft=contributed]", "")
        output << "    #{country_code}: \"#{country_name}\"\n"
      end
      output <<<<TAIL
TAIL


      # ----- Write the parsed values into file      ---------------------------------
      puts "\n... writing the output"
      filename = File.join(File.dirname(__FILE__), '..', '..', 'rails', 'locale', "#{locale}.yml")
      File.rename(filename, filename + ".OLD") if File.exists?(filename) # Rename by appending 'OLD' if file exists
      File.open(filename, 'w+') { |f| f << output }
      puts "\n---\nWritten values for the '#{locale}' into file: #{filename}\n"
      # ------------------------------------------------------------------------------
    end

  end
end