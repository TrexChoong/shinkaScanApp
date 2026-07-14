import 'package:flutter/material.dart';
import '../../data/database.dart';

class FilterModal extends StatefulWidget {
  final String? initialSetCode;
  final List<String> initialClasses;
  final List<String> initialRarities;
  final List<String> initialCardTypes;
  final List<SetRow> availableSets;
  
  // New Filters
  final String? initialTitle;
  final String? initialSubtype;
  final String? initialKeyword;
  final bool initialExcludeSameName;
  final List<int> initialCosts;
  final bool initialCost8Plus;
  final int? initialMinAttack;
  final int? initialMaxAttack;
  final int? initialMinDefense;
  final int? initialMaxDefense;

  const FilterModal({
    super.key,
    this.initialSetCode,
    required this.initialClasses,
    required this.initialRarities,
    required this.initialCardTypes,
    required this.availableSets,
    this.initialTitle,
    this.initialSubtype,
    this.initialKeyword,
    this.initialExcludeSameName = false,
    required this.initialCosts,
    this.initialCost8Plus = false,
    this.initialMinAttack,
    this.initialMaxAttack,
    this.initialMinDefense,
    this.initialMaxDefense,
  });

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  String? _selectedSetCode;
  late Set<String> _selectedClasses;
  late Set<String> _selectedRarities;
  late Set<String> _selectedCardTypes;

  // New Filters
  String? _selectedTitle;
  String? _selectedSubtype;
  String? _selectedKeyword;
  late bool _excludeSameName;
  late Set<int> _selectedCosts;
  late bool _cost8Plus;
  int? _minAttack;
  int? _maxAttack;
  int? _minDefense;
  int? _maxDefense;

  // Static Lists
  static const List<String> _allClasses = [
    'エルフ', 'ロイヤル', 'ウィッチ', 'ドラゴン', 
    'ナイトメア', 'ビショップ', 'ニュートラル'
  ];

  static const List<String> _allCardTypes = [
    'フォロワー', 'エボルヴ', 'アドバンス', 'スペル', 
    'アミュレット', 'トークン', 'リーダー', 'EP', 'SEP'
  ];

  static const List<String> _allRarities = [
    'LG', 'GR', 'SR', 'BR', 'UR', 'SL', 'SP', 'SSP', 'プレミアム'
  ];

  static const List<String> _allTitles = [
    'ウマ娘 プリティーダービー',
    'アイドルマスター シンデレラガールズ',
    'カードファイト!! ヴァンガード',
    'プリンセスコネクト！Re:Dive',
  ];

  static const List<String> _allSubtypes = [
    'BNW', 'NIGHTMARE', '<ジオ・ゲヘナ>', '<ジオ・テオゴニア>', '<ジオ・ニヴルヘル>', 
    '<レイジ・レギオン>', 'かげろう', 'なかよし部', 'アイドル', 'アクアフォース', 
    'アサイラント', 'アナテマ', 'アナテマ・ドラゴニュート', 'アナテマ・先導', 
    'アナテマ・獣', 'アナテマ・魔法使い', 'アルカナ', 'アルカナ・エルフ族', 
    'アルカナ・ドラゴニュート',
  ];

  static const List<String> _allKeywords = [
    'ファンファーレ', 'ラストワード', '進化時', '超進化時', '攻撃時', 'クイック', 
    '起動', '進化', 'アドバンス起動', '威圧', 'オーラ', '指定攻撃', '守護', 
    '疾走', '突進', 'ドレイン', '必殺', 'コンボ', 'スペルチェイン',
  ];

