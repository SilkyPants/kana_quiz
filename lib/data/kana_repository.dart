import '../domain/models/kana_symbol.dart';
import 'kana_dataset.dart';

/// Repository responsible for providing Japanese Kana characters by script and group.
class KanaRepository {
  const KanaRepository();

  /// Gets all available symbols for a given [script].
  List<KanaSymbol> getSymbolsForScript(KanaScript script) {
    switch (script) {
      case KanaScript.hiragana:
        return KanaDataset.hiraganaSymbols;
      case KanaScript.katakana:
        return KanaDataset.katakanaSymbols;
    }
  }

  /// Gets groups mapped to symbols for a given [script].
  Map<KanaGroup, List<KanaSymbol>> getGroupsForScript(KanaScript script) {
    final symbols = getSymbolsForScript(script);
    final map = <KanaGroup, List<KanaSymbol>>{};
    for (final s in symbols) {
      map.putIfAbsent(s.group, () => []).add(s);
    }
    return map;
  }
}
