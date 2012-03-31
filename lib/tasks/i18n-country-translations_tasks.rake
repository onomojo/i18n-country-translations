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
    locale = ENV['IMPORT_LOCALE']
    unless locale
      puts "\n[!] Usage: IMPORT_LOCALE=de rake import:country_translation\n\n"
      exit 0
    end

    # ----- Get the CLDR HTML     --------------------------------------------------
    begin
      doc = Hpricot( open("http://www.unicode.org/cldr/data/charts/summary/#{locale}.html") )
    rescue => e
      puts "[!] Invalid locale name '#{locale}'! Not found in CLDR (#{e})"
      exit 0
    end


    # ----- Parse the HTML with Hpricot     ----------------------------------------
    countries = []
    doc.search("//tr").each do |row|
      if row.search("td[@class='n']") && 
         row.search("td[@class='n']").inner_html =~ /^namesterritory$/ && 
         row.search("td[@class='g']").inner_html =~ /^[A-Z]{2}/
        code   = row.search("td[@class='g']").inner_text
        code   = code[-code.size, 2]
        name   = row.search("td[@class='v']").inner_text
        countries << { :code => code.to_sym, :name => name.to_s }
      end
    end


    # ----- Prepare the output format     ------------------------------------------
    output =<<HEAD
#{locale}:
  countries:
HEAD
    countries.each do |country|
      output << "    #{country[:code]}: \"#{country[:name]}\"\n"
    end
    output <<<<TAIL
TAIL

    
    # ----- Write the parsed values into file      ---------------------------------
    puts "\n... writing the output"
    filename = File.join(File.dirname(__FILE__), '..', '..', 'rails', 'locale', "#{locale}.yml")
    filename += '.NEW' if File.exists?(filename) # Append 'NEW' if file exists
    File.open(filename, 'w+') { |f| f << output }
    puts "\n---\nWritten values for the '#{locale}' into file: #{filename}\n"
    # ------------------------------------------------------------------------------
  end

end