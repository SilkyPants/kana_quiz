import 'package:flutter/material.dart';
import 'ui/core/app_theme.dart';
import 'ui/core/theme_controller.dart';
import 'ui/features/quiz/views/selection_screen.dart';

void main() {
  runApp(const KanaQuizApp());
}

/// Scope providing the active [ThemeController] to descendant widgets.
class ThemeScope extends InheritedNotifier<ThemeController> {
  const ThemeScope({
    super.key,
    required ThemeController controller,
    required super.child,
  }) : super(notifier: controller);

  static ThemeController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ThemeScope>();
    assert(scope != null, 'No ThemeScope found in context');
    return scope!.notifier!;
  }
}

/// Root widget for the Kana Quiz application.
class KanaQuizApp extends StatefulWidget {
  const KanaQuizApp({super.key, this.themeController});

  final ThemeController? themeController;

  @override
  State<KanaQuizApp> createState() => _KanaQuizAppState();
}

class _KanaQuizAppState extends State<KanaQuizApp> {
  late final ThemeController _themeController;

  @override
  void initState() {
    super.initState();
    _themeController = widget.themeController ?? ThemeController();
  }

  @override
  void dispose() {
    if (widget.themeController == null) {
      _themeController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _themeController,
      builder: (context, _) {
        return ThemeScope(
          controller: _themeController,
          child: MaterialApp(
            title: 'Kana Quiz Master',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: _themeController.themeMode,
            home: const SelectionScreen(),
          ),
        );
      },
    );
  }
}
