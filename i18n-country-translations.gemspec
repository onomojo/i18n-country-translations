require_relative "lib/i18n_country_translations/version"

Gem::Specification.new do |s|
  s.name        = "i18n-country-translations"
  s.version     = I18nCountryTranslations::VERSION
  s.authors     = ["Brian McQuay"]
  s.email       = ["brian@onomojo.com"]
  s.homepage    = "https://github.com/onomojo/i18n-country-translations"
  s.summary     = "I18n Country Translations"
  s.description = "The purpose of this gem is to simply provide country translations. The gem is intended to be easy to combine with other gems that require i18n country translations so we can have common i18n country translation gem."

  s.files        = Dir.glob("lib/**/*") + %w(README.md MIT-LICENSE)
  s.require_path = 'lib'
  s.platform     = Gem::Platform::RUBY

  s.required_ruby_version = '>= 3.1'

  s.add_dependency 'i18n', '>= 0.9.3', '< 3'
  s.add_dependency 'railties', '>= 7.2', '< 9'
  s.add_dependency 'i18n-country-translations-data', '~> 1.1'

  s.add_development_dependency 'rails', '>= 7.2', '< 9'
  s.add_development_dependency 'rspec-rails', '~> 8.0'
  s.add_development_dependency 'i18n-spec', '~> 0.1', '>= 0.1.1'
  s.add_development_dependency 'simplecov', '~> 0.22'

  s.licenses = ['MIT', 'GPL-3.0']
end
