import 'package:drift/drift.dart';

@DataClassName('CardRow')
class Cards extends Table {
  IntColumn get id => integer()();
  TextColumn get cardno => text()();
  TextColumn get setCode => text()();
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
        {setCode, cardno},
      ];
}
