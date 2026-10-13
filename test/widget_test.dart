import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kana_quiz/domain/models/kana_symbol.dart';
import 'package:kana_quiz/main.dart';
import 'package:kana_quiz/ui/features/quiz/view_models/quiz_view_model.dart';
import 'package:kana_quiz/ui/features/quiz/views/results_screen.dart';

void main() {
  testWidgets('KanaQuizApp smoke test - selection screen, row toggle, and quiz flow',
      (WidgetTester tester) async {
    // Set a large surface size to simulate desktop window dimensions
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const KanaQuizApp());
    await tester.pumpAndSettle();

    // Verify title and header are shown
    expect(find.text('Kana Quiz Master'), findsOneWidget);
    expect(find.text('Select Symbols to Practice'), findsOneWidget);

    // Initial state: all symbols in Hiragana are selected (71 symbols)
    expect(find.text('71 symbols selected'), findsOneWidget);
    expect(find.text('Start Quiz'), findsOneWidget);

    // Test Clear All
    await tester.tap(find.text('Clear All'));
    await tester.pumpAndSettle();
    expect(find.text('0 symbols selected'), findsOneWidget);

    // Select A-row (5 symbols)
    final selectRowButtons = find.text('Select');
    expect(selectRowButtons, findsWidgets);
    await tester.tap(selectRowButtons.first);
    await tester.pumpAndSettle();
    expect(find.text('5 symbols selected'), findsOneWidget);

    // Tap "Start Quiz" button
    await tester.tap(find.text('Start Quiz'));
    await tester.pumpAndSettle();

    // Now on QuizScreen
    expect(find.text('Kana Quiz'), findsOneWidget);
    expect(find.text('Question 1 of 5'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    // Enter answer in text field
    await tester.enterText(find.byType(TextField), 'a');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    // Progressed to next question
    expect(find.text('Question 2 of 5'), findsOneWidget);
  });

  testWidgets('ResultsScreen displays score, allows filtering answers, and handles empty filter states',
      (WidgetTester tester) async {
    final sampleSymbols = [
      const KanaSymbol(
        kana: 'あ',
        romaji: 'a',
        script: KanaScript.hiragana,
        group: KanaGroup.vowels,
      ),
      const KanaSymbol(
        kana: 'い',
        romaji: 'i',
        script: KanaScript.hiragana,
        group: KanaGroup.vowels,
      ),
    ];

    final sampleResults = [
      QuizQuestionResult(
        symbol: sampleSymbols[0],
        enteredInput: 'a',
        isCorrect: true,
      ),
      QuizQuestionResult(
        symbol: sampleSymbols[1],
        enteredInput: 'wrong',
        isCorrect: false,
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: ResultsScreen(
          results: sampleResults,
          originalSymbols: sampleSymbols,
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify score card and scrollbar presence
    expect(find.text('Quiz Results'), findsOneWidget);
    expect(find.text('50.0%'), findsOneWidget);
    expect(find.text('1 of 2 correct'), findsOneWidget);
    expect(find.byType(Scrollbar), findsOneWidget);

    // Initial filter is 'All'
    expect(find.text('あ'), findsOneWidget);
    expect(find.text('い'), findsOneWidget);

    // Switch filter to 'Correct'
    await tester.tap(find.text('Correct (1)'));
    await tester.pumpAndSettle();
    expect(find.text('あ'), findsOneWidget);
    expect(find.text('い'), findsNothing);

    // Switch filter to 'Incorrect'
    await tester.tap(find.text('Incorrect (1)'));
    await tester.pumpAndSettle();
    expect(find.text('あ'), findsNothing);
    expect(find.text('い'), findsOneWidget);
    expect(find.text('Typed: "wrong"'), findsOneWidget);
  });

  testWidgets('SelectionScreen renders compact AppBar on narrow viewports without overflow',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(380, 700);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const KanaQuizApp());
    await tester.pumpAndSettle();

    // Narrow layout displays compact title 'Kana Quiz' and PopupMenuButton
    expect(find.text('Kana Quiz'), findsOneWidget);
    expect(find.byType(PopupMenuButton<ThemeMode>), findsOneWidget);
    expect(find.byType(Scrollbar), findsOneWidget);
  });
}
