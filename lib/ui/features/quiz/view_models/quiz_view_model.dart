import 'dart:math';
import 'package:flutter/foundation.dart';
import '../../../../domain/models/kana_symbol.dart';

/// Records the outcome of a single question during the quiz.
class QuizQuestionResult {
  const QuizQuestionResult({
    required this.symbol,
    required this.enteredInput,
    required this.isCorrect,
  });

  final KanaSymbol symbol;
  final String enteredInput;
  final bool isCorrect;
}

/// ViewModel that drives the active quiz session, progress, scoring, and review.
class QuizViewModel extends ChangeNotifier {
  QuizViewModel({
    required List<KanaSymbol> symbols,
    Random? random,
  })  : assert(symbols.isNotEmpty, 'Quiz cannot start with empty symbol list'),
        _initialSymbols = List.unmodifiable(symbols),
        _random = random ?? Random() {
    _initializeQuiz();
  }

  final List<KanaSymbol> _initialSymbols;
  final Random _random;

  late List<KanaSymbol> _queue;
  final List<QuizQuestionResult> _results = [];
  int _currentIndex = 0;

  void _initializeQuiz() {
    _queue = List<KanaSymbol>.from(_initialSymbols)..shuffle(_random);
    _results.clear();
    _currentIndex = 0;
  }

  /// Total number of questions in this quiz session.
  int get totalQuestions => _queue.length;

  /// Current 1-based question number for display (capped at totalQuestions).
  int get currentQuestionNumber =>
      _isFinished ? totalQuestions : _currentIndex + 1;

  /// Whether the entire quiz has completed.
  bool get isFinished => _currentIndex >= _queue.length;

  /// The active kana symbol currently being quizzed.
  KanaSymbol? get currentSymbol =>
      isFinished ? null : _queue[_currentIndex];

  /// Progress fraction from 0.0 to 1.0.
  double get progress =>
      totalQuestions == 0 ? 0.0 : (_currentIndex / totalQuestions);

  /// Number of correct answers so far.
  int get correctCount => _results.where((r) => r.isCorrect).length;

  /// Accuracy percentage from 0.0 to 100.0.
  double get accuracyPercentage =>
      _results.isEmpty ? 0.0 : (correctCount / _results.length) * 100;

  /// Detailed results for all completed questions.
  List<QuizQuestionResult> get results => List.unmodifiable(_results);

  /// Submits an answer for the current symbol and advances to the next.
  bool submitAnswer(String answer) {
    if (isFinished) return false;

    final symbol = currentSymbol!;
    final isCorrect = symbol.matches(answer);

    _results.add(QuizQuestionResult(
      symbol: symbol,
      enteredInput: answer.trim(),
      isCorrect: isCorrect,
    ));

    _currentIndex++;
    notifyListeners();
    return isCorrect;
  }

  /// Restarts the quiz with the same set of symbols.
  void restart() {
    _initializeQuiz();
    notifyListeners();
  }

  bool get _isFinished => _currentIndex >= _queue.length;
}
