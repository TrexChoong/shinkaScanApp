import 'package:flutter/material.dart';
import '../test_data.dart';
import '../models/TCGCard.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<TCGCard> cards = TestData.sampleCards; // Use test data as fallback
    return ListView.builder(
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];
        return CardListItem(card: card);
      },
    );
  }
}

class CardListItem extends StatelessWidget {
  final TCGCard card;
  const CardListItem({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 120,
            child: Image.network(
              card.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Icon(Icons.image_not_supported));
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(card.name, style: Theme.of(context).textTheme.titleMedium),
                Text('Set: ${card.set}'),
                Text('Rarity: ${card.rarity}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}