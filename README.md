# I18n Country Translations

[![Gem Version](https://badge.fury.io/rb/i18n-country-translations.svg)](https://rubygems.org/gems/i18n-country-translations)
[![CI](https://github.com/onomojo/i18n-country-translations/actions/workflows/ci.yml/badge.svg)](https://github.com/onomojo/i18n-country-translations/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Country name translations for Rails and the i18n gem. If you're doing anything with country names and translations, there's no need to reinvent the wheel — just use this gem and skip the hassle of managing translations for each locale yourself.

## Requirements

- Ruby >= 3.1
- Rails >= 7.2 (or `railties` >= 7.2)

## Installation

Add to your Gemfile:

```ruby
gem 'i18n-country-translations'
```

Translation data is provided by the [`i18n-country-translations-data`](https://github.com/onomojo/i18n-country-translations-data) gem, which is installed automatically as a dependency.

## Usage

```ruby
I18n.t(:US, scope: :countries)
# => "United States"

I18n.locale = :de
I18n.t(:US, scope: :countries)
# => "Vereinigte Staaten"

I18n.locale = :ja
I18n.t(:JP, scope: :countries)
# => "日本"
```

Or in Rails views:

```ruby
t(:US, scope: :countries)
```

## Supported Locales

**168 locales** sourced from [Unicode CLDR](https://cldr.unicode.org/), including all [ISO 639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) languages plus additional CLDR-supported locales.

## Supported Country Codes

**257 territory codes** following [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) (all 248 officially assigned codes), plus these additional territory codes from Unicode CLDR: AC, CP, DG, EA, EU, IC, QO, TA, UM, XK.

## How It Works

This gem uses a [Railtie](https://api.rubyonrails.org/classes/Rails/Railtie.html) to automatically load translations after Rails initializes. Translations are loaded from the [`i18n-country-translations-data`](https://github.com/onomojo/i18n-country-translations-data) gem via `I18n.backend.store_translations`, scoped under `countries:`.

If your app sets `config.i18n.available_locales`, only the matching locales will be loaded.

## Contributing

Translation data lives in the [`i18n-country-translations-data`](https://github.com/onomojo/i18n-country-translations-data) repo. To add or fix translations, submit a pull request there.

### Running tests

```bash
bundle install
bundle exec rspec
```

## Also Available for JavaScript

- [`i18n-country-translations-js`](https://www.npmjs.com/package/i18n-country-translations-js) — The same translations for JavaScript/TypeScript projects

## Related

- [i18n_country_select](https://github.com/onomojo/i18n_country_select) — A Rails select helper for country dropdowns using these translations
- [i18n-timezones](https://github.com/onomojo/i18n-timezones) — Translations for Rails default timezones

## License

MIT or GPL-3.0

## Special Thanks

- [rails-i18n](https://github.com/svenfuchs/rails-i18n)
