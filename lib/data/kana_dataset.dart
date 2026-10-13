import '../domain/models/kana_symbol.dart';

/// Predefined repository of Japanese Kana characters.
class KanaDataset {
  const KanaDataset._();

  /// Standard 46 Gojūon Hiragana symbols plus Dakuten and Handakuten.
  static const List<KanaSymbol> hiraganaSymbols = [
    // --- Vowels (A-row) ---
    KanaSymbol(kana: 'あ', romaji: 'a', script: KanaScript.hiragana, group: KanaGroup.vowels),
    KanaSymbol(kana: 'い', romaji: 'i', script: KanaScript.hiragana, group: KanaGroup.vowels),
    KanaSymbol(kana: 'う', romaji: 'u', script: KanaScript.hiragana, group: KanaGroup.vowels),
    KanaSymbol(kana: 'え', romaji: 'e', script: KanaScript.hiragana, group: KanaGroup.vowels),
    KanaSymbol(kana: 'お', romaji: 'o', script: KanaScript.hiragana, group: KanaGroup.vowels),

    // --- Ka-row ---
    KanaSymbol(kana: 'か', romaji: 'ka', script: KanaScript.hiragana, group: KanaGroup.ka),
    KanaSymbol(kana: 'き', romaji: 'ki', script: KanaScript.hiragana, group: KanaGroup.ka),
    KanaSymbol(kana: 'く', romaji: 'ku', script: KanaScript.hiragana, group: KanaGroup.ka),
    KanaSymbol(kana: 'け', romaji: 'ke', script: KanaScript.hiragana, group: KanaGroup.ka),
    KanaSymbol(kana: 'こ', romaji: 'ko', script: KanaScript.hiragana, group: KanaGroup.ka),

    // --- Sa-row ---
    KanaSymbol(kana: 'さ', romaji: 'sa', script: KanaScript.hiragana, group: KanaGroup.sa),
    KanaSymbol(kana: 'し', romaji: 'shi', script: KanaScript.hiragana, group: KanaGroup.sa, alternatives: ['si']),
    KanaSymbol(kana: 'す', romaji: 'su', script: KanaScript.hiragana, group: KanaGroup.sa),
    KanaSymbol(kana: 'せ', romaji: 'se', script: KanaScript.hiragana, group: KanaGroup.sa),
    KanaSymbol(kana: 'そ', romaji: 'so', script: KanaScript.hiragana, group: KanaGroup.sa),

    // --- Ta-row ---
    KanaSymbol(kana: 'た', romaji: 'ta', script: KanaScript.hiragana, group: KanaGroup.ta),
    KanaSymbol(kana: 'ち', romaji: 'chi', script: KanaScript.hiragana, group: KanaGroup.ta, alternatives: ['ti']),
    KanaSymbol(kana: 'つ', romaji: 'tsu', script: KanaScript.hiragana, group: KanaGroup.ta, alternatives: ['tu']),
    KanaSymbol(kana: 'て', romaji: 'te', script: KanaScript.hiragana, group: KanaGroup.ta),
    KanaSymbol(kana: 'と', romaji: 'to', script: KanaScript.hiragana, group: KanaGroup.ta),

    // --- Na-row ---
    KanaSymbol(kana: 'な', romaji: 'na', script: KanaScript.hiragana, group: KanaGroup.na),
    KanaSymbol(kana: 'に', romaji: 'ni', script: KanaScript.hiragana, group: KanaGroup.na),
    KanaSymbol(kana: 'ぬ', romaji: 'nu', script: KanaScript.hiragana, group: KanaGroup.na),
    KanaSymbol(kana: 'ね', romaji: 'ne', script: KanaScript.hiragana, group: KanaGroup.na),
    KanaSymbol(kana: 'の', romaji: 'no', script: KanaScript.hiragana, group: KanaGroup.na),

    // --- Ha-row ---
    KanaSymbol(kana: 'は', romaji: 'ha', script: KanaScript.hiragana, group: KanaGroup.ha),
    KanaSymbol(kana: 'ひ', romaji: 'hi', script: KanaScript.hiragana, group: KanaGroup.ha),
    KanaSymbol(kana: 'ふ', romaji: 'fu', script: KanaScript.hiragana, group: KanaGroup.ha, alternatives: ['hu']),
    KanaSymbol(kana: 'へ', romaji: 'he', script: KanaScript.hiragana, group: KanaGroup.ha),
    KanaSymbol(kana: 'ほ', romaji: 'ho', script: KanaScript.hiragana, group: KanaGroup.ha),

    // --- Ma-row ---
    KanaSymbol(kana: 'ま', romaji: 'ma', script: KanaScript.hiragana, group: KanaGroup.ma),
    KanaSymbol(kana: 'み', romaji: 'mi', script: KanaScript.hiragana, group: KanaGroup.ma),
    KanaSymbol(kana: 'む', romaji: 'mu', script: KanaScript.hiragana, group: KanaGroup.ma),
    KanaSymbol(kana: 'め', romaji: 'me', script: KanaScript.hiragana, group: KanaGroup.ma),
    KanaSymbol(kana: 'も', romaji: 'mo', script: KanaScript.hiragana, group: KanaGroup.ma),

    // --- Ya-row ---
    KanaSymbol(kana: 'や', romaji: 'ya', script: KanaScript.hiragana, group: KanaGroup.ya),
    KanaSymbol(kana: 'ゆ', romaji: 'yu', script: KanaScript.hiragana, group: KanaGroup.ya),
    KanaSymbol(kana: 'よ', romaji: 'yo', script: KanaScript.hiragana, group: KanaGroup.ya),

    // --- Ra-row ---
    KanaSymbol(kana: 'ら', romaji: 'ra', script: KanaScript.hiragana, group: KanaGroup.ra),
    KanaSymbol(kana: 'り', romaji: 'ri', script: KanaScript.hiragana, group: KanaGroup.ra),
    KanaSymbol(kana: 'る', romaji: 'ru', script: KanaScript.hiragana, group: KanaGroup.ra),
    KanaSymbol(kana: 'れ', romaji: 're', script: KanaScript.hiragana, group: KanaGroup.ra),
    KanaSymbol(kana: 'ろ', romaji: 'ro', script: KanaScript.hiragana, group: KanaGroup.ra),

    // --- Wa-row & N ---
    KanaSymbol(kana: 'わ', romaji: 'wa', script: KanaScript.hiragana, group: KanaGroup.wa),
    KanaSymbol(kana: 'を', romaji: 'wo', script: KanaScript.hiragana, group: KanaGroup.wa, alternatives: ['o']),
    KanaSymbol(kana: 'ん', romaji: 'n', script: KanaScript.hiragana, group: KanaGroup.wa, alternatives: ['nn']),

    // --- Dakuten ---
    KanaSymbol(kana: 'が', romaji: 'ga', script: KanaScript.hiragana, group: KanaGroup.dakuten),
    KanaSymbol(kana: 'ぎ', romaji: 'gi', script: KanaScript.hiragana, group: KanaGroup.dakuten),
    KanaSymbol(kana: 'ぐ', romaji: 'gu', script: KanaScript.hiragana, group: KanaGroup.dakuten),
    KanaSymbol(kana: 'げ', romaji: 'ge', script: KanaScript.hiragana, group: KanaGroup.dakuten),
    KanaSymbol(kana: 'ご', romaji: 'go', script: KanaScript.hiragana, group: KanaGroup.dakuten),

    KanaSymbol(kana: 'ざ', romaji: 'za', script: KanaScript.hiragana, group: KanaGroup.dakuten),
    KanaSymbol(kana: 'じ', romaji: 'ji', script: KanaScript.hiragana, group: KanaGroup.dakuten, alternatives: ['zi']),
    KanaSymbol(kana: 'ず', romaji: 'zu', script: KanaScript.hiragana, group: KanaGroup.dakuten),
    KanaSymbol(kana: 'ぜ', romaji: 'ze', script: KanaScript.hiragana, group: KanaGroup.dakuten),
    KanaSymbol(kana: 'ぞ', romaji: 'zo', script: KanaScript.hiragana, group: KanaGroup.dakuten),

    KanaSymbol(kana: 'だ', romaji: 'da', script: KanaScript.hiragana, group: KanaGroup.dakuten),
    KanaSymbol(kana: 'ぢ', romaji: 'ji', script: KanaScript.hiragana, group: KanaGroup.dakuten, alternatives: ['di', 'dji']),
    KanaSymbol(kana: 'づ', romaji: 'zu', script: KanaScript.hiragana, group: KanaGroup.dakuten, alternatives: ['dzu', 'du']),
    KanaSymbol(kana: 'で', romaji: 'de', script: KanaScript.hiragana, group: KanaGroup.dakuten),
    KanaSymbol(kana: 'ど', romaji: 'do', script: KanaScript.hiragana, group: KanaGroup.dakuten),

    KanaSymbol(kana: 'ば', romaji: 'ba', script: KanaScript.hiragana, group: KanaGroup.dakuten),
    KanaSymbol(kana: 'び', romaji: 'bi', script: KanaScript.hiragana, group: KanaGroup.dakuten),
    KanaSymbol(kana: 'ぶ', romaji: 'bu', script: KanaScript.hiragana, group: KanaGroup.dakuten),
    KanaSymbol(kana: 'べ', romaji: 'be', script: KanaScript.hiragana, group: KanaGroup.dakuten),
    KanaSymbol(kana: 'ぼ', romaji: 'bo', script: KanaScript.hiragana, group: KanaGroup.dakuten),

    // --- Handakuten ---
    KanaSymbol(kana: 'ぱ', romaji: 'pa', script: KanaScript.hiragana, group: KanaGroup.handakuten),
    KanaSymbol(kana: 'ぴ', romaji: 'pi', script: KanaScript.hiragana, group: KanaGroup.handakuten),
    KanaSymbol(kana: 'ぷ', romaji: 'pu', script: KanaScript.hiragana, group: KanaGroup.handakuten),
    KanaSymbol(kana: 'ぺ', romaji: 'pe', script: KanaScript.hiragana, group: KanaGroup.handakuten),
    KanaSymbol(kana: 'ぽ', romaji: 'po', script: KanaScript.hiragana, group: KanaGroup.handakuten),
  ];

