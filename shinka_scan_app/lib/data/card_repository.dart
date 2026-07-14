import '../models/TCGCard.dart';
import '../models/booster.dart';
import 'card_csv_loader.dart';
import 'database.dart';
import 'dart:math';

class FuzzySearchResult {
  final TCGCard? exactMatch;
  final List<TCGCard> suggestions;

  FuzzySearchResult({this.exactMatch, this.suggestions = const []});
}

class CardRepository {
  CardRepository(this._db);

  final AppDatabase _db;

  Future<void> _ensureSeeded() async {
    final count = await _db.cardCount();
    if (count == 0) {
      final rows = await loadCardsFromCsvAsset();
      await _db.replaceAllCards(rows);
      
      try {
        final expRows = await loadSetsFromCsvAsset();
        await _db.replaceAllSets(expRows);
      } catch (e) {
        // Sets file might not exist yet if scraper hasn't run
      }
    }
  }

  Future<List<TCGCard>> getAllCards() async {
    await _ensureSeeded();
    final rows = await _db.allCards();
    return rows.map(_toTcgCard).toList();
  }

  Future<List<SetRow>> getAllSetsList() async {
    await _ensureSeeded();
    return await _db.allSets();
  }

  Future<List<TCGCard>> getPagedCards(
    int limit, 
    int offset, {
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
    await _ensureSeeded();
    final rows = await _db.getPagedCards(
      limit, 
      offset, 
      query: query, 
      setCode: setCode,
      classes: classes,
      rarities: rarities,
      cardTypes: cardTypes,
      costs: costs,
      cost8Plus: cost8Plus,
      minAttack: minAttack,
      maxAttack: maxAttack,
      minDefense: minDefense,
      maxDefense: maxDefense,
      subtype: subtype,
      title: title,
      keyword: keyword,
      excludeSameName: excludeSameName,
    );
    return rows.map(_toTcgCard).toList();
  }

  Future<List<Booster>> getAllBoosters() async {
    await _ensureSeeded();
    final setRows = await _db.allSets();
    final allCardsList = await getAllCards();

    return setRows.map((setRow) {
      final possibleCards = allCardsList.where((c) => c.setCode == setRow.setCode).toList();
      return Booster(
        id: setRow.setCode,
        name: setRow.japaneseName,
        possibleCards: possibleCards,
        imageUrl: 'https://shadowverse-evolve.com/wordpress/wp-content/uploads/cardimg/${setRow.setCode}-001.png', // Fallback or logic for image
      );
    }).toList();
  }

  Future<bool> addToCollection(TCGCard card) async {
    return await _db.addCardToUserCollection(int.parse(card.id));
  }

  Future<void> removeFromCollection(TCGCard card) async {
    await _db.removeCardFromUserCollection(int.parse(card.id));
  }

  Stream<List<TCGCard>> watchUserCollection() {
    return _db.watchUserCollectionCards().map((rows) {
      return rows.map(_toTcgCard).toList();
    });
  }

  Future<TCGCard?> getByCardno(String setCode, String cardno) async {
    final allCardsList = await getAllCards();
    try {
      return allCardsList.firstWhere((c) => c.setCode == setCode && c.cardno == cardno);
    } catch(e) {
      return null;
    }
  }

  TCGCard _toTcgCard(CardRow row) {
    final setName = (row.japaneseSetName != null && row.japaneseSetName!.isNotEmpty)
        ? row.japaneseSetName!
        : row.setCode;
        
    return TCGCard(
        id: row.id.toString(),
        cardno: row.cardno,
        setCode: row.setCode,
        name: row.japaneseName ?? row.cardno,
        imageUrl: row.imageUrl ?? '',
        detailPageUrl: row.detailPageUrl ?? '',
        set: setName,
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
  Future<FuzzySearchResult> searchCardsByFuzzyId(String ocrId) async {
    final allCardsList = await getAllCards();
    
    String cleanStr(String s) => s.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toUpperCase();
    
    final cleanOcrId = cleanStr(ocrId);
    
    TCGCard? exactMatch;
    List<TCGCard> distance1 = [];
    List<TCGCard> distance2 = [];

    for (var card in allCardsList) {
      final cleanCardNo = cleanStr(card.cardno);
      final dist = _levenshteinDistance(cleanOcrId, cleanCardNo);
      
      if (dist == 0) {
        exactMatch = card; // we found an exact match
      } else if (dist == 1) {
        distance1.add(card);
      } else if (dist == 2) {
        distance2.add(card);
      }
    }
    
    // If no exact match but we have close suggestions
    List<TCGCard> suggestions = [...distance1, ...distance2];
    
    return FuzzySearchResult(
      exactMatch: exactMatch,
      suggestions: suggestions,
    );
  }

  int _levenshteinDistance(String s, String t) {
    if (s == t) return 0;
    if (s.isEmpty) return t.length;
    if (t.isEmpty) return s.length;

    List<int> v0 = List<int>.generate(t.length + 1, (i) => i);
    List<int> v1 = List<int>.filled(t.length + 1, 0);

    for (int i = 0; i < s.length; i++) {
      v1[0] = i + 1;
      for (int j = 0; j < t.length; j++) {
        int cost = (s[i] == t[j]) ? 0 : 1;
        v1[j + 1] = min(v1[j] + 1, min(v0[j + 1] + 1, v0[j] + cost));
      }
      for (int j = 0; j <= t.length; j++) {
        v0[j] = v1[j];
      }
    }
    return v1[t.length];
  }
}

final AppDatabase appDatabase = AppDatabase();
final CardRepository cardRepository = CardRepository(appDatabase);
