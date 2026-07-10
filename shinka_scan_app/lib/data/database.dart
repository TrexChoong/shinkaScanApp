import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

@DataClassName('CardRow')
class Cards extends Table {
  IntColumn get id => integer()();
  TextColumn get cardno => text()();
  TextColumn get expansion => text()();
  TextColumn get japaneseName => text().nullable()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get detailPageUrl => text().nullable()();
  TextColumn get japaneseSetName => text().nullable()();
  TextColumn get cardClass => text().nullable()();
  TextColumn get cardType => text().nullable()();
  TextColumn get cardSubtype => text().nullable()();
  TextColumn get rarity => text().nullable()();
  IntColumn get cost => integer().nullable()();
  IntColumn get attack => integer().nullable()();
  IntColumn get defense => integer().nullable()();
  TextColumn get cardText => text().nullable()();
  TextColumn get illustrator => text().nullable()();
  DateTimeColumn get lastScrapedDetailsAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {expansion, cardno},
      ];
}

@DataClassName('UserCollectionRow')
class UserCollections extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get cardId => integer()();
  IntColumn get quantity => integer().withDefault(const Constant(1))();
  DateTimeColumn get addedAt => dateTime().nullable()();
}

@DriftDatabase(tables: [Cards, UserCollections])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

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
      },
    );
  }

  Future<int> cardCount() async {
    final row = await (selectOnly(cards)..addColumns([cards.id.count()]))
        .getSingle();
    return row.read(cards.id.count()) ?? 0;
  }

  Future<List<CardRow>> allCards() => select(cards).get();

  Future<void> replaceAllCards(List<CardsCompanion> rows) async {
    await batch((b) => b.insertAllOnConflictUpdate(cards, rows));
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
