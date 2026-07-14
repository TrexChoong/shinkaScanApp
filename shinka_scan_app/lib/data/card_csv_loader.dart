import 'package:csv/csv.dart';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'database.dart';

const cardsCsvAsset = 'DB/Results.csv';
const setsCsvAsset = 'DB/Sets.csv';

int? _parseInt(String value) =>
    value == 'NULL' || value.isEmpty ? null : int.tryParse(value);

String? _parseText(String value) =>
    value == 'NULL' || value.isEmpty ? null : value;

DateTime? _parseDateTime(String value) =>
    value == 'NULL' || value.isEmpty ? null : DateTime.tryParse(value);

/// Parses the scraped card CSV (bundled as an asset) into rows ready to
/// insert into the [Cards] table.
Future<List<CardsCompanion>> loadCardsFromCsvAsset() async {
  final raw = await rootBundle.loadString(cardsCsvAsset);
  return parseCardsCsv(raw);
}

Future<List<SetsCompanion>> loadSetsFromCsvAsset() async {
  final raw = await rootBundle.loadString(setsCsvAsset);
  return parseSetsCsv(raw);
}

List<CardsCompanion> parseCardsCsv(String raw) {
  final rows = const CsvToListConverter(eol: '\n').convert(raw);
  if (rows.isEmpty) return const [];

  final header = rows.first.map((e) => e.toString()).toList();
  int col(String name) => header.indexOf(name);

  final idIdx = col('id');
  final cardnoIdx = col('cardno');
  final setCodeIdx = col('expansion');
  final japaneseNameIdx = col('japanese_name');
  final imageUrlIdx = col('image_url');
  final detailPageUrlIdx = col('detail_page_url');
  final japaneseSetNameIdx = col('japanese_set_name');
  final cardClassIdx = col('card_class');
  final cardTypeIdx = col('card_type');
  final cardSubtypeIdx = col('card_subtype');
  final rarityIdx = col('rarity');
  final costIdx = col('cost');
  final attackIdx = col('attack');
  final defenseIdx = col('defense');
  final cardTextIdx = col('card_text');
  final illustratorIdx = col('illustrator');
  final lastScrapedIdx = col('last_scraped_details_at');
  final createdAtIdx = col('created_at');
  final updatedAtIdx = col('updated_at');

  String cell(List<dynamic> row, int idx) => idx == -1 ? '' : row[idx].toString();

  return rows.skip(1).where((row) => row.length >= header.length).map((row) {
    return CardsCompanion.insert(
      id: Value(int.parse(cell(row, idIdx))),
      cardno: cell(row, cardnoIdx),
      setCode: cell(row, setCodeIdx),
      japaneseName: Value(_parseText(cell(row, japaneseNameIdx))),
      imageUrl: Value(_parseText(cell(row, imageUrlIdx))),
      detailPageUrl: Value(_parseText(cell(row, detailPageUrlIdx))),
      japaneseSetName: Value(_parseText(cell(row, japaneseSetNameIdx))),
      cardClass: Value(_parseText(cell(row, cardClassIdx))),
      cardType: Value(_parseText(cell(row, cardTypeIdx))),
      cardSubtype: Value(_parseText(cell(row, cardSubtypeIdx))),
      rarity: Value(_parseText(cell(row, rarityIdx))),
      cost: Value(_parseInt(cell(row, costIdx))),
      attack: Value(_parseInt(cell(row, attackIdx))),
      defense: Value(_parseInt(cell(row, defenseIdx))),
      cardText: Value(_parseText(cell(row, cardTextIdx))),
      illustrator: Value(_parseText(cell(row, illustratorIdx))),
      lastScrapedDetailsAt: Value(_parseDateTime(cell(row, lastScrapedIdx))),
      createdAt: Value(_parseDateTime(cell(row, createdAtIdx))),
      updatedAt: Value(_parseDateTime(cell(row, updatedAtIdx))),
    );
  }).toList();
}

List<SetsCompanion> parseSetsCsv(String raw) {
  final rows = const CsvToListConverter(eol: '\n').convert(raw);
  if (rows.isEmpty) return const [];

  final header = rows.first.map((e) => e.toString()).toList();
  int col(String name) => header.indexOf(name);

  final setCodeIdx = col('set_code');
  final japaneseNameIdx = col('japanese_name');
  final typeIdx = col('type');
  final releaseDateIdx = col('release_date');

  String cell(List<dynamic> row, int idx) => idx == -1 ? '' : row[idx].toString();

  return rows.skip(1).where((row) => row.length >= header.length).map((row) {
    return SetsCompanion.insert(
      setCode: cell(row, setCodeIdx),
      japaneseName: cell(row, japaneseNameIdx),
      type: Value(_parseText(cell(row, typeIdx))),
      releaseDate: Value(_parseText(cell(row, releaseDateIdx))),
    );
  }).toList();
}
