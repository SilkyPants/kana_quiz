import 'package:flutter/material.dart';
import '../../../../domain/models/kana_symbol.dart';
import '../view_models/quiz_view_model.dart';
import 'results_screen.dart';

/// Screen for the active Kana quiz where the user views symbols and types romaji readings.
class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.symbols});

  final List<KanaSymbol> symbols;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final QuizViewModel _viewModel;
  late final TextEditingController _textController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _viewModel = QuizViewModel(symbols: widget.symbols);
    _textController = TextEditingController();
    _focusNode = FocusNode();

    // Auto-focus the input as soon as widget builds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submitAnswer() {
    final text = _textController.text;
    _textController.clear();

    _viewModel.submitAnswer(text);

    if (_viewModel.isFinished) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (context) => ResultsScreen(
            results: _viewModel.results,
            originalSymbols: widget.symbols,
          ),
        ),
      );
    } else {
      _focusNode.requestFocus();
    }
  }

  void _skip() {
    _textController.clear();
    _viewModel.submitAnswer('');

    if (_viewModel.isFinished) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (context) => ResultsScreen(
            results: _viewModel.results,
            originalSymbols: widget.symbols,
          ),
        ),
      );
    } else {
      _focusNode.requestFocus();
    }
  }

  Future<bool> _onWillPop() async {
    final shouldLeave = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quit Quiz?'),
        content: const Text(
          'Your progress for this session will be lost.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Continue Quiz'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Quit'),
          ),
        ],
      ),
    );
    return shouldLeave ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        final currentSymbol = _viewModel.currentSymbol;

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) async {
            if (didPop) return;
            final canLeave = await _onWillPop();
            if (canLeave && context.mounted) {
              Navigator.of(context).pop();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Kana Quiz'),
              leading: IconButton(
                icon: const Icon(Icons.close),
                tooltip: 'Exit Quiz',
                onPressed: () async {
                  final canLeave = await _onWillPop();
                  if (canLeave && context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(6),
                child: LinearProgressIndicator(
                  value: _viewModel.progress,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 540),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Question Counter Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Question ${_viewModel.currentQuestionNumber} of ${_viewModel.totalQuestions}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.primary,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Japanese Character Card
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: BorderSide(
                            color: theme.dividerColor.withValues(alpha: 0.15),
                            width: 1.5,
                          ),
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 48),
                          alignment: Alignment.center,
                          child: Text(
                            currentSymbol?.kana ?? '',
                            style: const TextStyle(
                              fontSize: 120,
                              fontWeight: FontWeight.bold,
                              height: 1.1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Input instructions
                      Text(
                        'Type the reading in Romaji and press Enter',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Romaji Text Input
                      TextField(
                        controller: _textController,
                        focusNode: _focusNode,
                        autofocus: true,
                        textAlign: TextAlign.center,
                        textInputAction: TextInputAction.done,
                        autocorrect: false,
                        enableSuggestions: false,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'e.g. "so"',
                          hintStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          ),
                        ),
                        onSubmitted: (_) => _submitAnswer(),
                      ),
                      const SizedBox(height: 20),

                      // Actions (Submit & Skip)
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              onPressed: _skip,
                              child: const Text('Skip'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton.icon(
                              onPressed: _submitAnswer,
                              icon: const Icon(Icons.arrow_forward),
                              label: const Text('Submit'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
