import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shinka_scan_app/data/card_csv_loader.dart';
import 'package:shinka_scan_app/data/card_repository.dart';
import 'package:shinka_scan_app/data/database.dart';

void main() {
  late AppDatabase db;
  late CardRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = CardRepository(db);
  });

  tearDown(() => db.close());

  test('seeds the in-memory db from the CSV asset and maps rows to TCGCard', () async {
    final raw = File('DB/250615/Results.csv').readAsStringSync();
    await db.replaceAllCards(parseCardsCsv(raw));

    final cards = await repo.getAllCards();

    expect(cards, hasLength(557));
    final card = cards.firstWhere((c) => c.cardno == 'BP02-003');
    expect(card.name, '古き森の白狼');
    expect(card.expansion, 'BP02');
    expect(card.rarity, 'LG');
    expect(card.cost, 7);
  });

  test('getAllCards does not duplicate rows when called twice', () async {
    final raw = File('DB/250615/Results.csv').readAsStringSync();
    await db.replaceAllCards(parseCardsCsv(raw));

    await repo.getAllCards();
    final second = await repo.getAllCards();

    expect(second, hasLength(557));
  });
}