  static const List<int> _statValues = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]; // For min/max Dropdowns

  @override
  void initState() {
    super.initState();
    _selectedSetCode = widget.initialSetCode;
    _selectedClasses = Set.from(widget.initialClasses);
    _selectedRarities = Set.from(widget.initialRarities);
    _selectedCardTypes = Set.from(widget.initialCardTypes);
    
    _selectedTitle = widget.initialTitle;
    _selectedSubtype = widget.initialSubtype;
    _selectedKeyword = widget.initialKeyword;
    _excludeSameName = widget.initialExcludeSameName;
    _selectedCosts = Set.from(widget.initialCosts);
    _cost8Plus = widget.initialCost8Plus;
    _minAttack = widget.initialMinAttack;
    _maxAttack = widget.initialMaxAttack;
    _minDefense = widget.initialMinDefense;
    _maxDefense = widget.initialMaxDefense;
  }

  void _resetFilters() {
    setState(() {
      _selectedSetCode = null;
      _selectedClasses.clear();
      _selectedRarities.clear();
      _selectedCardTypes.clear();
      
      _selectedTitle = null;
      _selectedSubtype = null;
      _selectedKeyword = null;
      _excludeSameName = false;
      _selectedCosts.clear();
      _cost8Plus = false;
      _minAttack = null;
      _maxAttack = null;
      _minDefense = null;
      _maxDefense = null;
    });
  }

  void _applyFilters() {
    Navigator.of(context).pop({
      'setCode': _selectedSetCode,
      'classes': _selectedClasses.toList(),
      'rarities': _selectedRarities.toList(),
      'cardTypes': _selectedCardTypes.toList(),
      'title': _selectedTitle,
      'subtype': _selectedSubtype,
      'keyword': _selectedKeyword,
      'excludeSameName': _excludeSameName,
      'costs': _selectedCosts.toList(),
      'cost8Plus': _cost8Plus,
      'minAttack': _minAttack,
      'maxAttack': _maxAttack,
      'minDefense': _minDefense,
      'maxDefense': _maxDefense,
    });
  }

  Widget _buildSection(String title, List<String> options, Set<String> selectedSet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: options.map((option) {
            final isSelected = selectedSet.contains(option);
            return FilterChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    selectedSet.add(option);
                  } else {
                    selectedSet.remove(option);
                  }
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildCostSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cost (コスト)',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: [
            ...List.generate(8, (index) {
              return FilterChip(
                label: Text(index.toString()),
                selected: _selectedCosts.contains(index),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      _selectedCosts.add(index);
                    } else {
                      _selectedCosts.remove(index);
                    }
                  });
                },
              );
            }),
            FilterChip(
              label: const Text('8+'),
              selected: _cost8Plus,
              onSelected: (bool selected) {
                setState(() {
                  _cost8Plus = selected;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDropdown<T>(String label, T? value, List<T> options, ValueChanged<T?> onChanged, {String Function(T)? displayString, bool isNullable = true}) {
    return DropdownButtonFormField<T?>(
      value: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items: [
        if (isNullable)
          const DropdownMenuItem(
            value: null,
            child: Text('指定なし (None)', overflow: TextOverflow.ellipsis),
          ),
        ...options.map((option) => DropdownMenuItem(
          value: option,
          child: Text(displayString != null ? displayString(option) : option.toString(), overflow: TextOverflow.ellipsis),
        )),
      ],
      onChanged: onChanged,
    );
  }

  Widget _buildRangeDropdown(String label, int? minValue, int? maxValue, ValueChanged<int?> onMinChanged, ValueChanged<int?> onMaxChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildDropdown<int>('Min', minValue, _statValues, onMinChanged),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('~'),
            ),
            Expanded(
              child: _buildDropdown<int>('Max', maxValue, _statValues, onMaxChanged),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 24.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filter Cards',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection('Class (クラス)', _allClasses, _selectedClasses),
                  
                  const SizedBox(height: 8),
                  _buildDropdown<String>('Title (タイトル)', _selectedTitle, _allTitles, (val) => setState(() => _selectedTitle = val)),
                  
                  const SizedBox(height: 16),
                  _buildDropdown<String>('Set (収録商品)', _selectedSetCode, widget.availableSets.map((e) => e.setCode).toList(), (val) => setState(() => _selectedSetCode = val), displayString: (val) {
                    return widget.availableSets.firstWhere((s) => s.setCode == val).japaneseName;
                  }),
                  
                  const SizedBox(height: 16),
                  _buildCostSection(),
                  
                  _buildSection('Card Type (カード種類)', _allCardTypes, _selectedCardTypes),
                  _buildSection('Rarity (レアリティ)', _allRarities, _selectedRarities),
                  
                  _buildRangeDropdown('Attack (攻撃力)', _minAttack, _maxAttack, (val) => setState(() => _minAttack = val), (val) => setState(() => _maxAttack = val)),
                  _buildRangeDropdown('Defense (体力)', _minDefense, _maxDefense, (val) => setState(() => _minDefense = val), (val) => setState(() => _maxDefense = val)),
                  
                  _buildDropdown<String>('Type (タイプ)', _selectedSubtype, _allSubtypes, (val) => setState(() => _selectedSubtype = val)),
                  const SizedBox(height: 16),
                  
                  _buildDropdown<String>('Keyword (キーワード能力)', _selectedKeyword, _allKeywords, (val) => setState(() => _selectedKeyword = val)),
                  const SizedBox(height: 16),

                  CheckboxListTile(
                    title: const Text('Exclude same name cards (同名カードを除く)'),
                    value: _excludeSameName,
                    onChanged: (val) => setState(() => _excludeSameName = val ?? false),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _resetFilters,
                  child: const Text('Reset'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: FilledButton(
                  onPressed: _applyFilters,
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
