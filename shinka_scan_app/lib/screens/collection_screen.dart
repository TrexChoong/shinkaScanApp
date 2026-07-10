import 'package:flutter/material.dart';
import '../test_data.dart';   
import '../models/TCGCard.dart';
import '../data/card_repository.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<List<TCGCard>>(
            stream: cardRepository.watchUserCollection(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final userCollection = snapshot.data ?? [];
              if (userCollection.isEmpty) {
                return const Center(child: Text('Your collection is empty.'));
              }
              return ListView.builder(
                itemCount: userCollection.length,
                itemBuilder: (context, index) {
                  final card = userCollection[index];
                  return ListTile(
                    leading: card.imageUrl.isNotEmpty ? Image.network(card.imageUrl, width: 40) : const Icon(Icons.credit_card),
                    title: Text(card.name),
                    subtitle: Text('Set: ${card.set}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await cardRepository.removeFromCollection(card);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${card.name} removed from collection')),
                          );
                        }
                      },
                    ),
                    // Add more details or actions as needed
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}