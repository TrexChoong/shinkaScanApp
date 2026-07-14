import 'package:drift/drift.dart';

@DataClassName('UserCollectionRow')
class UserCollections extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get cardId => integer()();
  IntColumn get quantity => integer().withDefault(const Constant(1))();
  DateTimeColumn get addedAt => dateTime().nullable()();
}
