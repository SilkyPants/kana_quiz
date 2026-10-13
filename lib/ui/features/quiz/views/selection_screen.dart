import 'package:flutter/material.dart';
import '../../../../domain/models/kana_symbol.dart';
import '../../../../main.dart';
import '../view_models/selection_view_model.dart';
import 'quiz_screen.dart';

/// Screen allowing users to select Hiragana (and Katakana) symbols for practice.
class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  late final SelectionViewModel _viewModel;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _viewModel = SelectionViewModel();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  void _startQuiz() {
    if (!_viewModel.canStart) return;

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => QuizScreen(
          symbols: _viewModel.selectedSymbols.toList(),
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    final theme = Theme.of(context);
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                'assets/icon/app_icon.png',
                width: 32,
                height: 32,
              ),
            ),
            const SizedBox(width: 12),
            const Text('Kana Quiz Master'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'A clean tool to test and master Japanese Kana (Hiragana & Katakana).',
            ),
            const SizedBox(height: 16),
            Text(
              'Icon Attribution:',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SelectableText(
                'Flashcard icons created by Flat Icons - Flaticon\nhttps://www.flaticon.com/free-icons/flashcard',
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.primary,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeController = ThemeScope.of(context);
    final isCompact = MediaQuery.sizeOf(context).width < 640;

    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    'assets/icon/app_icon.png',
                    width: 28,
                    height: 28,
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    isCompact ? 'Kana Quiz' : 'Kana Quiz Master',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            actions: [
              // Responsive Theme Mode Selector
              if (isCompact)
                PopupMenuButton<ThemeMode>(
                  tooltip: 'Theme Mode',
                  icon: Icon(
                    themeController.themeMode == ThemeMode.system
                        ? Icons.brightness_auto
                        : (themeController.themeMode == ThemeMode.dark
                            ? Icons.dark_mode
                            : Icons.light_mode),
                    size: 20,
                  ),
                  initialValue: themeController.themeMode,
                  onSelected: (mode) => themeController.setThemeMode(mode),
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: ThemeMode.system,
                      child: Row(
                        children: [
                          Icon(Icons.brightness_auto, size: 18),
                          SizedBox(width: 10),
                          Text('System Theme'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: ThemeMode.light,
                      child: Row(
                        children: [
                          Icon(Icons.light_mode, size: 18),
                          SizedBox(width: 10),
                          Text('Light Theme'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: ThemeMode.dark,
                      child: Row(
                        children: [
                          Icon(Icons.dark_mode, size: 18),
                          SizedBox(width: 10),
                          Text('Dark Theme'),
                        ],
                      ),
                    ),
                  ],
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: SegmentedButton<ThemeMode>(
                    showSelectedIcon: false,
                    style: const ButtonStyle(
                      visualDensity: VisualDensity.compact,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    segments: const [
                      ButtonSegment(
                        value: ThemeMode.system,
                        icon: Icon(Icons.brightness_auto, size: 16),
                        tooltip: 'System Theme',
                      ),
                      ButtonSegment(
                        value: ThemeMode.light,
                        icon: Icon(Icons.light_mode, size: 16),
                        tooltip: 'Light Theme',
                      ),
                      ButtonSegment(
                        value: ThemeMode.dark,
                        icon: Icon(Icons.dark_mode, size: 16),
                        tooltip: 'Dark Theme',
                      ),
                    ],
                    selected: {themeController.themeMode},
                    onSelectionChanged: (selected) {
                      themeController.setThemeMode(selected.first);
                    },
                  ),
                ),
              IconButton(
                icon: const Icon(Icons.info_outline, size: 20),
                tooltip: 'About & Attribution',
                onPressed: () => _showAboutDialog(context),
              ),
              const SizedBox(width: 8),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                color: theme.dividerColor.withValues(alpha: 0.2),
                height: 1,
              ),
            ),
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1400),
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                trackVisibility: true,
                interactive: true,
                child: ListView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                  children: [
                    // --- Header & Script Selector ---
                    LayoutBuilder(
                      builder: (context, headerConstraints) {
                        final isHeaderNarrow = headerConstraints.maxWidth < 650;
                        return Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 16,
                          runSpacing: 14,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: isHeaderNarrow
                                    ? headerConstraints.maxWidth
                                    : 450,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Select Symbols to Practice',
                                    style: theme.textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Choose individual symbols or toggle rows below',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.textTheme.bodyMedium?.color
                                          ?.withValues(alpha: 0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SegmentedButton<KanaScript>(
                              segments: [
                                ButtonSegment(
                                  value: KanaScript.hiragana,
                                  label: Text(
                                    isHeaderNarrow
                                        ? 'Hiragana'
                                        : 'Hiragana (平仮名)',
                                  ),
                                ),
                                ButtonSegment(
                                  value: KanaScript.katakana,
                                  label: Text(
                                    isHeaderNarrow
                                        ? 'Katakana'
                                        : 'Katakana (片仮名)',
                                  ),
                                ),
                              ],
                              selected: {_viewModel.selectedScript},
                              onSelectionChanged: (selected) {
                                _viewModel.setScript(selected.first);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 18),

                    // --- Quick Selection Actions ---
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ActionChip(
                          avatar: const Icon(Icons.select_all, size: 16),
                          label: const Text('Select All'),
                          onPressed: _viewModel.selectAll,
                        ),
                        ActionChip(
                          avatar: const Icon(Icons.clear, size: 16),
                          label: const Text('Clear All'),
                          onPressed: _viewModel.clearAll,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // --- Responsive Multi-Column Kana Groups ---
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final width = constraints.maxWidth;
                        final int crossAxisCount;
                        if (width >= 1200) {
                          crossAxisCount = 3;
                        } else if (width >= 780) {
                          crossAxisCount = 2;
                        } else {
                          crossAxisCount = 1;
                        }

                        final entries =
                            _viewModel.groupedSymbols.entries.toList();
                        final columns = List.generate(
                          crossAxisCount,
                          (_) => <Widget>[],
                        );

                        for (int i = 0; i < entries.length; i++) {
                          final entry = entries[i];
                          columns[i % crossAxisCount].add(
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _KanaGroupCard(
                                group: entry.key,
                                symbols: entry.value,
                                isFullySelected:
                                    _viewModel.isGroupFullySelected(entry.key),
                                isPartiallySelected:
                                    _viewModel.isGroupPartiallySelected(entry.key),
                                isSymbolSelected: _viewModel.isSymbolSelected,
                                onToggleGroup: () =>
                                    _viewModel.toggleGroup(entry.key),
                                onToggleSymbol: _viewModel.toggleSymbol,
                              ),
                            ),
                          );
                        }

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int col = 0; col < crossAxisCount; col++) ...[
                              if (col > 0) const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: columns[col],
                                ),
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 28),
                    Center(
                      child: Text(
                        'Flashcard icons created by Flat Icons - Flaticon',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: theme.cardTheme.color ?? theme.colorScheme.surfaceContainerLow,
                border: Border(
                  top: BorderSide(
                    color: theme.dividerColor.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Align(
                alignment: Alignment.center,
                heightFactor: 1.0,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1400),
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 16,
                    runSpacing: 10,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            color: _viewModel.canStart
                                ? theme.colorScheme.primary
                                : Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              '${_viewModel.selectedCount} symbols selected',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: _viewModel.canStart ? _startQuiz : null,
                        icon: const Icon(Icons.play_arrow_rounded),
                        label: const Text('Start Quiz'),
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

class _KanaGroupCard extends StatelessWidget {
  const _KanaGroupCard({
    required this.group,
    required this.symbols,
    required this.isFullySelected,
    required this.isPartiallySelected,
    required this.isSymbolSelected,
    required this.onToggleGroup,
    required this.onToggleSymbol,
  });

  final KanaGroup group;
  final List<KanaSymbol> symbols;
  final bool isFullySelected;
  final bool isPartiallySelected;
  final bool Function(KanaSymbol) isSymbolSelected;
  final VoidCallback onToggleGroup;
  final ValueChanged<KanaSymbol> onToggleSymbol;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row header with group label and select toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    group.label,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 6),
                TextButton.icon(
                  onPressed: onToggleGroup,
                  style: TextButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  ),
                  icon: Icon(
                    isFullySelected
                        ? Icons.check_box
                        : (isPartiallySelected
                            ? Icons.indeterminate_check_box
                            : Icons.check_box_outline_blank),
                    size: 18,
                    color: (isFullySelected || isPartiallySelected)
                        ? theme.colorScheme.primary
                        : Colors.grey,
                  ),
                  label: Text(
                    isFullySelected ? 'Deselect' : 'Select',
                    style: TextStyle(
                      color: (isFullySelected || isPartiallySelected)
                          ? theme.colorScheme.primary
                          : Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Kana symbols grid
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final symbol in symbols)
                  _KanaTile(
                    symbol: symbol,
                    isSelected: isSymbolSelected(symbol),
                    onTap: () => onToggleSymbol(symbol),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _KanaTile extends StatelessWidget {
  const _KanaTile({
    required this.symbol,
    required this.isSelected,
    required this.onTap,
  });

  final KanaSymbol symbol;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final isDark = theme.brightness == Brightness.dark;

    final tileColor = isSelected
        ? primary.withValues(alpha: isDark ? 0.22 : 0.08)
        : (isDark ? const Color(0xFF262130) : Colors.white);
    final borderColor = isSelected
        ? primary
        : (isDark ? const Color(0xFF383144) : Colors.grey.shade300);
    final textColor = isSelected
        ? primary
        : (isDark ? const Color(0xFFF3EEF8) : Colors.black87);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 62,
        height: 72,
        decoration: BoxDecoration(
          color: tileColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: borderColor,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primary.withValues(alpha: 0.15),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              symbol.kana,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              symbol.romaji,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? primary
                    : (isDark ? Colors.grey.shade400 : Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
