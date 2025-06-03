import 'package:flutter/material.dart';
import '../test_data.dart';
import '../models/booster.dart';
import 'cards_screen.dart';

class BoostersScreen extends StatelessWidget {
  const BoostersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Booster> boosters = TestData.sampleBoosters;
    return ListView.builder(
      itemCount: boosters.length,
      itemBuilder: (context, index) {
        final booster = boosters[index];
        return ExpansionTile(
          title: Text(booster.name, style: Theme.of(context).textTheme.titleMedium),
          leading: SizedBox(
            width: 50,
            height: 50,
            child: Image.network(
              booster.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Icon(Icons.card_giftcard));
              },
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Possible Cards:'),
                  ...booster.possibleCards.map((card) => CardListItem(card: card)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}