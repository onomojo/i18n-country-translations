## 2.1.0

- Fill all missing translations across 33 incomplete locales (ig, as, ps, ia, bo, and 28 others)
- Fix test bug where untranslated entries (value == country code) passed silently due to String/Symbol comparison
- Fix ISO standard reference in README: ISO 3166-2 → ISO 3166-1 alpha-2
- Move rof.yml from iso_639-1/ to unicode_supported/ (rof is ISO 639-3, not ISO 639-1)
- Remove deprecated AN (Netherlands Antilles) country code from all locales per ISO 3166-1
- Update outdated English country names: Swaziland → Eswatini, Turkey → Turkiye, Czech Republic → Czechia

## 2.0.1

- Add zh-CN locale for compatibility with rails-i18n and apps using `I18n.locale = :'zh-CN'`

## 2.0.0

- Add support for Rails 7.x and 8.x
- Add support for Ruby 3.1+
- Migrate CI from Travis CI to GitHub Actions
- Update minimum Ruby version to 3.1
- Update i18n dependency to support i18n 2.x
- Fix Ruby 3+ deprecations (URI.open, File.exist?)
- Modernize gemspec and dependency ranges
- Clean up code for modern Ruby idioms

## 1.4.1

- Minor updates to pt, sq, and ja translations

## 1.4.0

- Adding Rails 6 support

## 1.3.1

- Updated gemspec. Attribution change on license.

## 1.3.0

- Removed country ZZ. Updating dependencies.

## 1.2.4

- Load all default fallbacks for a specific locale, by including all prefix subpatterns. Changed Korean translation for Australia. fix some spelling in ar.yml.

## 1.2.3

- Split out changelog. Adding pt-BR. Fixing Saint Martin in en.

## 1.2.2

- Add Traditional Chinese support

## 1.2.1

- Update glob to include locales again. Fix import task

## 1.1.1

- Fixing bug from incorrect translation paths. Update gemspec for Rails 4 support.

## 1.1.0

- Updating all locales and separating out iso639-1 locales from 3 character unicode supported locales

## 1.0.4

- Adding zh-HK and zh-CN translations.

## 1.0.3

- Adding zh-TW translations.

## 1.0.2

- Fixing bad PT translations. Adding licenses to gemspec.

## 1.0.1

- Fixing bad version in Gemfile.lock

## 1.0.0

- Adding fr-CA translation

## 0.0.9

- Update the locale files with the last values from the CLDR repository
