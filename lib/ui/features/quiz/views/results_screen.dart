import 'package:flutter/material.dart';
import '../../../../domain/models/kana_symbol.dart';
import '../view_models/quiz_view_model.dart';
import 'quiz_screen.dart';

/// Filter mode for reviewing answers on the results screen.
enum ResultFilter { all, correct, incorrect }

/// Screen displaying the final score, accuracy percentage, and itemized breakdown.
class ResultsScreen extends StatefulWidget {
  const ResultsScreen({
    super.key,
    required this.results,
    required this.originalSymbols,
  });

  final List<QuizQuestionResult> results;
  final List<KanaSymbol> originalSymbols;

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  final ScrollController _scrollController = ScrollController();
  ResultFilter _filter = ResultFilter.all;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = widget.results.length;
    final correct = widget.results.where((r) => r.isCorrect).length;
    final incorrect = total - correct;
    final accuracy = total == 0 ? 0.0 : (correct / total) * 100;

    final List<QuizQuestionResult> filteredResults;
    switch (_filter) {
      case ResultFilter.all:
        filteredResults = widget.results;
      case ResultFilter.correct:
        filteredResults = widget.results.where((r) => r.isCorrect).toList();
      case ResultFilter.incorrect:
        filteredResults = widget.results.where((r) => !r.isCorrect).toList();
    }

    final String performanceTitle;
    final String performanceSubtitle;
    final Color badgeColor;

    if (accuracy >= 90) {
      performanceTitle = 'Taihen Yoku Dekimashita! (大変よくできました)';
      performanceSubtitle = 'Outstanding mastery! Keep up the brilliant work.';
      badgeColor = const Color(0xFF2B8A3E);
    } else if (accuracy >= 70) {
      performanceTitle = 'Yoku Dekimashita! (よくできました)';
      performanceSubtitle = 'Great job! A little more practice and you will master it.';
      badgeColor = const Color(0xFF1971C2);
    } else {
      performanceTitle = 'Ganbatte! (がんばって)';
      performanceSubtitle = 'Good practice session! Review the missed symbols below.';
      badgeColor = const Color(0xFFE67700);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back to Selection',
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            trackVisibility: true,
            interactive: true,
            child: ListView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              children: [
                // --- Score Overview Card ---
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: badgeColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            performanceTitle,
                            style: TextStyle(
                              color: badgeColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '${accuracy.toStringAsFixed(1)}%',
                          style: theme.textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: badgeColor,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '$correct of $total correct',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.8),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          performanceSubtitle,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // --- Actions (Restart or Back) ---
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.list_alt_rounded),
                        label: const Text('Change Symbols'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute<void>(
                              builder: (context) => QuizScreen(
                                symbols: widget.originalSymbols,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.replay_rounded),
                        label: const Text('Practice Again'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // --- Review Header & Filter Controls ---
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 12,
                  runSpacing: 10,
                  children: [
                    Text(
                      'Review Answers (${filteredResults.length})',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SegmentedButton<ResultFilter>(
                      showSelectedIcon: false,
                      style: const ButtonStyle(
                        visualDensity: VisualDensity.compact,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      segments: [
                        ButtonSegment(
                          value: ResultFilter.all,
                          label: Text('All ($total)'),
                        ),
                        ButtonSegment(
                          value: ResultFilter.correct,
                          label: Text('Correct ($correct)'),
                        ),
                        ButtonSegment(
                          value: ResultFilter.incorrect,
                          label: Text('Incorrect ($incorrect)'),
                        ),
                      ],
                      selected: {_filter},
                      onSelectionChanged: (selected) {
                        setState(() => _filter = selected.first);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // --- Question Breakdown List ---
                if (filteredResults.isEmpty)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
                      child: Center(
                        child: Text(
                          _filter == ResultFilter.incorrect
                              ? 'No incorrect answers! Outstanding! 🎉'
                              : 'No answers match this filter.',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  for (final result in filteredResults) ...[
                    _ResultItemCard(result: result),
                    const SizedBox(height: 8),
                  ],
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ResultItemCard extends StatelessWidget {
  const _ResultItemCard({required this.result});

  final QuizQuestionResult result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCorrect = result.isCorrect;
    final statusColor =
        isCorrect ? const Color(0xFF2B8A3E) : theme.colorScheme.primary;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: statusColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Status Icon
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isCorrect ? Icons.check : Icons.close,
                color: statusColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),

            // Kana Symbol
            Text(
              result.symbol.kana,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 16),

            // Correct Romaji
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Correct: ${result.symbol.romaji}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                  if (result.symbol.alternatives.isNotEmpty)
                    Text(
                      'Also: ${result.symbol.alternatives.join(", ")}',
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                      ),
                    ),
                ],
              ),
            ),

            // User's answer
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isCorrect
                    ? const Color(0xFF2B8A3E).withValues(alpha: 0.15)
                    : theme.colorScheme.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                result.enteredInput.isEmpty
                    ? '(Skipped)'
                    : 'Typed: "${result.enteredInput}"',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: isCorrect
                      ? const Color(0xFF2B8A3E)
                      : theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
