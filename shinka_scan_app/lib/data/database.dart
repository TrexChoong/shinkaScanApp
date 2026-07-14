import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/cards.dart';
import 'tables/user_collections.dart';
import 'tables/sets.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Cards, UserCollections, Sets])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.createTable(userCollections);
        }
        if (from < 4) {
          await m.createTable(sets);
        }
        if (from < 5) {
          await m.issueCustomQuery('DROP TABLE IF EXISTS cards;');
          await m.createTable(cards);
        }
      },
    );
  }

  Future<int> cardCount() async {
    final row = await (selectOnly(cards)..addColumns([cards.id.count()]))
        .getSingle();
    return row.read(cards.id.count()) ?? 0;
  }

  Future<List<CardRow>> allCards() => select(cards).get();
  
  Future<List<CardRow>> getPagedCards(int limit, int offset, {
    String? query,
    String? setCode,
    List<String>? classes,
    List<String>? rarities,
    List<String>? cardTypes,
    List<int>? costs,
    bool? cost8Plus,
    int? minAttack,
    int? maxAttack,
    int? minDefense,
    int? maxDefense,
    String? subtype,
    String? title,
    String? keyword,
    bool excludeSameName = false,
  }) async {
    var statement = select(cards);
    
    if (setCode != null && setCode.isNotEmpty) {
      statement.where((c) => c.setCode.equals(setCode));
    }

    if (classes != null && classes.isNotEmpty) {
      statement.where((c) => c.cardClass.isIn(classes));
    }

    if (rarities != null && rarities.isNotEmpty) {
      statement.where((c) => c.rarity.isIn(rarities));
    }

    if (cardTypes != null && cardTypes.isNotEmpty) {
      statement.where((c) => c.cardType.isIn(cardTypes));
    }

    if (costs != null && costs.isNotEmpty) {
      if (cost8Plus == true) {
        statement.where((c) => c.cost.isIn(costs) | c.cost.isBiggerOrEqualValue(8));
      } else {
        statement.where((c) => c.cost.isIn(costs));
      }
    } else if (cost8Plus == true) {
      statement.where((c) => c.cost.isBiggerOrEqualValue(8));
    }

    if (minAttack != null) {
      statement.where((c) => c.attack.isBiggerOrEqualValue(minAttack));
    }
    if (maxAttack != null) {
      statement.where((c) => c.attack.isSmallerOrEqualValue(maxAttack));
    }

    if (minDefense != null) {
      statement.where((c) => c.defense.isBiggerOrEqualValue(minDefense));
    }
    if (maxDefense != null) {
      statement.where((c) => c.defense.isSmallerOrEqualValue(maxDefense));
    }

    if (subtype != null && subtype.isNotEmpty) {
      statement.where((c) => c.cardSubtype.equals(subtype));
    }

    if (title != null && title.isNotEmpty) {
      statement.where((c) => c.japaneseSetName.like('%$title%'));
    }

    if (keyword != null && keyword.isNotEmpty) {
      statement.where((c) => c.cardText.like('%$keyword%'));
    }
    
    if (query != null && query.isNotEmpty) {
      final queryExpr = '%$query%';
      // Use drift's bitwise OR operator for multiple conditions
      statement.where((c) => c.japaneseName.like(queryExpr) | c.cardText.like(queryExpr) | c.cardno.like(queryExpr));
    }
    
    if (excludeSameName) {
      statement.orderBy([(t) => OrderingTerm(expression: t.id)]);
      final allMatching = await statement.get();
      final uniqueCards = <CardRow>[];
      
      final groupedByName = <String, List<CardRow>>{};
      for (final c in allMatching) {
        final name = c.japaneseName ?? c.cardno;
        groupedByName.putIfAbsent(name, () => []).add(c);
      }
      
      for (final name in groupedByName.keys) {
        final cardsForName = groupedByName[name]!;
        final printings = <String, List<CardRow>>{};
        
        for (final c in cardsForName) {
          final printKey = '${c.setCode}_${c.rarity}';
          printings.putIfAbsent(printKey, () => []).add(c);
        }
        
        List<CardRow> getBestPrinting(Map<String, List<CardRow>> printings) {
          final printingsWithBoth = <List<CardRow>>[];
          for (final printing in printings.values) {
            final hasBase = printing.any((c) => !(c.cardType ?? '').contains('エボルヴ'));
            final hasEvolve = printing.any((c) => (c.cardType ?? '').contains('エボルヴ'));
            if (hasBase && hasEvolve) {
              printingsWithBoth.add(printing);
            }
          }

          final candidates = printingsWithBoth.isNotEmpty ? printingsWithBoth : printings.values.toList();
          
          final bpCandidates = candidates.where((p) => (p.first.setCode).startsWith('BP')).toList();
          if (bpCandidates.isNotEmpty) {
            return bpCandidates.first;
          }
          
          return candidates.first;
        }
        
        final selectedPrinting = getBestPrinting(printings);
        
        final seenTypes = <String>{};
        for (final c in selectedPrinting) {
          final type = c.cardType ?? '';
          if (!seenTypes.contains(type)) {
            seenTypes.add(type);
            uniqueCards.add(c);
          }
        }
      }
      
      uniqueCards.sort((a, b) => a.id.compareTo(b.id));
      if (offset >= uniqueCards.length) return [];
      final end = (offset + limit < uniqueCards.length) ? offset + limit : uniqueCards.length;
      return uniqueCards.sublist(offset, end);
    }

    statement.limit(limit, offset: offset);
    return statement.get();
  }

  Future<List<SetRow>> allSets() => select(sets).get();

  Future<void> replaceAllCards(List<CardsCompanion> rows) async {
    await batch((b) => b.insertAllOnConflictUpdate(cards, rows));
  }

  Future<void> replaceAllSets(List<SetsCompanion> rows) async {
    await batch((b) => b.insertAllOnConflictUpdate(sets, rows));
  }

  Future<bool> addCardToUserCollection(int cardId) async {
    final existing = await (select(userCollections)..where((t) => t.cardId.equals(cardId))).getSingleOrNull();
    if (existing != null) {
      return false; // Already exists
    } else {
      await into(userCollections).insert(
        UserCollectionsCompanion(
          cardId: Value(cardId),
          quantity: const Value(1),
          addedAt: Value(DateTime.now()),
        ),
      );
      return true;
    }
  }

  Future<void> removeCardFromUserCollection(int cardId) async {
    final existing = await (select(userCollections)..where((t) => t.cardId.equals(cardId))).getSingleOrNull();
    if (existing != null) {
      if (existing.quantity > 1) {
        await update(userCollections).replace(
          existing.copyWith(quantity: existing.quantity - 1),
        );
      } else {
        await (delete(userCollections)..where((t) => t.cardId.equals(cardId))).go();
      }
    }
  }

  Stream<List<CardRow>> watchUserCollectionCards() {
    final query = select(cards).join([
      innerJoin(userCollections, userCollections.cardId.equalsExp(cards.id)),
    ]);
    return query.watch().map((rows) {
      return rows.map((row) => row.readTable(cards)).toList();
    });
  }
}

QueryExecutor _openConnection() {
  return driftDatabase(
    name: 'shinka_cards',
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.dart.js'),
    ),
  );
}
