import 'package:flutter/material.dart';
import '../data/card_repository.dart';
import '../models/TCGCard.dart';
import '../data/database.dart'; // To get SetRow for filters
import 'widgets/filter_modal.dart';
import 'dart:async';

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  final int _pageSize = 20;
  int _offset = 0;
  bool _isLoading = false;
  bool _hasMore = true;

  List<TCGCard> _cards = [];
  final ScrollController _scrollController = ScrollController();

  String? _searchQuery;
  String? _selectedSetCode;
  List<String> _selectedClasses = [];
  List<String> _selectedRarities = [];
  List<String> _selectedCardTypes = [];
  List<SetRow> _availableSets = [];

  // New Filters
  String? _selectedTitle;
  String? _selectedSubtype;
  String? _selectedKeyword;
  bool _excludeSameName = false;
  List<int> _selectedCosts = [];
  bool _cost8Plus = false;
  int? _minAttack;
  int? _maxAttack;
  int? _minDefense;
  int? _maxDefense;

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _loadSets();
    _fetchCards();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 && !_isLoading && _hasMore) {
        _fetchCards();
      }
    });
  }

  Future<void> _loadSets() async {
    final sets = await cardRepository.getAllSetsList();
    setState(() {
      _availableSets = sets;
    });
  }

  Future<void> _fetchCards() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final newCards = await cardRepository.getPagedCards(
        _pageSize, 
        _offset, 
        query: _searchQuery, 
        setCode: _selectedSetCode,
        classes: _selectedClasses,
        rarities: _selectedRarities,
        cardTypes: _selectedCardTypes,
        costs: _selectedCosts,
        cost8Plus: _cost8Plus,
        minAttack: _minAttack,
        maxAttack: _maxAttack,
        minDefense: _minDefense,
        maxDefense: _maxDefense,
        subtype: _selectedSubtype,
        title: _selectedTitle,
        keyword: _selectedKeyword,
        excludeSameName: _excludeSameName,
      );

      setState(() {
        _offset += newCards.length;
        _cards.addAll(newCards);
        _hasMore = newCards.length == _pageSize;
      });
    } catch (e) {
      // Handle error visually if necessary
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _searchQuery = query;
        _cards.clear();
        _offset = 0;
        _hasMore = true;
      });
      _fetchCards();
    });
  }

  Future<void> _openFilterModal() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.85,
          child: FilterModal(
            initialSetCode: _selectedSetCode,
            initialClasses: _selectedClasses,
            initialRarities: _selectedRarities,
            initialCardTypes: _selectedCardTypes,
            availableSets: _availableSets,
            initialTitle: _selectedTitle,
            initialSubtype: _selectedSubtype,
            initialKeyword: _selectedKeyword,
            initialExcludeSameName: _excludeSameName,
            initialCosts: _selectedCosts,
            initialCost8Plus: _cost8Plus,
            initialMinAttack: _minAttack,
            initialMaxAttack: _maxAttack,
            initialMinDefense: _minDefense,
            initialMaxDefense: _maxDefense,
          ),
        );
      },
    );

    if (result != null) {
      setState(() {
        _selectedSetCode = result['setCode'] as String?;
        _selectedClasses = result['classes'] as List<String>;
        _selectedRarities = result['rarities'] as List<String>;
        _selectedCardTypes = result['cardTypes'] as List<String>;
        
        _selectedTitle = result['title'] as String?;
        _selectedSubtype = result['subtype'] as String?;
        _selectedKeyword = result['keyword'] as String?;
        _excludeSameName = result['excludeSameName'] as bool;
        _selectedCosts = result['costs'] as List<int>;
        _cost8Plus = result['cost8Plus'] as bool;
        _minAttack = result['minAttack'] as int?;
        _maxAttack = result['maxAttack'] as int?;
        _minDefense = result['minDefense'] as int?;
        _maxDefense = result['maxDefense'] as int?;

        _cards.clear();
        _offset = 0;
        _hasMore = true;
      });
      _fetchCards();
    }
  }

  void _resetAndFetch() {
    setState(() {
      _offset = 0;
      _cards.clear();
      _hasMore = true;
    });
    _fetchCards();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Filter Header
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Search by Name, Text, or ID',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: _onSearchChanged,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: IconButton(
                  icon: const Icon(Icons.tune),
                  onPressed: _openFilterModal,
                  tooltip: 'Filters',
                ),
              ),
            ],
          ),
        ),
        
        // Dynamic List
        Expanded(
          child: _cards.isEmpty && !_isLoading
              ? const Center(child: Text('No cards found.'))
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: _cards.length + (_hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _cards.length) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 32.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    final card = _cards[index];
                    return CardListItem(card: card);
                  },
                ),
        ),
      ],
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