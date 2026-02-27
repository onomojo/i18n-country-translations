
require "simplecov"
require "i18n_country_translations"
require 'rspec/core'
require 'i18n-spec'
require "rails"
require "rails/railtie"
Dir[File.join(I18nCountryTranslations.root, "spec/support/**/*.rb")].sort.each {|f| require f}

require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.mock_with :rspec
  config.fail_fast = true
  config.include ImportHelper
end

module I18nCountryTranslationsTest
  class Application < ::Rails::Application
    config.active_support.deprecation = :stderr
    config.eager_load = false
    I18n.enforce_available_locales = false
  end
end

I18nCountryTranslationsTest::Application.initialize!
