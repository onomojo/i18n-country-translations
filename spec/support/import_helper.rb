module ImportHelper
  def en_html_body
    File.new('spec/fixtures/unicode_org_en.html')
  end

  def yml_output_dir
    File.join(I18nCountryTranslations.root, "tmp")
  end
end