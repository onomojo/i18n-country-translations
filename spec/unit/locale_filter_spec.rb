# frozen_string_literal: true

require "spec_helper"

describe I18nCountryTranslations::Railtie, ".load_translations" do
  around do |example|
    backend = I18n.backend
    I18n.backend = I18n::Backend::Simple.new
    example.run
  ensure
    I18n.backend = backend
  end

  context "when available_locales is an Array of Strings" do
    it "still loads matching locales (regression for issue #89)" do
      described_class.load_translations(%w[en de])

      expect(I18n.t(:US, scope: :countries, locale: :en)).to eql "United States"
      expect(I18n.t(:US, scope: :countries, locale: :de)).to eql "Vereinigte Staaten"
    end

    it "skips locales that are not listed" do
      described_class.load_translations(%w[en])

      loaded = I18n.backend.send(:translations).keys
      expect(loaded).to include(:en)
      expect(loaded).not_to include(:fr)
    end
  end

  context "when available_locales is an Array of Symbols" do
    it "loads matching locales" do
      described_class.load_translations(%i[en fr])

      expect(I18n.t(:US, scope: :countries, locale: :en)).to eql "United States"
      expect(I18n.t(:US, scope: :countries, locale: :fr)).to eql "États-Unis"
    end
  end

  context "when available_locales is nil" do
    it "loads every shipped locale" do
      described_class.load_translations(nil)

      data_dir = I18nCountryTranslationsData.data_dir
      shipped = Dir[File.join(data_dir, "*.json")].map { |f| File.basename(f, ".json").to_sym }
      expect(I18n.backend.send(:translations).keys).to include(*shipped)
    end
  end
end
