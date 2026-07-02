import 'package:csv/csv.dart';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'database.dart';

const cardsCsvAsset = 'DB/250615/Results.csv';

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

List<CardsCompanion> parseCardsCsv(String raw) {
  final rows = const CsvToListConverter(eol: '\n').convert(raw);
  if (rows.isEmpty) return const [];

  final header = rows.first.map((e) => e.toString()).toList();
  int col(String name) => header.indexOf(name);

  final idIdx = col('id');
  final cardnoIdx = col('cardno');
  final expansionIdx = col('expansion');
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
      expansion: cell(row, expansionIdx),
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
