import '../models/TCGCard.dart';
import 'card_csv_loader.dart';
import 'database.dart';

class CardRepository {
  CardRepository(this._db);

  final AppDatabase _db;

  Future<void> _ensureSeeded() async {
    final count = await _db.cardCount();
    if (count == 0) {
      final rows = await loadCardsFromCsvAsset();
      await _db.replaceAllCards(rows);
    }
  }

  Future<List<TCGCard>> getAllCards() async {
    await _ensureSeeded();
    final rows = await _db.allCards();
    return rows.map(_toTcgCard).toList();
  }

  TCGCard _toTcgCard(CardRow row) => TCGCard(
        id: row.id.toString(),
        cardno: row.cardno,
        expansion: row.expansion,
        name: row.japaneseName ?? row.cardno,
        imageUrl: row.imageUrl ?? '',
        detailPageUrl: row.detailPageUrl ?? '',
        set: row.japaneseSetName ?? '',
        rarity: row.rarity ?? '',
        cardClass: row.cardClass ?? '',
        cardType: row.cardType ?? '',
        cardSubtype: row.cardSubtype ?? '',
        cost: row.cost,
        attack: row.attack,
        defense: row.defense,
        cardText: row.cardText,
        illustrator: row.illustrator,
      );
}

final AppDatabase appDatabase = AppDatabase();
final CardRepository cardRepository = CardRepository(appDatabase);
