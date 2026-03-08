# frozen_string_literal: true

require "spec_helper"

describe "single call" do
  it "translates correctly" do
    expect(I18n.t(:ES, scope: :countries)).to eql "Spain"
  end
end

data_dir = I18nCountryTranslationsData.data_dir

Dir.glob(File.join(data_dir, "*.json")) do |locale_file|
  locale = File.basename(locale_file, ".json")

  describe "#{locale} translations" do
    context "file structure" do
      it "ensures correctness" do
        translations = I18n.backend.send(:translations)
        keys = translations[locale.to_sym][:countries].keys

        keys.each do |country_code|
          expect(I18n.t(country_code, scope: :countries, separator: "\001")).to_not eql country_code.to_s
          expect(I18n.t(country_code, scope: :countries, separator: "\001").include?("translation missing")).to be_falsy
        end
      end
    end
  end
end
