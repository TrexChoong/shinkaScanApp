import 'package:drift/drift.dart';

@DataClassName('SetRow')
class Sets extends Table {
  TextColumn get setCode => text()();
  TextColumn get japaneseName => text()();
  TextColumn get type => text().nullable()();
  TextColumn get releaseDate => text().nullable()();

  @override
  Set<Column> get primaryKey => {setCode};
}
