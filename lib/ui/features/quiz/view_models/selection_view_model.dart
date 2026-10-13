import 'package:flutter/foundation.dart';
import '../../../../data/kana_repository.dart';
import '../../../../domain/models/kana_symbol.dart';

/// ViewModel managing the selection of Kana symbols for the upcoming quiz.
class SelectionViewModel extends ChangeNotifier {
  SelectionViewModel({KanaRepository repository = const KanaRepository()})
      : _repository = repository {
    selectAll();
  }

  final KanaRepository _repository;

  KanaScript _selectedScript = KanaScript.hiragana;
  KanaScript get selectedScript => _selectedScript;

  final Set<KanaSymbol> _selectedSymbols = <KanaSymbol>{};
  Set<KanaSymbol> get selectedSymbols => Set.unmodifiable(_selectedSymbols);

  int get selectedCount => _selectedSymbols.length;
  bool get canStart => _selectedSymbols.isNotEmpty;

  /// Changes active script (Hiragana / Katakana) and resets selection.
  void setScript(KanaScript script) {
    if (_selectedScript == script) return;
    _selectedScript = script;
    _selectedSymbols.clear();
    selectAll();
    notifyListeners();
  }

  /// Returns symbols grouped by row for the current script.
  Map<KanaGroup, List<KanaSymbol>> get groupedSymbols =>
      _repository.getGroupsForScript(_selectedScript);

  /// All available symbols in the active script.
  List<KanaSymbol> get allCurrentSymbols =>
      _repository.getSymbolsForScript(_selectedScript);

  /// Checks if a single symbol is currently selected.
  bool isSymbolSelected(KanaSymbol symbol) => _selectedSymbols.contains(symbol);

  /// Toggles an individual symbol.
  void toggleSymbol(KanaSymbol symbol) {
    if (_selectedSymbols.contains(symbol)) {
      _selectedSymbols.remove(symbol);
    } else {
      _selectedSymbols.add(symbol);
    }
    notifyListeners();
  }

  /// Checks if all symbols in a group are selected.
  bool isGroupFullySelected(KanaGroup group) {
    final groupList = groupedSymbols[group] ?? [];
    if (groupList.isEmpty) return false;
    return groupList.every(_selectedSymbols.contains);
  }

  /// Checks if some (but not all) symbols in a group are selected.
  bool isGroupPartiallySelected(KanaGroup group) {
    final groupList = groupedSymbols[group] ?? [];
    if (groupList.isEmpty) return false;
    final count = groupList.where(_selectedSymbols.contains).length;
    return count > 0 && count < groupList.length;
  }

  /// Toggles an entire row/group.
  void toggleGroup(KanaGroup group) {
    final groupList = groupedSymbols[group] ?? [];
    if (groupList.isEmpty) return;

    if (isGroupFullySelected(group)) {
      _selectedSymbols.removeAll(groupList);
    } else {
      _selectedSymbols.addAll(groupList);
    }
    notifyListeners();
  }

  /// Selects all available symbols in the active script.
  void selectAll() {
    _selectedSymbols.clear();
    _selectedSymbols.addAll(allCurrentSymbols);
    notifyListeners();
  }

  /// Clears all selected symbols.
  void clearAll() {
    _selectedSymbols.clear();
    notifyListeners();
  }
}
