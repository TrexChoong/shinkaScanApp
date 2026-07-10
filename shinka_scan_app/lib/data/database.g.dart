// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CardsTable extends Cards with TableInfo<$CardsTable, CardRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _cardnoMeta = const VerificationMeta('cardno');
  @override
  late final GeneratedColumn<String> cardno = GeneratedColumn<String>(
      'cardno', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _expansionMeta =
      const VerificationMeta('expansion');
  @override
  late final GeneratedColumn<String> expansion = GeneratedColumn<String>(
      'expansion', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _japaneseNameMeta =
      const VerificationMeta('japaneseName');
  @override
  late final GeneratedColumn<String> japaneseName = GeneratedColumn<String>(
      'japanese_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _detailPageUrlMeta =
      const VerificationMeta('detailPageUrl');
  @override
  late final GeneratedColumn<String> detailPageUrl = GeneratedColumn<String>(
      'detail_page_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _japaneseSetNameMeta =
      const VerificationMeta('japaneseSetName');
  @override
  late final GeneratedColumn<String> japaneseSetName = GeneratedColumn<String>(
      'japanese_set_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cardClassMeta =
      const VerificationMeta('cardClass');
  @override
  late final GeneratedColumn<String> cardClass = GeneratedColumn<String>(
      'card_class', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cardTypeMeta =
      const VerificationMeta('cardType');
  @override
  late final GeneratedColumn<String> cardType = GeneratedColumn<String>(
      'card_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cardSubtypeMeta =
      const VerificationMeta('cardSubtype');
  @override
  late final GeneratedColumn<String> cardSubtype = GeneratedColumn<String>(
      'card_subtype', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _rarityMeta = const VerificationMeta('rarity');
  @override
  late final GeneratedColumn<String> rarity = GeneratedColumn<String>(
      'rarity', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<int> cost = GeneratedColumn<int>(
      'cost', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _attackMeta = const VerificationMeta('attack');
  @override
  late final GeneratedColumn<int> attack = GeneratedColumn<int>(
      'attack', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _defenseMeta =
      const VerificationMeta('defense');
  @override
  late final GeneratedColumn<int> defense = GeneratedColumn<int>(
      'defense', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _cardTextMeta =
      const VerificationMeta('cardText');
  @override
  late final GeneratedColumn<String> cardText = GeneratedColumn<String>(
      'card_text', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _illustratorMeta =
      const VerificationMeta('illustrator');
  @override
  late final GeneratedColumn<String> illustrator = GeneratedColumn<String>(
      'illustrator', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastScrapedDetailsAtMeta =
      const VerificationMeta('lastScrapedDetailsAt');
  @override
  late final GeneratedColumn<DateTime> lastScrapedDetailsAt =
      GeneratedColumn<DateTime>('last_scraped_details_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        cardno,
        expansion,
        japaneseName,
        imageUrl,
        detailPageUrl,
        japaneseSetName,
        cardClass,
        cardType,
        cardSubtype,
        rarity,
        cost,
        attack,
        defense,
        cardText,
        illustrator,
        lastScrapedDetailsAt,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cards';
  @override
  VerificationContext validateIntegrity(Insertable<CardRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cardno')) {
      context.handle(_cardnoMeta,
          cardno.isAcceptableOrUnknown(data['cardno']!, _cardnoMeta));
    } else if (isInserting) {
      context.missing(_cardnoMeta);
    }
    if (data.containsKey('expansion')) {
      context.handle(_expansionMeta,
          expansion.isAcceptableOrUnknown(data['expansion']!, _expansionMeta));
    } else if (isInserting) {
      context.missing(_expansionMeta);
    }
    if (data.containsKey('japanese_name')) {
      context.handle(
          _japaneseNameMeta,
          japaneseName.isAcceptableOrUnknown(
              data['japanese_name']!, _japaneseNameMeta));
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    }
    if (data.containsKey('detail_page_url')) {
      context.handle(
          _detailPageUrlMeta,
          detailPageUrl.isAcceptableOrUnknown(
              data['detail_page_url']!, _detailPageUrlMeta));
    }
    if (data.containsKey('japanese_set_name')) {
      context.handle(
          _japaneseSetNameMeta,
          japaneseSetName.isAcceptableOrUnknown(
              data['japanese_set_name']!, _japaneseSetNameMeta));
    }
    if (data.containsKey('card_class')) {
      context.handle(_cardClassMeta,
          cardClass.isAcceptableOrUnknown(data['card_class']!, _cardClassMeta));
    }
    if (data.containsKey('card_type')) {
      context.handle(_cardTypeMeta,
          cardType.isAcceptableOrUnknown(data['card_type']!, _cardTypeMeta));
    }
    if (data.containsKey('card_subtype')) {
      context.handle(
          _cardSubtypeMeta,
          cardSubtype.isAcceptableOrUnknown(
              data['card_subtype']!, _cardSubtypeMeta));
    }
    if (data.containsKey('rarity')) {
      context.handle(_rarityMeta,
          rarity.isAcceptableOrUnknown(data['rarity']!, _rarityMeta));
    }
    if (data.containsKey('cost')) {
      context.handle(
          _costMeta, cost.isAcceptableOrUnknown(data['cost']!, _costMeta));
    }
    if (data.containsKey('attack')) {
      context.handle(_attackMeta,
          attack.isAcceptableOrUnknown(data['attack']!, _attackMeta));
    }
    if (data.containsKey('defense')) {
      context.handle(_defenseMeta,
          defense.isAcceptableOrUnknown(data['defense']!, _defenseMeta));
    }
    if (data.containsKey('card_text')) {
      context.handle(_cardTextMeta,
          cardText.isAcceptableOrUnknown(data['card_text']!, _cardTextMeta));
    }
    if (data.containsKey('illustrator')) {
      context.handle(
          _illustratorMeta,
          illustrator.isAcceptableOrUnknown(
              data['illustrator']!, _illustratorMeta));
    }
    if (data.containsKey('last_scraped_details_at')) {
      context.handle(
          _lastScrapedDetailsAtMeta,
          lastScrapedDetailsAt.isAcceptableOrUnknown(
              data['last_scraped_details_at']!, _lastScrapedDetailsAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {expansion, cardno},
      ];
  @override
  CardRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CardRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      cardno: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cardno'])!,
      expansion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}expansion'])!,
      japaneseName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}japanese_name']),
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url']),
      detailPageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}detail_page_url']),
      japaneseSetName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}japanese_set_name']),
      cardClass: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}card_class']),
      cardType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}card_type']),
      cardSubtype: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}card_subtype']),
      rarity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rarity']),
      cost: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cost']),
      attack: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}attack']),
      defense: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}defense']),
      cardText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}card_text']),
      illustrator: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}illustrator']),
      lastScrapedDetailsAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}last_scraped_details_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $CardsTable createAlias(String alias) {
    return $CardsTable(attachedDatabase, alias);
  }
}

class CardRow extends DataClass implements Insertable<CardRow> {
  final int id;
  final String cardno;
  final String expansion;
  final String? japaneseName;
  final String? imageUrl;
  final String? detailPageUrl;
  final String? japaneseSetName;
  final String? cardClass;
  final String? cardType;
  final String? cardSubtype;
  final String? rarity;
  final int? cost;
  final int? attack;
  final int? defense;
  final String? cardText;
  final String? illustrator;
  final DateTime? lastScrapedDetailsAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const CardRow(
      {required this.id,
      required this.cardno,
      required this.expansion,
      this.japaneseName,
      this.imageUrl,
      this.detailPageUrl,
      this.japaneseSetName,
      this.cardClass,
      this.cardType,
      this.cardSubtype,
      this.rarity,
      this.cost,
      this.attack,
      this.defense,
      this.cardText,
      this.illustrator,
      this.lastScrapedDetailsAt,
      this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cardno'] = Variable<String>(cardno);
    map['expansion'] = Variable<String>(expansion);
    if (!nullToAbsent || japaneseName != null) {
      map['japanese_name'] = Variable<String>(japaneseName);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || detailPageUrl != null) {
      map['detail_page_url'] = Variable<String>(detailPageUrl);
    }
    if (!nullToAbsent || japaneseSetName != null) {
      map['japanese_set_name'] = Variable<String>(japaneseSetName);
    }
    if (!nullToAbsent || cardClass != null) {
      map['card_class'] = Variable<String>(cardClass);
    }
    if (!nullToAbsent || cardType != null) {
      map['card_type'] = Variable<String>(cardType);
    }
    if (!nullToAbsent || cardSubtype != null) {
      map['card_subtype'] = Variable<String>(cardSubtype);
    }
    if (!nullToAbsent || rarity != null) {
      map['rarity'] = Variable<String>(rarity);
    }
    if (!nullToAbsent || cost != null) {
      map['cost'] = Variable<int>(cost);
    }
    if (!nullToAbsent || attack != null) {
      map['attack'] = Variable<int>(attack);
    }
    if (!nullToAbsent || defense != null) {
      map['defense'] = Variable<int>(defense);
    }
    if (!nullToAbsent || cardText != null) {
      map['card_text'] = Variable<String>(cardText);
    }
    if (!nullToAbsent || illustrator != null) {
      map['illustrator'] = Variable<String>(illustrator);
    }
    if (!nullToAbsent || lastScrapedDetailsAt != null) {
      map['last_scraped_details_at'] = Variable<DateTime>(lastScrapedDetailsAt);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  CardsCompanion toCompanion(bool nullToAbsent) {
    return CardsCompanion(
      id: Value(id),
      cardno: Value(cardno),
      expansion: Value(expansion),
      japaneseName: japaneseName == null && nullToAbsent
          ? const Value.absent()
          : Value(japaneseName),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      detailPageUrl: detailPageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(detailPageUrl),
      japaneseSetName: japaneseSetName == null && nullToAbsent
          ? const Value.absent()
          : Value(japaneseSetName),
      cardClass: cardClass == null && nullToAbsent
          ? const Value.absent()
          : Value(cardClass),
      cardType: cardType == null && nullToAbsent
          ? const Value.absent()
          : Value(cardType),
      cardSubtype: cardSubtype == null && nullToAbsent
          ? const Value.absent()
          : Value(cardSubtype),
      rarity:
          rarity == null && nullToAbsent ? const Value.absent() : Value(rarity),
      cost: cost == null && nullToAbsent ? const Value.absent() : Value(cost),
      attack:
          attack == null && nullToAbsent ? const Value.absent() : Value(attack),
      defense: defense == null && nullToAbsent
          ? const Value.absent()
          : Value(defense),
      cardText: cardText == null && nullToAbsent
          ? const Value.absent()
          : Value(cardText),
      illustrator: illustrator == null && nullToAbsent
          ? const Value.absent()
          : Value(illustrator),
      lastScrapedDetailsAt: lastScrapedDetailsAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastScrapedDetailsAt),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory CardRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CardRow(
      id: serializer.fromJson<int>(json['id']),
      cardno: serializer.fromJson<String>(json['cardno']),
      expansion: serializer.fromJson<String>(json['expansion']),
      japaneseName: serializer.fromJson<String?>(json['japaneseName']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      detailPageUrl: serializer.fromJson<String?>(json['detailPageUrl']),
      japaneseSetName: serializer.fromJson<String?>(json['japaneseSetName']),
      cardClass: serializer.fromJson<String?>(json['cardClass']),
      cardType: serializer.fromJson<String?>(json['cardType']),
      cardSubtype: serializer.fromJson<String?>(json['cardSubtype']),
      rarity: serializer.fromJson<String?>(json['rarity']),
      cost: serializer.fromJson<int?>(json['cost']),
      attack: serializer.fromJson<int?>(json['attack']),
      defense: serializer.fromJson<int?>(json['defense']),
      cardText: serializer.fromJson<String?>(json['cardText']),
      illustrator: serializer.fromJson<String?>(json['illustrator']),
      lastScrapedDetailsAt:
          serializer.fromJson<DateTime?>(json['lastScrapedDetailsAt']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cardno': serializer.toJson<String>(cardno),
      'expansion': serializer.toJson<String>(expansion),
      'japaneseName': serializer.toJson<String?>(japaneseName),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'detailPageUrl': serializer.toJson<String?>(detailPageUrl),
      'japaneseSetName': serializer.toJson<String?>(japaneseSetName),
      'cardClass': serializer.toJson<String?>(cardClass),
      'cardType': serializer.toJson<String?>(cardType),
      'cardSubtype': serializer.toJson<String?>(cardSubtype),
      'rarity': serializer.toJson<String?>(rarity),
      'cost': serializer.toJson<int?>(cost),
      'attack': serializer.toJson<int?>(attack),
      'defense': serializer.toJson<int?>(defense),
      'cardText': serializer.toJson<String?>(cardText),
      'illustrator': serializer.toJson<String?>(illustrator),
      'lastScrapedDetailsAt':
          serializer.toJson<DateTime?>(lastScrapedDetailsAt),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  CardRow copyWith(
          {int? id,
          String? cardno,
          String? expansion,
          Value<String?> japaneseName = const Value.absent(),
          Value<String?> imageUrl = const Value.absent(),
          Value<String?> detailPageUrl = const Value.absent(),
          Value<String?> japaneseSetName = const Value.absent(),
          Value<String?> cardClass = const Value.absent(),
          Value<String?> cardType = const Value.absent(),
          Value<String?> cardSubtype = const Value.absent(),
          Value<String?> rarity = const Value.absent(),
          Value<int?> cost = const Value.absent(),
          Value<int?> attack = const Value.absent(),
          Value<int?> defense = const Value.absent(),
          Value<String?> cardText = const Value.absent(),
          Value<String?> illustrator = const Value.absent(),
          Value<DateTime?> lastScrapedDetailsAt = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      CardRow(
        id: id ?? this.id,
        cardno: cardno ?? this.cardno,
        expansion: expansion ?? this.expansion,
        japaneseName:
            japaneseName.present ? japaneseName.value : this.japaneseName,
        imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
        detailPageUrl:
            detailPageUrl.present ? detailPageUrl.value : this.detailPageUrl,
        japaneseSetName: japaneseSetName.present
            ? japaneseSetName.value
            : this.japaneseSetName,
        cardClass: cardClass.present ? cardClass.value : this.cardClass,
        cardType: cardType.present ? cardType.value : this.cardType,
        cardSubtype: cardSubtype.present ? cardSubtype.value : this.cardSubtype,
        rarity: rarity.present ? rarity.value : this.rarity,
        cost: cost.present ? cost.value : this.cost,
        attack: attack.present ? attack.value : this.attack,
        defense: defense.present ? defense.value : this.defense,
        cardText: cardText.present ? cardText.value : this.cardText,
        illustrator: illustrator.present ? illustrator.value : this.illustrator,
        lastScrapedDetailsAt: lastScrapedDetailsAt.present
            ? lastScrapedDetailsAt.value
            : this.lastScrapedDetailsAt,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  CardRow copyWithCompanion(CardsCompanion data) {
    return CardRow(
      id: data.id.present ? data.id.value : this.id,
      cardno: data.cardno.present ? data.cardno.value : this.cardno,
      expansion: data.expansion.present ? data.expansion.value : this.expansion,
      japaneseName: data.japaneseName.present
          ? data.japaneseName.value
          : this.japaneseName,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      detailPageUrl: data.detailPageUrl.present
          ? data.detailPageUrl.value
          : this.detailPageUrl,
      japaneseSetName: data.japaneseSetName.present
          ? data.japaneseSetName.value
          : this.japaneseSetName,
      cardClass: data.cardClass.present ? data.cardClass.value : this.cardClass,
      cardType: data.cardType.present ? data.cardType.value : this.cardType,
      cardSubtype:
          data.cardSubtype.present ? data.cardSubtype.value : this.cardSubtype,
      rarity: data.rarity.present ? data.rarity.value : this.rarity,
      cost: data.cost.present ? data.cost.value : this.cost,
      attack: data.attack.present ? data.attack.value : this.attack,
      defense: data.defense.present ? data.defense.value : this.defense,
      cardText: data.cardText.present ? data.cardText.value : this.cardText,
      illustrator:
          data.illustrator.present ? data.illustrator.value : this.illustrator,
      lastScrapedDetailsAt: data.lastScrapedDetailsAt.present
          ? data.lastScrapedDetailsAt.value
          : this.lastScrapedDetailsAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CardRow(')
          ..write('id: $id, ')
          ..write('cardno: $cardno, ')
          ..write('expansion: $expansion, ')
          ..write('japaneseName: $japaneseName, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('detailPageUrl: $detailPageUrl, ')
          ..write('japaneseSetName: $japaneseSetName, ')
          ..write('cardClass: $cardClass, ')
          ..write('cardType: $cardType, ')
          ..write('cardSubtype: $cardSubtype, ')
          ..write('rarity: $rarity, ')
          ..write('cost: $cost, ')
          ..write('attack: $attack, ')
          ..write('defense: $defense, ')
          ..write('cardText: $cardText, ')
          ..write('illustrator: $illustrator, ')
          ..write('lastScrapedDetailsAt: $lastScrapedDetailsAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      cardno,
      expansion,
      japaneseName,
      imageUrl,
      detailPageUrl,
      japaneseSetName,
      cardClass,
      cardType,
      cardSubtype,
      rarity,
      cost,
      attack,
      defense,
      cardText,
      illustrator,
      lastScrapedDetailsAt,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardRow &&
          other.id == this.id &&
          other.cardno == this.cardno &&
          other.expansion == this.expansion &&
          other.japaneseName == this.japaneseName &&
          other.imageUrl == this.imageUrl &&
          other.detailPageUrl == this.detailPageUrl &&
          other.japaneseSetName == this.japaneseSetName &&
          other.cardClass == this.cardClass &&
          other.cardType == this.cardType &&
          other.cardSubtype == this.cardSubtype &&
          other.rarity == this.rarity &&
          other.cost == this.cost &&
          other.attack == this.attack &&
          other.defense == this.defense &&
          other.cardText == this.cardText &&
          other.illustrator == this.illustrator &&
          other.lastScrapedDetailsAt == this.lastScrapedDetailsAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CardsCompanion extends UpdateCompanion<CardRow> {
  final Value<int> id;
  final Value<String> cardno;
  final Value<String> expansion;
  final Value<String?> japaneseName;
  final Value<String?> imageUrl;
  final Value<String?> detailPageUrl;
  final Value<String?> japaneseSetName;
  final Value<String?> cardClass;
  final Value<String?> cardType;
  final Value<String?> cardSubtype;
  final Value<String?> rarity;
  final Value<int?> cost;
  final Value<int?> attack;
  final Value<int?> defense;
  final Value<String?> cardText;
  final Value<String?> illustrator;
  final Value<DateTime?> lastScrapedDetailsAt;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  const CardsCompanion({
    this.id = const Value.absent(),
    this.cardno = const Value.absent(),
    this.expansion = const Value.absent(),
    this.japaneseName = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.detailPageUrl = const Value.absent(),
    this.japaneseSetName = const Value.absent(),
    this.cardClass = const Value.absent(),
    this.cardType = const Value.absent(),
    this.cardSubtype = const Value.absent(),
    this.rarity = const Value.absent(),
    this.cost = const Value.absent(),
    this.attack = const Value.absent(),
    this.defense = const Value.absent(),
    this.cardText = const Value.absent(),
    this.illustrator = const Value.absent(),
    this.lastScrapedDetailsAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CardsCompanion.insert({
    this.id = const Value.absent(),
    required String cardno,
    required String expansion,
    this.japaneseName = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.detailPageUrl = const Value.absent(),
    this.japaneseSetName = const Value.absent(),
    this.cardClass = const Value.absent(),
    this.cardType = const Value.absent(),
    this.cardSubtype = const Value.absent(),
    this.rarity = const Value.absent(),
    this.cost = const Value.absent(),
    this.attack = const Value.absent(),
    this.defense = const Value.absent(),
    this.cardText = const Value.absent(),
    this.illustrator = const Value.absent(),
    this.lastScrapedDetailsAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : cardno = Value(cardno),
        expansion = Value(expansion);
  static Insertable<CardRow> custom({
    Expression<int>? id,
    Expression<String>? cardno,
    Expression<String>? expansion,
    Expression<String>? japaneseName,
    Expression<String>? imageUrl,
    Expression<String>? detailPageUrl,
    Expression<String>? japaneseSetName,
    Expression<String>? cardClass,
    Expression<String>? cardType,
    Expression<String>? cardSubtype,
    Expression<String>? rarity,
    Expression<int>? cost,
    Expression<int>? attack,
    Expression<int>? defense,
    Expression<String>? cardText,
    Expression<String>? illustrator,
    Expression<DateTime>? lastScrapedDetailsAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cardno != null) 'cardno': cardno,
      if (expansion != null) 'expansion': expansion,
      if (japaneseName != null) 'japanese_name': japaneseName,
      if (imageUrl != null) 'image_url': imageUrl,
      if (detailPageUrl != null) 'detail_page_url': detailPageUrl,
      if (japaneseSetName != null) 'japanese_set_name': japaneseSetName,
      if (cardClass != null) 'card_class': cardClass,
      if (cardType != null) 'card_type': cardType,
      if (cardSubtype != null) 'card_subtype': cardSubtype,
      if (rarity != null) 'rarity': rarity,
      if (cost != null) 'cost': cost,
      if (attack != null) 'attack': attack,
      if (defense != null) 'defense': defense,
      if (cardText != null) 'card_text': cardText,
      if (illustrator != null) 'illustrator': illustrator,
      if (lastScrapedDetailsAt != null)
        'last_scraped_details_at': lastScrapedDetailsAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CardsCompanion copyWith(
      {Value<int>? id,
      Value<String>? cardno,
      Value<String>? expansion,
      Value<String?>? japaneseName,
      Value<String?>? imageUrl,
      Value<String?>? detailPageUrl,
      Value<String?>? japaneseSetName,
      Value<String?>? cardClass,
      Value<String?>? cardType,
      Value<String?>? cardSubtype,
      Value<String?>? rarity,
      Value<int?>? cost,
      Value<int?>? attack,
      Value<int?>? defense,
      Value<String?>? cardText,
      Value<String?>? illustrator,
      Value<DateTime?>? lastScrapedDetailsAt,
      Value<DateTime?>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return CardsCompanion(
      id: id ?? this.id,
      cardno: cardno ?? this.cardno,
      expansion: expansion ?? this.expansion,
      japaneseName: japaneseName ?? this.japaneseName,
      imageUrl: imageUrl ?? this.imageUrl,
      detailPageUrl: detailPageUrl ?? this.detailPageUrl,
      japaneseSetName: japaneseSetName ?? this.japaneseSetName,
      cardClass: cardClass ?? this.cardClass,
      cardType: cardType ?? this.cardType,
      cardSubtype: cardSubtype ?? this.cardSubtype,
      rarity: rarity ?? this.rarity,
      cost: cost ?? this.cost,
      attack: attack ?? this.attack,
      defense: defense ?? this.defense,
      cardText: cardText ?? this.cardText,
      illustrator: illustrator ?? this.illustrator,
      lastScrapedDetailsAt: lastScrapedDetailsAt ?? this.lastScrapedDetailsAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cardno.present) {
      map['cardno'] = Variable<String>(cardno.value);
    }
    if (expansion.present) {
      map['expansion'] = Variable<String>(expansion.value);
    }
    if (japaneseName.present) {
      map['japanese_name'] = Variable<String>(japaneseName.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (detailPageUrl.present) {
      map['detail_page_url'] = Variable<String>(detailPageUrl.value);
    }
    if (japaneseSetName.present) {
      map['japanese_set_name'] = Variable<String>(japaneseSetName.value);
    }
    if (cardClass.present) {
      map['card_class'] = Variable<String>(cardClass.value);
    }
    if (cardType.present) {
      map['card_type'] = Variable<String>(cardType.value);
    }
    if (cardSubtype.present) {
      map['card_subtype'] = Variable<String>(cardSubtype.value);
    }
    if (rarity.present) {
      map['rarity'] = Variable<String>(rarity.value);
    }
    if (cost.present) {
      map['cost'] = Variable<int>(cost.value);
    }
    if (attack.present) {
      map['attack'] = Variable<int>(attack.value);
    }
    if (defense.present) {
      map['defense'] = Variable<int>(defense.value);
    }
    if (cardText.present) {
      map['card_text'] = Variable<String>(cardText.value);
    }
    if (illustrator.present) {
      map['illustrator'] = Variable<String>(illustrator.value);
    }
    if (lastScrapedDetailsAt.present) {
      map['last_scraped_details_at'] =
          Variable<DateTime>(lastScrapedDetailsAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardsCompanion(')
          ..write('id: $id, ')
          ..write('cardno: $cardno, ')
          ..write('expansion: $expansion, ')
          ..write('japaneseName: $japaneseName, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('detailPageUrl: $detailPageUrl, ')
          ..write('japaneseSetName: $japaneseSetName, ')
          ..write('cardClass: $cardClass, ')
          ..write('cardType: $cardType, ')
          ..write('cardSubtype: $cardSubtype, ')
          ..write('rarity: $rarity, ')
          ..write('cost: $cost, ')
          ..write('attack: $attack, ')
          ..write('defense: $defense, ')
          ..write('cardText: $cardText, ')
          ..write('illustrator: $illustrator, ')
          ..write('lastScrapedDetailsAt: $lastScrapedDetailsAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $UserCollectionsTable extends UserCollections
    with TableInfo<$UserCollectionsTable, UserCollectionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserCollectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<int> cardId = GeneratedColumn<int>(
      'card_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _addedAtMeta =
      const VerificationMeta('addedAt');
  @override
  late final GeneratedColumn<DateTime> addedAt = GeneratedColumn<DateTime>(
      'added_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, cardId, quantity, addedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_collections';
  @override
  VerificationContext validateIntegrity(Insertable<UserCollectionRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('card_id')) {
      context.handle(_cardIdMeta,
          cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta));
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('added_at')) {
      context.handle(_addedAtMeta,
          addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserCollectionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserCollectionRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      cardId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}card_id'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      addedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}added_at']),
    );
  }

  @override
  $UserCollectionsTable createAlias(String alias) {
    return $UserCollectionsTable(attachedDatabase, alias);
  }
}

class UserCollectionRow extends DataClass
    implements Insertable<UserCollectionRow> {
  final int id;
  final int cardId;
  final int quantity;
  final DateTime? addedAt;
  const UserCollectionRow(
      {required this.id,
      required this.cardId,
      required this.quantity,
      this.addedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['card_id'] = Variable<int>(cardId);
    map['quantity'] = Variable<int>(quantity);
    if (!nullToAbsent || addedAt != null) {
      map['added_at'] = Variable<DateTime>(addedAt);
    }
    return map;
  }

  UserCollectionsCompanion toCompanion(bool nullToAbsent) {
    return UserCollectionsCompanion(
      id: Value(id),
      cardId: Value(cardId),
      quantity: Value(quantity),
      addedAt: addedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(addedAt),
    );
  }

  factory UserCollectionRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserCollectionRow(
      id: serializer.fromJson<int>(json['id']),
      cardId: serializer.fromJson<int>(json['cardId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      addedAt: serializer.fromJson<DateTime?>(json['addedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cardId': serializer.toJson<int>(cardId),
      'quantity': serializer.toJson<int>(quantity),
      'addedAt': serializer.toJson<DateTime?>(addedAt),
    };
  }

  UserCollectionRow copyWith(
          {int? id,
          int? cardId,
          int? quantity,
          Value<DateTime?> addedAt = const Value.absent()}) =>
      UserCollectionRow(
        id: id ?? this.id,
        cardId: cardId ?? this.cardId,
        quantity: quantity ?? this.quantity,
        addedAt: addedAt.present ? addedAt.value : this.addedAt,
      );
  UserCollectionRow copyWithCompanion(UserCollectionsCompanion data) {
    return UserCollectionRow(
      id: data.id.present ? data.id.value : this.id,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserCollectionRow(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('quantity: $quantity, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, cardId, quantity, addedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserCollectionRow &&
          other.id == this.id &&
          other.cardId == this.cardId &&
          other.quantity == this.quantity &&
          other.addedAt == this.addedAt);
}

class UserCollectionsCompanion extends UpdateCompanion<UserCollectionRow> {
  final Value<int> id;
  final Value<int> cardId;
  final Value<int> quantity;
  final Value<DateTime?> addedAt;
  const UserCollectionsCompanion({
    this.id = const Value.absent(),
    this.cardId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.addedAt = const Value.absent(),
  });
  UserCollectionsCompanion.insert({
    this.id = const Value.absent(),
    required int cardId,
    this.quantity = const Value.absent(),
    this.addedAt = const Value.absent(),
  }) : cardId = Value(cardId);
  static Insertable<UserCollectionRow> custom({
    Expression<int>? id,
    Expression<int>? cardId,
    Expression<int>? quantity,
    Expression<DateTime>? addedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cardId != null) 'card_id': cardId,
      if (quantity != null) 'quantity': quantity,
      if (addedAt != null) 'added_at': addedAt,
    });
  }

  UserCollectionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? cardId,
      Value<int>? quantity,
      Value<DateTime?>? addedAt}) {
    return UserCollectionsCompanion(
      id: id ?? this.id,
      cardId: cardId ?? this.cardId,
      quantity: quantity ?? this.quantity,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<int>(cardId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserCollectionsCompanion(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('quantity: $quantity, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CardsTable cards = $CardsTable(this);
  late final $UserCollectionsTable userCollections =
      $UserCollectionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cards, userCollections];
}

typedef $$CardsTableCreateCompanionBuilder = CardsCompanion Function({
  Value<int> id,
  required String cardno,
  required String expansion,
  Value<String?> japaneseName,
  Value<String?> imageUrl,
  Value<String?> detailPageUrl,
  Value<String?> japaneseSetName,
  Value<String?> cardClass,
  Value<String?> cardType,
  Value<String?> cardSubtype,
  Value<String?> rarity,
  Value<int?> cost,
  Value<int?> attack,
  Value<int?> defense,
  Value<String?> cardText,
  Value<String?> illustrator,
  Value<DateTime?> lastScrapedDetailsAt,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$CardsTableUpdateCompanionBuilder = CardsCompanion Function({
  Value<int> id,
  Value<String> cardno,
  Value<String> expansion,
  Value<String?> japaneseName,
  Value<String?> imageUrl,
  Value<String?> detailPageUrl,
  Value<String?> japaneseSetName,
  Value<String?> cardClass,
  Value<String?> cardType,
  Value<String?> cardSubtype,
  Value<String?> rarity,
  Value<int?> cost,
  Value<int?> attack,
  Value<int?> defense,
  Value<String?> cardText,
  Value<String?> illustrator,
  Value<DateTime?> lastScrapedDetailsAt,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
});

class $$CardsTableFilterComposer extends Composer<_$AppDatabase, $CardsTable> {
  $$CardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cardno => $composableBuilder(
      column: $table.cardno, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get expansion => $composableBuilder(
      column: $table.expansion, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get japaneseName => $composableBuilder(
      column: $table.japaneseName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get detailPageUrl => $composableBuilder(
      column: $table.detailPageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get japaneseSetName => $composableBuilder(
      column: $table.japaneseSetName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cardClass => $composableBuilder(
      column: $table.cardClass, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cardType => $composableBuilder(
      column: $table.cardType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cardSubtype => $composableBuilder(
      column: $table.cardSubtype, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rarity => $composableBuilder(
      column: $table.rarity, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cost => $composableBuilder(
      column: $table.cost, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get attack => $composableBuilder(
      column: $table.attack, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get defense => $composableBuilder(
      column: $table.defense, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cardText => $composableBuilder(
      column: $table.cardText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get illustrator => $composableBuilder(
      column: $table.illustrator, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastScrapedDetailsAt => $composableBuilder(
      column: $table.lastScrapedDetailsAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$CardsTableOrderingComposer
    extends Composer<_$AppDatabase, $CardsTable> {
  $$CardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cardno => $composableBuilder(
      column: $table.cardno, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get expansion => $composableBuilder(
      column: $table.expansion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get japaneseName => $composableBuilder(
      column: $table.japaneseName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get detailPageUrl => $composableBuilder(
      column: $table.detailPageUrl,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get japaneseSetName => $composableBuilder(
      column: $table.japaneseSetName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cardClass => $composableBuilder(
      column: $table.cardClass, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cardType => $composableBuilder(
      column: $table.cardType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cardSubtype => $composableBuilder(
      column: $table.cardSubtype, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rarity => $composableBuilder(
      column: $table.rarity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cost => $composableBuilder(
      column: $table.cost, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get attack => $composableBuilder(
      column: $table.attack, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get defense => $composableBuilder(
      column: $table.defense, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cardText => $composableBuilder(
      column: $table.cardText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get illustrator => $composableBuilder(
      column: $table.illustrator, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastScrapedDetailsAt => $composableBuilder(
      column: $table.lastScrapedDetailsAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CardsTable> {
  $$CardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cardno =>
      $composableBuilder(column: $table.cardno, builder: (column) => column);

  GeneratedColumn<String> get expansion =>
      $composableBuilder(column: $table.expansion, builder: (column) => column);

  GeneratedColumn<String> get japaneseName => $composableBuilder(
      column: $table.japaneseName, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get detailPageUrl => $composableBuilder(
      column: $table.detailPageUrl, builder: (column) => column);

  GeneratedColumn<String> get japaneseSetName => $composableBuilder(
      column: $table.japaneseSetName, builder: (column) => column);

  GeneratedColumn<String> get cardClass =>
      $composableBuilder(column: $table.cardClass, builder: (column) => column);

  GeneratedColumn<String> get cardType =>
      $composableBuilder(column: $table.cardType, builder: (column) => column);

  GeneratedColumn<String> get cardSubtype => $composableBuilder(
      column: $table.cardSubtype, builder: (column) => column);

  GeneratedColumn<String> get rarity =>
      $composableBuilder(column: $table.rarity, builder: (column) => column);

  GeneratedColumn<int> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  GeneratedColumn<int> get attack =>
      $composableBuilder(column: $table.attack, builder: (column) => column);

  GeneratedColumn<int> get defense =>
      $composableBuilder(column: $table.defense, builder: (column) => column);

  GeneratedColumn<String> get cardText =>
      $composableBuilder(column: $table.cardText, builder: (column) => column);

  GeneratedColumn<String> get illustrator => $composableBuilder(
      column: $table.illustrator, builder: (column) => column);

  GeneratedColumn<DateTime> get lastScrapedDetailsAt => $composableBuilder(
      column: $table.lastScrapedDetailsAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CardsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CardsTable,
    CardRow,
    $$CardsTableFilterComposer,
    $$CardsTableOrderingComposer,
    $$CardsTableAnnotationComposer,
    $$CardsTableCreateCompanionBuilder,
    $$CardsTableUpdateCompanionBuilder,
    (CardRow, BaseReferences<_$AppDatabase, $CardsTable, CardRow>),
    CardRow,
    PrefetchHooks Function()> {
  $$CardsTableTableManager(_$AppDatabase db, $CardsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> cardno = const Value.absent(),
            Value<String> expansion = const Value.absent(),
            Value<String?> japaneseName = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<String?> detailPageUrl = const Value.absent(),
            Value<String?> japaneseSetName = const Value.absent(),
            Value<String?> cardClass = const Value.absent(),
            Value<String?> cardType = const Value.absent(),
            Value<String?> cardSubtype = const Value.absent(),
            Value<String?> rarity = const Value.absent(),
            Value<int?> cost = const Value.absent(),
            Value<int?> attack = const Value.absent(),
            Value<int?> defense = const Value.absent(),
            Value<String?> cardText = const Value.absent(),
            Value<String?> illustrator = const Value.absent(),
            Value<DateTime?> lastScrapedDetailsAt = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              CardsCompanion(
            id: id,
            cardno: cardno,
            expansion: expansion,
            japaneseName: japaneseName,
            imageUrl: imageUrl,
            detailPageUrl: detailPageUrl,
            japaneseSetName: japaneseSetName,
            cardClass: cardClass,
            cardType: cardType,
            cardSubtype: cardSubtype,
            rarity: rarity,
            cost: cost,
            attack: attack,
            defense: defense,
            cardText: cardText,
            illustrator: illustrator,
            lastScrapedDetailsAt: lastScrapedDetailsAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String cardno,
            required String expansion,
            Value<String?> japaneseName = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<String?> detailPageUrl = const Value.absent(),
            Value<String?> japaneseSetName = const Value.absent(),
            Value<String?> cardClass = const Value.absent(),
            Value<String?> cardType = const Value.absent(),
            Value<String?> cardSubtype = const Value.absent(),
            Value<String?> rarity = const Value.absent(),
            Value<int?> cost = const Value.absent(),
            Value<int?> attack = const Value.absent(),
            Value<int?> defense = const Value.absent(),
            Value<String?> cardText = const Value.absent(),
            Value<String?> illustrator = const Value.absent(),
            Value<DateTime?> lastScrapedDetailsAt = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              CardsCompanion.insert(
            id: id,
            cardno: cardno,
            expansion: expansion,
            japaneseName: japaneseName,
            imageUrl: imageUrl,
            detailPageUrl: detailPageUrl,
            japaneseSetName: japaneseSetName,
            cardClass: cardClass,
            cardType: cardType,
            cardSubtype: cardSubtype,
            rarity: rarity,
            cost: cost,
            attack: attack,
            defense: defense,
            cardText: cardText,
            illustrator: illustrator,
            lastScrapedDetailsAt: lastScrapedDetailsAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CardsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CardsTable,
    CardRow,
    $$CardsTableFilterComposer,
    $$CardsTableOrderingComposer,
    $$CardsTableAnnotationComposer,
    $$CardsTableCreateCompanionBuilder,
    $$CardsTableUpdateCompanionBuilder,
    (CardRow, BaseReferences<_$AppDatabase, $CardsTable, CardRow>),
    CardRow,
    PrefetchHooks Function()>;
typedef $$UserCollectionsTableCreateCompanionBuilder = UserCollectionsCompanion
    Function({
  Value<int> id,
  required int cardId,
  Value<int> quantity,
  Value<DateTime?> addedAt,
});
typedef $$UserCollectionsTableUpdateCompanionBuilder = UserCollectionsCompanion
    Function({
  Value<int> id,
  Value<int> cardId,
  Value<int> quantity,
  Value<DateTime?> addedAt,
});

class $$UserCollectionsTableFilterComposer
    extends Composer<_$AppDatabase, $UserCollectionsTable> {
  $$UserCollectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cardId => $composableBuilder(
      column: $table.cardId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get addedAt => $composableBuilder(
      column: $table.addedAt, builder: (column) => ColumnFilters(column));
}

class $$UserCollectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserCollectionsTable> {
  $$UserCollectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cardId => $composableBuilder(
      column: $table.cardId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get addedAt => $composableBuilder(
      column: $table.addedAt, builder: (column) => ColumnOrderings(column));
}

class $$UserCollectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserCollectionsTable> {
  $$UserCollectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get cardId =>
      $composableBuilder(column: $table.cardId, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<DateTime> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);
}

class $$UserCollectionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserCollectionsTable,
    UserCollectionRow,
    $$UserCollectionsTableFilterComposer,
    $$UserCollectionsTableOrderingComposer,
    $$UserCollectionsTableAnnotationComposer,
    $$UserCollectionsTableCreateCompanionBuilder,
    $$UserCollectionsTableUpdateCompanionBuilder,
    (
      UserCollectionRow,
      BaseReferences<_$AppDatabase, $UserCollectionsTable, UserCollectionRow>
    ),
    UserCollectionRow,
    PrefetchHooks Function()> {
  $$UserCollectionsTableTableManager(
      _$AppDatabase db, $UserCollectionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserCollectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserCollectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserCollectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> cardId = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<DateTime?> addedAt = const Value.absent(),
          }) =>
              UserCollectionsCompanion(
            id: id,
            cardId: cardId,
            quantity: quantity,
            addedAt: addedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int cardId,
            Value<int> quantity = const Value.absent(),
            Value<DateTime?> addedAt = const Value.absent(),
          }) =>
              UserCollectionsCompanion.insert(
            id: id,
            cardId: cardId,
            quantity: quantity,
            addedAt: addedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserCollectionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserCollectionsTable,
    UserCollectionRow,
    $$UserCollectionsTableFilterComposer,
    $$UserCollectionsTableOrderingComposer,
    $$UserCollectionsTableAnnotationComposer,
    $$UserCollectionsTableCreateCompanionBuilder,
    $$UserCollectionsTableUpdateCompanionBuilder,
    (
      UserCollectionRow,
      BaseReferences<_$AppDatabase, $UserCollectionsTable, UserCollectionRow>
    ),
    UserCollectionRow,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CardsTableTableManager get cards =>
      $$CardsTableTableManager(_db, _db.cards);
  $$UserCollectionsTableTableManager get userCollections =>
      $$UserCollectionsTableTableManager(_db, _db.userCollections);
}
