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
      # Not found in CLDR: trv, sid, oc, nds, mn, kaj, kcg, gaa, cch
      locales = ["aa", "af", "agq", "ak", "am", "ar", "as", "asa", "az", "bas",
                 "be", "bem", "bez", "bg", "bm", "bn", "bo", "br", "brx", "bs",
                 "byn", "ca", "cgg", "chr", "cs", "cy", "da", "dav", "de", "dje",
                 "dua", "dyo", "dz", "ebu", "ee", "el", "en", "eo", "es", "et",
                 "eu", "ewo", "fa", "ff", "fi", "fil", "fo", "fr", "fur", "ga",
                 "gaa", "gd", "gl", "gsw", "gu", "guz", "gv", "ha", "haw", "he",
                 "hi", "hr", "hu", "hy", "ia", "id", "ig", "ii", "is", "it", "ja",
                 "jmc", "ka", "kab", "kaj", "kam", "kcg", "kde", "kea", "khq",
                 "ki", "kk", "kl", "kln", "km", "kn", "ko", "kok", "ksb", "ksf",
                 "ksh", "kw", "ky", "lag", "lg", "ln", "lo", "lt", "lu", "luo",
                 "luy", "lv", "mas", "mer", "mfe", "mg", "mgh", "mk", "ml", "mn",
                 "mr", "ms", "mt", "mua", "my", "naq", "nb", "nd", "nds", "ne",
                 "nl", "nmg", "nn", "nr", "nso", "nus", "nyn", "oc", "om", "or",
                 "pa", "pl", "ps", "pt", "rm", "rn", "ro", "rof", "ru", "rw",
                 "rwk", "sah", "saq", "sbp", "se", "seh", "ses", "sg", "shi", "si",
                 "sid", "sk", "sl", "sn", "so", "sq", "sr", "ss", "ssy", "st",
                 "sv", "sw", "swc", "ta", "te", "teo", "tg", "th", "ti", "tig",
                 "tn", "to", "tr", "trv", "ts", "twq", "tzm", "uk", "ur", "uz",
                 "vai", "ve", "vi", "vun", "wae", "wal", "xh", "xog", "yav", "yo", "zh", "zu"]
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
end