import 'package:flutter/material.dart';
import '../data/card_repository.dart';
import '../models/TCGCard.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  late final Future<List<TCGCard>> _cardsFuture = cardRepository.getAllCards();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TCGCard>>(
      future: _cardsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Failed to load cards: ${snapshot.error}'));
        }
        final cards = snapshot.data ?? const [];
        if (cards.isEmpty) {
          return const Center(child: Text('No cards found.'));
        }
        return ListView.builder(
          itemCount: cards.length,
          itemBuilder: (context, index) {
            final card = cards[index];
            return CardListItem(card: card);
          },
        );
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