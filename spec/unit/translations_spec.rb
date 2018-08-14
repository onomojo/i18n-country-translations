# frozen_string_literal: true

describe "single call" do
  it "translates correctly" do
    expect(I18n.t(:ES, :scope => :countries)).to eql "Spain"
  end
end

Dir.glob('rails/locale/iso_639-1/*.yml') do |locale_file|

  # locale rof is missing in https://github.com/tigrish/iso/blob/master/data/iso-639-1.yml
  next if locale_file == 'rails/locale/iso_639-1/rof.yml'

  describe locale_file do
    it_behaves_like "a valid locale file", locale_file

    context "file structure" do
      it "ensures correctness" do
        locale = setup_locale(locale_file)

        translations = I18n.backend.send(:translations)
        keys = translations[locale.to_sym][:countries].keys

        keys.each do |country_code|
          expect(I18n.t(country_code, :scope => :countries, :separator => "\001")).to_not eql country_code
          expect(I18n.t(country_code, :scope => :countries, :separator => "\001").include?("translation missing")).to be_falsy
        end
      end
    end
  end
end

def setup_locale(locale_file)
  locale_file.split("/").last.split(".").first
end
