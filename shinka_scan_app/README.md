# shinka_scan_app

The Flutter application for **ShinkaScan** — scan a card's serial number, look it up in the local card database, and (per the roadmap) check prices and trade with other collectors.

See the [repository README](../README.md) for the project overview and setup, and the
[master development plan](../master_development_plan.md) for the component map and schedule.

## Quick start

```sh
flutter pub get
dart run build_runner build   # regenerate drift code after schema changes
flutter run                   # Android/iOS/desktop (web not supported yet — see issue #1)
```

## Layout

- `lib/data/` — drift (SQLite) database, CSV seeder, card repository
- `lib/models/` — `TCGCard`, `Booster`
- `lib/screens/` — Cards, Boosters, Collection, OCR scan
- `lib/services/` — OCR service (mobile / web / stub via conditional imports)
- `DB/250615/` — scraped card data (`Results.csv`), seeded into SQLite on first run
