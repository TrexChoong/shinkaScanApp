import 'TCGCard.dart';

class Booster {
  final String id;
  final String name;
  final List<TCGCard> possibleCards;
  final String imageUrl;
  // Add other relevant booster details
  Booster({
    required this.id,
    required this.name,
    required this.possibleCards,
    required this.imageUrl,
  });
}