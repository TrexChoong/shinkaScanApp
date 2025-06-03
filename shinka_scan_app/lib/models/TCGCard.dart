class TCGCard {
  final String id;
  final String cardno;
  final String expansion;
  final String name;
  final String imageUrl;
  final String detailPageUrl;
  final String set;
  final String rarity;
  final String cardClass;
  final String cardType;
  final String cardSubtype;
  final int? cost;
  final int? attack;
  final int? defense;
  final String? cardText;
  final String? illustrator;
  // Add other relevant card details
  TCGCard({
    required this.id,
    required this.cardno,
    required this.expansion,
    required this.name,
    required this.imageUrl,
    required this.detailPageUrl,
    required this.set,
    required this.rarity,
    required this.cardClass,
    required this.cardType,
    required this.cardSubtype,
    this.cost,
    this.attack,
    this.defense,
    this.cardText,
    this.illustrator,
  });
}