/// Represents the type of Japanese kana script.
enum KanaScript {
  hiragana,
  katakana,
}

/// Represents the phonetic row/group of kana symbols.
enum KanaGroup {
  vowels('A-row (Vowels)'),
  ka('Ka-row (K)'),
  sa('Sa-row (S)'),
  ta('Ta-row (T)'),
  na('Na-row (N)'),
  ha('Ha-row (H)'),
  ma('Ma-row (M)'),
  ya('Ya-row (Y)'),
  ra('Ra-row (R)'),
  wa('Wa-row (W & N)'),
  dakuten('Dakuten (G, Z, D, B)'),
  handakuten('Handakuten (P)');

  const KanaGroup(this.label);
  final String label;
}

/// Domain model representing a single Japanese Kana character and its Romanized readings.
class KanaSymbol {
  const KanaSymbol({
    required this.kana,
    required this.romaji,
    required this.script,
    required this.group,
    this.alternatives = const [],
  });

  /// The Japanese character glyph (e.g. 'あ' or 'そ').
  final String kana;

  /// The standard Romaji representation (e.g. 'a' or 'so').
  final String romaji;

  /// Script category (Hiragana or Katakana).
  final KanaScript script;

  /// Row or family grouping (e.g. Ka-row).
  final KanaGroup group;

  /// Valid alternative romanizations (e.g. 'si' for 'shi', 'tu' for 'tsu').
  final List<String> alternatives;

  /// All valid romanizations in lowercase.
  List<String> get validReadings {
    return [
      romaji.toLowerCase().trim(),
      ...alternatives.map((a) => a.toLowerCase().trim()),
    ];
  }

  /// Checks if the user's input matches this symbol's romanization.
  bool matches(String input) {
    final cleaned = input.toLowerCase().trim();
    if (cleaned.isEmpty) return false;
    return validReadings.contains(cleaned);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KanaSymbol &&
          runtimeType == other.runtimeType &&
          kana == other.kana &&
          script == other.script;

  @override
  int get hashCode => kana.hashCode ^ script.hashCode;

  @override
  String toString() => 'KanaSymbol($kana -> $romaji, script: $script)';
}
