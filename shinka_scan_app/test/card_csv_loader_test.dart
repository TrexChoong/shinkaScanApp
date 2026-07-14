import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:shinka_scan_app/data/card_csv_loader.dart';

void main() {
  late String raw;

  setUpAll(() {
    raw = File('DB/Results.csv').readAsStringSync();
  });

  test('parses every logical data row from the scraped CSV', () {
    // 602 raw text lines - 1 header, minus ~44 records whose card_text
    // contains an embedded newline (so they span 2 raw lines but are 1 row).
    final rows = parseCardsCsv(raw);
    expect(rows, hasLength(557));
  });

  test('parses a known row, including multi-line card text', () {
    final rows = parseCardsCsv(raw);
    final row = rows.firstWhere((r) => r.cardno.value == 'BP02-003');

    expect(row.setCode.value, 'BP02');
    expect(row.japaneseName.value, '古き森の白狼');
    expect(row.rarity.value, 'LG');
    expect(row.cost.value, 7);
    expect(row.attack.value, 4);
    expect(row.defense.value, 4);
    expect(row.cardText.value, contains('【疾走】'));
    expect(row.cardText.value, contains('\n')); // preserved embedded newline
  });

  test('treats the literal "NULL" text as a real null, not a string', () {
    final rows = parseCardsCsv(raw);
    final row = rows.firstWhere((r) => r.cardno.value == 'BP01-005');

    expect(row.japaneseSetName.value, isNull);
    expect(row.cost.value, isNull);
    expect(row.attack.value, isNull);
    expect(row.defense.value, isNull);
  });

  test('every row has a unique (setCode, cardno) pair', () {
    final rows = parseCardsCsv(raw);
    final keys = rows.map((r) => '${r.setCode.value}-${r.cardno.value}').toSet();
    expect(keys, hasLength(rows.length));
  });
}
