import 'package:flutter/material.dart';
import '../data/card_repository.dart';
import '../models/booster.dart';
import 'cards_screen.dart';

class BoostersScreen extends StatefulWidget {
  const BoostersScreen({super.key});

  @override
  State<BoostersScreen> createState() => _BoostersScreenState();
}

class _BoostersScreenState extends State<BoostersScreen> {
  late final Future<List<Booster>> _boostersFuture = cardRepository.getAllBoosters();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Booster>>(
      future: _boostersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Failed to load boosters: ${snapshot.error}'));
        }
        final boosters = snapshot.data ?? const [];
        if (boosters.isEmpty) {
          return const Center(child: Text('No boosters found.'));
        }
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
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Icon(Icons.card_giftcard));
                  },
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Possible Cards:'),
                      const SizedBox(height: 8),
                      // Use a fixed-height horizontal ListView.builder to lazily load images
                      // and prevent saturating the network with concurrent HTTP requests.
                      SizedBox(
                        height: 180,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: booster.possibleCards.length,
                          itemBuilder: (context, index) {
                            final card = booster.possibleCards[index];
                            return Container(
                              width: 100,
                              margin: const EdgeInsets.only(right: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 140,
                                    width: 100,
                                    child: Image.network(
                                      card.imageUrl,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return const Center(
                                          child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(strokeWidth: 2),
                                          ),
                                        );
                                      },
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Center(child: Icon(Icons.image_not_supported));
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    card.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}