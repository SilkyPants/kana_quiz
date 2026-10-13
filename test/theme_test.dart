import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kana_quiz/main.dart';
import 'package:kana_quiz/ui/core/theme_controller.dart';

void main() {
  group('ThemeController', () {
    test('defaults to ThemeMode.system', () {
      final controller = ThemeController();
      expect(controller.themeMode, equals(ThemeMode.system));
    });

    test('updates themeMode and notifies listeners', () {
      final controller = ThemeController();
      var notified = false;
      controller.addListener(() => notified = true);

      controller.setThemeMode(ThemeMode.dark);
      expect(controller.themeMode, equals(ThemeMode.dark));
      expect(notified, isTrue);

      notified = false;
      controller.setThemeMode(ThemeMode.light);
      expect(controller.themeMode, equals(ThemeMode.light));
      expect(notified, isTrue);
    });
  });

  testWidgets('Theme switch and attribution dialog test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final themeController = ThemeController();
    await tester.pumpWidget(KanaQuizApp(themeController: themeController));
    await tester.pumpAndSettle();

    // Verify initial theme controller mode is system
    expect(themeController.themeMode, equals(ThemeMode.system));

    // Tap dark mode icon in theme segmented switch
    await tester.tap(find.byIcon(Icons.dark_mode));
    await tester.pumpAndSettle();
    expect(themeController.themeMode, equals(ThemeMode.dark));

    // Tap light mode icon
    await tester.tap(find.byIcon(Icons.light_mode));
    await tester.pumpAndSettle();
    expect(themeController.themeMode, equals(ThemeMode.light));

    // Open attribution / info dialog
    await tester.tap(find.byIcon(Icons.info_outline));
    await tester.pumpAndSettle();

    // Verify attribution dialog content
    expect(find.text('Icon Attribution:'), findsOneWidget);
    expect(
      find.textContaining('Flashcard icons created by Flat Icons - Flaticon'),
      findsWidgets,
    );

    // Close dialog
    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();
    expect(find.text('Icon Attribution:'), findsNothing);
  });
}
