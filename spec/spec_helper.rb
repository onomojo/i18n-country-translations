
require "simplecov"
require "i18n_country_translations"
require 'rspec/core'
require 'i18n-spec'
require "rails/all"
Dir[File.join(I18nCountryTranslations.root, "spec/support/**/*.rb")].sort.each {|f| require f}

require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.mock_with :rspec
  config.fail_fast = true
  config.include ImportHelper
end

module RbConfig
  class Application < ::Rails::Application
    # configuration here if needed
    config.active_support.deprecation = :stderr
    I18n.enforce_available_locales = false
  end
end

# Initialize the application
RbConfig::Application.initialize!
