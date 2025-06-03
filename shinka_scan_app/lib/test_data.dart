import 'models/TCGCard.dart';
import 'models/booster.dart';

class TestData {
  static List<TCGCard> sampleCards = [
    TCGCard(
      id: '1',
      cardno: 'BP01-001',
      expansion: 'BP01',
      name: '閃耀の剣士・バイロン', // Example Japanese Name
      imageUrl: 'https://shadowverse-evolve.com/wordpress/wp-content/uploads/cardimg/BP01-001.png',
      detailPageUrl: '/cardlist/carddetail/?cardno=BP01-001&expansion=BP01',
      set: '創世の夜明け', // Example Japanese Set Name
      rarity: 'SR',
      cardClass: 'ソード',
      cardType: 'フォロワー',
      cardSubtype: '兵士',
      cost: 2,
      attack: 2,
      defense: 2,
      cardText: '【進化時】自分の場に他の【兵士】フォロワーがいるなら、+1/+0する。',
      illustrator: 'Kagemaru Himeno',
    ),
    TCGCard(
      id: '2',
      cardno: 'BP01-002',
      expansion: 'BP01',
      name: '不屈の兵士',
      imageUrl: 'https://shadowverse-evolve.com/wordpress/wp-content/uploads/cardimg/BP01-002.png',
      detailPageUrl: '/cardlist/carddetail/?cardno=BP01-002&expansion=BP01',
      set: '創世の夜明け',
      rarity: 'R',
      cardClass: 'ソード',
      cardType: 'フォロワー',
      cardSubtype: '兵士',
      cost: 1,
      attack: 1,
      defense: 1,
      cardText: '',
      illustrator: 'Tsubaki',
    ),
    // Add more sample cards following this format
    TCGCard(
      id: '3',
      cardno: 'BP02-058',
      expansion: 'BP02',
      name: 'マーリン',
      imageUrl: 'https://shadowverse-evolve.com/wordpress/wp-content/uploads/cardimg/BP02-058.png',
      detailPageUrl: '/cardlist/carddetail/?cardno=BP02-058&expansion=BP02',
      set: '暗黒のウェルサ',
      rarity: 'SR',
      cardClass: 'ウィッチ',
      cardType: 'フォロワー',
      cardSubtype: '魔法使い',
      cost: 3,
      attack: 2,
      defense: 2,
      cardText: '【ファンファーレ】カードを1枚引く。\n【進化時】手札のスペルカードをランダムに1枚選び、コストを1にする。',
      illustrator: 'Ryota-H',
    ),
  ];

  static List<Booster> sampleBoosters = [
    Booster(
      id: 'B001',
      name: '創世の夜明け',
      imageUrl: 'https://shadowverse-evolve.com/wordpress/wp-content/uploads/cardpack/BP01.jpg',
      possibleCards: [sampleCards[0], sampleCards[1]],
    ),
    Booster(
      id: 'B002',
      name: '暗黒のウェルサ',
      imageUrl: 'https://shadowverse-evolve.com/wordpress/wp-content/uploads/cardpack/BP02.jpg',
      possibleCards: [sampleCards[2]],
    ),
    // Add more sample boosters
  ];
}