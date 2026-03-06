# I18n Country Translations

[![CI](https://github.com/onomojo/i18n-country-translations/actions/workflows/ci.yml/badge.svg)](https://github.com/onomojo/i18n-country-translations/actions/workflows/ci.yml)

Country name translations for Rails and the i18n gem. If you're doing anything with country names and translations, there's no need to reinvent the wheel — just use this gem and skip the hassle of managing translations for each locale yourself.

**Compatibility:** Ruby 3.1+ / Rails 7.2+

## Supported Locales

Locales are specified by [ISO 639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) alpha-2 codes, with additional 3-character locale codes supported by [Unicode CLDR](https://cldr.unicode.org/).

## Supported Country Codes

Country codes follow the [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) standard (all 248 officially assigned codes), plus these additional territory codes from [Unicode CLDR](https://cldr.unicode.org/): AC, CP, DG, EA, EU, IC, QO, TA, UM, XK.

## Installation

Add to your Gemfile:

```ruby
gem 'i18n-country-translations'
```

## Usage

```ruby
I18n.t(:US, scope: :countries)
# => "United States"
```

Or in Rails views:

```ruby
t(:US, scope: :countries)
```

## Contributing

Most locale translations already exist, but if you find an error or something is missing, please submit a pull request.

Most of the locales were generated using this rake task:

```sh
IMPORT_LOCALE=en rake import:country_translation
```

It generates a YAML file containing country translations for the specified locale. Note that some translations may still be missing.

## Related

- [i18n_country_select](https://github.com/onomojo/i18n_country_select) — A Rails select helper for country dropdowns using these translations
- [i18n-timezones](https://github.com/onomojo/i18n-timezones) — Translations for Rails default timezones

## License

MIT or GPL-3.0

## Special Thanks

- [rails-i18n](https://github.com/svenfuchs/rails-i18n)
