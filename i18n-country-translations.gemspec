$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "i18n_country_translations/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "i18n-country-translations"
  s.version     = I18nCountryTranslations::VERSION
  s.authors     = ["Brian McQuay"]
  s.email       = ["brian@onomojo.com"]
  s.homepage    = "https://github.com/onomojo/i18n-country-translations"
  s.summary     = "I18n Country Translations"
  s.description = "The purpose of this gem is to simply provide country translations. The gem is intended to be easy to combine with other gems that require i18n country translations so we can have common i18n country translation gem."

  s.files        = Dir.glob("lib/**/*") + Dir.glob("rails/locale/*") +
                   %w(README.rdoc MIT-LICENSE)
  s.test_files = Dir["test/**/*"]
  s.require_path = 'lib'
  s.platform     = Gem::Platform::RUBY

  s.add_dependency('i18n', '~> 0.5')
  s.add_dependency "railties", ">= 3.0.0"
  s.add_development_dependency "rails", ">= 3.0.0"
  s.add_development_dependency "rspec-rails", ">= 2.7.0"
  s.add_development_dependency "i18n-spec", ">= 0.1.1"
  s.add_development_dependency "spork", "~> 1.0rc"
  s.add_development_dependency "hpricot"
  s.licenses = ['MIT', 'GPL-2']
end
