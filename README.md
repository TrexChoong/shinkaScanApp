# ShinkaScan

A physical card game companion app. Point your camera at a card, and ShinkaScan reads the serial number (e.g. `AE-086`), looks the card up in a local database, and shows you what it is — with market pricing and direct player-to-player trading on the roadmap.

The long-term goal is to **promote trading by eliminating middlemen**: instead of listing cards for sale on a marketplace, ShinkaScan will match collectors whose want-lists and for-trade lists complement each other, so they can swap cards directly.

## How it works

```
📷 Scan card → 🔤 OCR extracts serial (AE-086) → 🗃️ SQLite lookup → 🃏 Card details
                                                                      (→ 💴 price → 🤝 trade)
```

- **OCR scanning** — Google ML Kit text recognition on mobile, with a web camera fallback via JS interop
- **Card database** — a [drift](https://drift.simonbinder.eu/) (SQLite) database seeded from a local `DB/<date>/Results.csv`. **The CSV is not included in this repo**, so provide your own to seed the DB
- **Collection tracking** — keep a record of the cards you own

## Project structure

```
shinka_scan_app/
├── lib/
│   ├── data/          # drift database, CSV seeder, card repository
│   ├── models/        # TCGCard, Booster
│   ├── screens/       # Cards, Boosters, Collection, OCR scan
│   ├── services/      # OCR service (mobile / web / stub via conditional imports)
│   └── ui/            # shared widgets
├── DB/250615/         # db_init.sql schema (tracked); Results.csv seed data (local only, gitignored)
└── test/
```

## Getting started

Requires the [Flutter SDK](https://docs.flutter.dev/get-started/install) (Dart >= 3.4.3).

```sh
cd shinka_scan_app
flutter pub get
dart run build_runner build   # regenerate drift code after schema changes
flutter run                   # pick an Android/iOS/desktop device
```

> **Seed data:** the card database is seeded from `shinka_scan_app/DB/<date>/Results.csv`, which is **not** included in this repo. Provide your own before running, or the card DB will be empty.

> **Note:** Flutter **web** cannot open the card database yet — it needs `sqlite3.wasm` and a compiled drift worker in `web/` ([#1](https://github.com/TrexChoong/shinkaScanApp/issues/1)). Run on mobile or desktop for now.

## Roadmap

Work is planned across four milestones. The full picture lives in three places:

- **[master_development_plan.md](master_development_plan.md)** — component map and week-by-week schedule (July 2026 → February 2027)
- **[Project board](https://github.com/users/TrexChoong/projects/3)** — live tracking; the Roadmap view shows the scheduled timeline
- **[Milestones](https://github.com/TrexChoong/shinkaScanApp/milestones)** — release progress

| Milestone | Theme | Target |
|---|---|---|
| **M0 – Foundation** | Scan → card lookup end-to-end on real data; robust OCR; search; card relationships; offline images | Jul 2026 |
| **M1 – Card pricing** | Market prices on scan results & card detail, refreshed daily; price history; collection value | Sep 2026 |
| **M2 – Trading MVP** | Trading backend, accounts, for-trade/want lists, mutual-match discovery, propose/accept trades, trade completion | Dec 2026 |
| **M3 – Trust & community** | Trader reputation, in-app messaging, blocking & dispute handling | Feb 2027 |

Issues follow a `feature`/`bug`/`spike:*` + `area:*` label taxonomy; tasks of 3+ days carry sub-issues, and ordering is encoded as native GitHub "blocked by" dependencies — so "what can I work on next" is just the issues with no open blockers.

## License

[MIT](LICENSE)
