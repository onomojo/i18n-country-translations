require 'i18n_country_translations/import_two_letter_codes'

describe I18nCountryTranslations::ImportTwoLetterCodes do

  context "with given locale" do
    let(:importer) { I18nCountryTranslations::ImportTwoLetterCodes.new("en") }

    before do
      importer.output_dir = yml_output_dir
    end

    it "fails with invalid locale" do
      stub_request(:get, "http://www.unicode.org/cldr/charts/latest/summary/en.html").
        with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(:status => 404, :body => "", :headers => {})
      expect { importer.process }.to output("[!] Invalid locale name 'en'! Not found in CLDR (404 )\n").to_stdout
    end

    it "generates file" do
      stub_request(:get, "http://www.unicode.org/cldr/charts/latest/summary/en.html").
        with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => en_html_body, :headers => {})
      expect { importer.process }.to output("\n... writing the output\n\n---\nWritten values for the 'en' into file: #{yml_output_dir}/en.yml\n").to_stdout
    end
  end

  context "present locales" do
    it "uses existing yml files to assign locales" do
      importer = I18nCountryTranslations::ImportTwoLetterCodes.new
      expect(importer.locales).to be_kind_of(Array)
      expect(importer.locales.size).to be >= Dir.glob(File.join(I18nCountryTranslations.root, 'rails/locale/iso_639-1/*.yml')).size
    end
  end

end
