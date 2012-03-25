$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "i18n-country-translations/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "i18n-country-translations"
  s.version     = I18nCountryTranslations::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of I18nCountryTranslations."
  s.description = "TODO: Description of I18nCountryTranslations."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.2"

  s.add_development_dependency "sqlite3"
end
