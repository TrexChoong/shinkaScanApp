import 'package:flutter/material.dart';
import '../test_data.dart';   
import '../models/TCGCard.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  List<TCGCard> userCollection = []; // Initially empty collection

  void _addCardToCollection(TCGCard card) {
    setState(() {
      userCollection.add(card);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: userCollection.isEmpty
              ? const Center(child: Text('Your collection is empty.'))
              : ListView.builder(
                  itemCount: userCollection.length,
                  itemBuilder: (context, index) {
                    final card = userCollection[index];
                    return ListTile(
                      title: Text(card.name),
                      subtitle: Text('Set: ${card.set}'),
                      // Add more details or actions as needed
                    );
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              // Implement logic to add a card to the collection
              // This could involve a dialog, search, or OCR integration later
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // Simple example to add the first sample card
                  return AlertDialog(
                    title: const Text('Add Card'),
                    content: const Text('Do you want to add Example Card 1 to your collection?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Add'),
                        onPressed: () {
                          // In a real app, you'd have a way to select the card
                          _addCardToCollection(TestData.sampleCards.first);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Add Card to Collection'),
          ),
        ),
      ],
    );
  }
}