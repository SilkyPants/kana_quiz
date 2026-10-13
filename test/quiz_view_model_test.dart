import 'package:flutter_test/flutter_test.dart';
import 'package:kana_quiz/domain/models/kana_symbol.dart';
import 'package:kana_quiz/ui/features/quiz/view_models/quiz_view_model.dart';

void main() {
  group('QuizViewModel', () {
    const symbols = [
      KanaSymbol(kana: 'あ', romaji: 'a', script: KanaScript.hiragana, group: KanaGroup.vowels),
      KanaSymbol(kana: 'そ', romaji: 'so', script: KanaScript.hiragana, group: KanaGroup.sa),
    ];

    test('initializes queue and progress correctly', () {
      final vm = QuizViewModel(symbols: symbols);
      expect(vm.totalQuestions, equals(2));
      expect(vm.currentQuestionNumber, equals(1));
      expect(vm.isFinished, isFalse);
      expect(vm.currentSymbol, isNotNull);
      expect(vm.progress, equals(0.0));
      expect(vm.results, isEmpty);
    });

    test('processes answers and calculates score & accuracy', () {
      final vm = QuizViewModel(symbols: symbols);
      final firstSymbol = vm.currentSymbol!;

      // Submit correct answer for first
      final wasCorrect1 = vm.submitAnswer(firstSymbol.romaji);
      expect(wasCorrect1, isTrue);
      expect(vm.correctCount, equals(1));
      expect(vm.accuracyPercentage, equals(100.0));
      expect(vm.isFinished, isFalse);

      // Submit incorrect answer for second
      final wasCorrect2 = vm.submitAnswer('incorrect');
      expect(wasCorrect2, isFalse);
      expect(vm.correctCount, equals(1));
      expect(vm.accuracyPercentage, equals(50.0));
      expect(vm.isFinished, isTrue);
      expect(vm.currentSymbol, isNull);
      expect(vm.results.length, equals(2));
    });

    test('restart resets state', () {
      final vm = QuizViewModel(symbols: symbols);
      vm.submitAnswer('a');
      vm.submitAnswer('so');
      expect(vm.isFinished, isTrue);

      vm.restart();
      expect(vm.isFinished, isFalse);
      expect(vm.results, isEmpty);
      expect(vm.currentQuestionNumber, equals(1));
    });
  });
}
