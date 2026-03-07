# frozen_string_literal: true

require "simplecov"
require "rspec/core"
require "i18n-spec"
require "rails"
require "rails/railtie"
require "yaml"
require "i18n_country_translations_data"
require "i18n_country_translations"

RSpec.configure do |config|
  config.mock_with :rspec
  config.fail_fast = true
end

module I18nCountryTranslationsTest
  class Application < ::Rails::Application
    config.active_support.deprecation = :stderr
    config.eager_load = false
    I18n.enforce_available_locales = false
  end
end

I18nCountryTranslationsTest::Application.initialize!