  /// Standard Katakana symbols (46 Gojūon plus Dakuten and Handakuten).
  static const List<KanaSymbol> katakanaSymbols = [
    // --- Vowels (A-row) ---
    KanaSymbol(kana: 'ア', romaji: 'a', script: KanaScript.katakana, group: KanaGroup.vowels),
    KanaSymbol(kana: 'イ', romaji: 'i', script: KanaScript.katakana, group: KanaGroup.vowels),
    KanaSymbol(kana: 'ウ', romaji: 'u', script: KanaScript.katakana, group: KanaGroup.vowels),
    KanaSymbol(kana: 'エ', romaji: 'e', script: KanaScript.katakana, group: KanaGroup.vowels),
    KanaSymbol(kana: 'オ', romaji: 'o', script: KanaScript.katakana, group: KanaGroup.vowels),

    // --- Ka-row ---
    KanaSymbol(kana: 'カ', romaji: 'ka', script: KanaScript.katakana, group: KanaGroup.ka),
    KanaSymbol(kana: 'キ', romaji: 'ki', script: KanaScript.katakana, group: KanaGroup.ka),
    KanaSymbol(kana: 'ク', romaji: 'ku', script: KanaScript.katakana, group: KanaGroup.ka),
    KanaSymbol(kana: 'ケ', romaji: 'ke', script: KanaScript.katakana, group: KanaGroup.ka),
    KanaSymbol(kana: 'コ', romaji: 'ko', script: KanaScript.katakana, group: KanaGroup.ka),

    // --- Sa-row ---
    KanaSymbol(kana: 'サ', romaji: 'sa', script: KanaScript.katakana, group: KanaGroup.sa),
    KanaSymbol(kana: 'シ', romaji: 'shi', script: KanaScript.katakana, group: KanaGroup.sa, alternatives: ['si']),
    KanaSymbol(kana: 'ス', romaji: 'su', script: KanaScript.katakana, group: KanaGroup.sa),
    KanaSymbol(kana: 'セ', romaji: 'se', script: KanaScript.katakana, group: KanaGroup.sa),
    KanaSymbol(kana: 'ソ', romaji: 'so', script: KanaScript.katakana, group: KanaGroup.sa),

    // --- Ta-row ---
    KanaSymbol(kana: 'タ', romaji: 'ta', script: KanaScript.katakana, group: KanaGroup.ta),
    KanaSymbol(kana: 'チ', romaji: 'chi', script: KanaScript.katakana, group: KanaGroup.ta, alternatives: ['ti']),
    KanaSymbol(kana: 'ツ', romaji: 'tsu', script: KanaScript.katakana, group: KanaGroup.ta, alternatives: ['tu']),
    KanaSymbol(kana: 'テ', romaji: 'te', script: KanaScript.katakana, group: KanaGroup.ta),
    KanaSymbol(kana: 'ト', romaji: 'to', script: KanaScript.katakana, group: KanaGroup.ta),

    // --- Na-row ---
    KanaSymbol(kana: 'ナ', romaji: 'na', script: KanaScript.katakana, group: KanaGroup.na),
    KanaSymbol(kana: 'ニ', romaji: 'ni', script: KanaScript.katakana, group: KanaGroup.na),
    KanaSymbol(kana: 'ヌ', romaji: 'nu', script: KanaScript.katakana, group: KanaGroup.na),
    KanaSymbol(kana: 'ネ', romaji: 'ne', script: KanaScript.katakana, group: KanaGroup.na),
    KanaSymbol(kana: 'ノ', romaji: 'no', script: KanaScript.katakana, group: KanaGroup.na),

    // --- Ha-row ---
    KanaSymbol(kana: 'ハ', romaji: 'ha', script: KanaScript.katakana, group: KanaGroup.ha),
    KanaSymbol(kana: 'ヒ', romaji: 'hi', script: KanaScript.katakana, group: KanaGroup.ha),
    KanaSymbol(kana: 'フ', romaji: 'fu', script: KanaScript.katakana, group: KanaGroup.ha, alternatives: ['hu']),
    KanaSymbol(kana: 'ヘ', romaji: 'he', script: KanaScript.katakana, group: KanaGroup.ha),
    KanaSymbol(kana: 'ホ', romaji: 'ho', script: KanaScript.katakana, group: KanaGroup.ha),

    // --- Ma-row ---
    KanaSymbol(kana: 'マ', romaji: 'ma', script: KanaScript.katakana, group: KanaGroup.ma),
    KanaSymbol(kana: 'ミ', romaji: 'mi', script: KanaScript.katakana, group: KanaGroup.ma),
    KanaSymbol(kana: 'ム', romaji: 'mu', script: KanaScript.katakana, group: KanaGroup.ma),
    KanaSymbol(kana: 'メ', romaji: 'me', script: KanaScript.katakana, group: KanaGroup.ma),
    KanaSymbol(kana: 'モ', romaji: 'mo', script: KanaScript.katakana, group: KanaGroup.ma),

    // --- Ya-row ---
    KanaSymbol(kana: 'ヤ', romaji: 'ya', script: KanaScript.katakana, group: KanaGroup.ya),
    KanaSymbol(kana: 'ユ', romaji: 'yu', script: KanaScript.katakana, group: KanaGroup.ya),
    KanaSymbol(kana: 'ヨ', romaji: 'yo', script: KanaScript.katakana, group: KanaGroup.ya),

    // --- Ra-row ---
    KanaSymbol(kana: 'ラ', romaji: 'ra', script: KanaScript.katakana, group: KanaGroup.ra),
    KanaSymbol(kana: 'リ', romaji: 'ri', script: KanaScript.katakana, group: KanaGroup.ra),
    KanaSymbol(kana: 'ル', romaji: 'ru', script: KanaScript.katakana, group: KanaGroup.ra),
    KanaSymbol(kana: 'レ', romaji: 're', script: KanaScript.katakana, group: KanaGroup.ra),
    KanaSymbol(kana: 'ロ', romaji: 'ro', script: KanaScript.katakana, group: KanaGroup.ra),

    // --- Wa-row & N ---
    KanaSymbol(kana: 'ワ', romaji: 'wa', script: KanaScript.katakana, group: KanaGroup.wa),
    KanaSymbol(kana: 'ヲ', romaji: 'wo', script: KanaScript.katakana, group: KanaGroup.wa, alternatives: ['o']),
    KanaSymbol(kana: 'ン', romaji: 'n', script: KanaScript.katakana, group: KanaGroup.wa, alternatives: ['nn']),

    // --- Dakuten ---
    KanaSymbol(kana: 'ガ', romaji: 'ga', script: KanaScript.katakana, group: KanaGroup.dakuten),
    KanaSymbol(kana: 'ギ', romaji: 'gi', script: KanaScript.katakana, group: KanaGroup.dakuten),
    KanaSymbol(kana: 'グ', romaji: 'gu', script: KanaScript.katakana, group: KanaGroup.dakuten),
    KanaSymbol(kana: 'ゲ', romaji: 'ge', script: KanaScript.katakana, group: KanaGroup.dakuten),
    KanaSymbol(kana: 'ゴ', romaji: 'go', script: KanaScript.katakana, group: KanaGroup.dakuten),

    KanaSymbol(kana: 'ザ', romaji: 'za', script: KanaScript.katakana, group: KanaGroup.dakuten),
    KanaSymbol(kana: 'ジ', romaji: 'ji', script: KanaScript.katakana, group: KanaGroup.dakuten, alternatives: ['zi']),
    KanaSymbol(kana: 'ズ', romaji: 'zu', script: KanaScript.katakana, group: KanaGroup.dakuten),
    KanaSymbol(kana: 'ゼ', romaji: 'ze', script: KanaScript.katakana, group: KanaGroup.dakuten),
    KanaSymbol(kana: 'ゾ', romaji: 'zo', script: KanaScript.katakana, group: KanaGroup.dakuten),

    KanaSymbol(kana: 'ダ', romaji: 'da', script: KanaScript.katakana, group: KanaGroup.dakuten),
    KanaSymbol(kana: 'ヂ', romaji: 'ji', script: KanaScript.katakana, group: KanaGroup.dakuten, alternatives: ['di', 'dji']),
    KanaSymbol(kana: 'ヅ', romaji: 'zu', script: KanaScript.katakana, group: KanaGroup.dakuten, alternatives: ['dzu', 'du']),
    KanaSymbol(kana: 'デ', romaji: 'de', script: KanaScript.katakana, group: KanaGroup.dakuten),
    KanaSymbol(kana: 'ド', romaji: 'do', script: KanaScript.katakana, group: KanaGroup.dakuten),

    KanaSymbol(kana: 'バ', romaji: 'ba', script: KanaScript.katakana, group: KanaGroup.dakuten),
    KanaSymbol(kana: 'ビ', romaji: 'bi', script: KanaScript.katakana, group: KanaGroup.dakuten),
    KanaSymbol(kana: 'ブ', romaji: 'bu', script: KanaScript.katakana, group: KanaGroup.dakuten),
    KanaSymbol(kana: 'ベ', romaji: 'be', script: KanaScript.katakana, group: KanaGroup.dakuten),
    KanaSymbol(kana: 'ボ', romaji: 'bo', script: KanaScript.katakana, group: KanaGroup.dakuten),

    // --- Handakuten ---
    KanaSymbol(kana: 'パ', romaji: 'pa', script: KanaScript.katakana, group: KanaGroup.handakuten),
    KanaSymbol(kana: 'ピ', romaji: 'pi', script: KanaScript.katakana, group: KanaGroup.handakuten),
    KanaSymbol(kana: 'プ', romaji: 'pu', script: KanaScript.katakana, group: KanaGroup.handakuten),
    KanaSymbol(kana: 'ペ', romaji: 'pe', script: KanaScript.katakana, group: KanaGroup.handakuten),
    KanaSymbol(kana: 'ポ', romaji: 'po', script: KanaScript.katakana, group: KanaGroup.handakuten),
  ];

  /// Returns basic gojūon (A to N) excluding Dakuten / Handakuten.
  static List<KanaSymbol> get basicGojuon => hiraganaSymbols
      .where((s) => s.group != KanaGroup.dakuten && s.group != KanaGroup.handakuten)
      .toList();

  /// Returns 'a' through 'so' (Vowels, Ka-row, Sa-row: 15 symbols).
  static List<KanaSymbol> get aThroughSo => hiraganaSymbols
      .where((s) =>
          s.group == KanaGroup.vowels ||
          s.group == KanaGroup.ka ||
          s.group == KanaGroup.sa)
      .toList();
}
