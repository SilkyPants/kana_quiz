import 'package:flutter_test/flutter_test.dart';
import 'package:kana_quiz/data/kana_dataset.dart';
import 'package:kana_quiz/domain/models/kana_symbol.dart';

void main() {
  group('KanaSymbol model & matching', () {
    test('matches exact romaji ignoring case and whitespace', () {
      const symbol = KanaSymbol(
        kana: 'あ',
        romaji: 'a',
        script: KanaScript.hiragana,
        group: KanaGroup.vowels,
      );

      expect(symbol.matches('a'), isTrue);
      expect(symbol.matches('A'), isTrue);
      expect(symbol.matches('  a  '), isTrue);
      expect(symbol.matches('o'), isFalse);
      expect(symbol.matches(''), isFalse);
    });

    test('matches alternative romanizations', () {
      const shiSymbol = KanaSymbol(
        kana: 'し',
        romaji: 'shi',
        script: KanaScript.hiragana,
        group: KanaGroup.sa,
        alternatives: ['si'],
      );

      expect(shiSymbol.matches('shi'), isTrue);
      expect(shiSymbol.matches('si'), isTrue);
      expect(shiSymbol.matches('SI'), isTrue);
      expect(shiSymbol.matches('su'), isFalse);

      const tsuSymbol = KanaSymbol(
        kana: 'つ',
        romaji: 'tsu',
        script: KanaScript.hiragana,
        group: KanaGroup.ta,
        alternatives: ['tu'],
      );

      expect(tsuSymbol.matches('tsu'), isTrue);
      expect(tsuSymbol.matches('tu'), isTrue);
      expect(tsuSymbol.matches('to'), isFalse);
    });
  });

  group('KanaDataset', () {
    test('contains full Hiragana dataset', () {
      expect(KanaDataset.hiraganaSymbols.length, greaterThanOrEqualTo(46));
    });

    test('aThroughSo preset contains 15 symbols', () {
      final aThroughSo = KanaDataset.aThroughSo;
      expect(aThroughSo.length, equals(15));
      final romajis = aThroughSo.map((s) => s.romaji).toList();
      expect(
        romajis,
        containsAll([
          'a', 'i', 'u', 'e', 'o',
          'ka', 'ki', 'ku', 'ke', 'ko',
          'sa', 'shi', 'su', 'se', 'so',
        ]),
      );
    });

    test('contains full Katakana dataset matching standard kana count', () {
      expect(KanaDataset.katakanaSymbols.length, equals(71));
      expect(
        KanaDataset.katakanaSymbols.every((s) => s.script == KanaScript.katakana),
        isTrue,
      );
    });
  });
}
