# Kana Quiz Master (かなクイズ)

> An interactive cross-platform flashcard application for learning and practising Japanese Hiragana and Katakana — built with Flutter, targeting Windows Desktop and Web.

[![CI / CD](https://github.com/SilkyPants/kana_quiz/actions/workflows/ci.yml/badge.svg)](https://github.com/SilkyPants/kana_quiz/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-7D5BA6.svg)](LICENSE)

---

## ✨ Features

| Feature | Details |
|---|---|
| **Full Kana Coverage** | 71 Hiragana + 71 Katakana — Gojūon, Dakuten (voiced), and Handakuten (semi-voiced) |
| **Flexible Selection** | Toggle individual symbols or entire rows; Select All / Clear All shortcuts |
| **Randomised Quiz** | Symbols are shuffled each session for effective spaced practice |
| **Smart Matching** | Accepts all standard alternative romanisations: `shi`/`si`, `chi`/`ti`, `tsu`/`tu`, `fu`/`hu`, `ji`/`zi` (case & whitespace insensitive) |
| **Detailed Results** | Accuracy percentage, per-symbol breakdown, and filter by All / Correct / Incorrect |
| **Responsive Layout** | 1–3 column grid adapts to window width; scrollable lists with interactive scrollbar |
| **Adaptive Theme** | Light, Dark, and System modes built around `#7D5BA6`; switcher in AppBar |
| **PWA Ready** | Installable as a Progressive Web App with custom icon and manifest |

---

## 📸 Screenshots

> _Run the app and take screenshots to add here._

---

## 🚀 Getting Started

### Prerequisites

| Tool | Minimum Version |
|---|---|
| [Flutter SDK](https://docs.flutter.dev/get-started/install) | **3.10.0** |
| Dart SDK | **3.10.0** (bundled with Flutter) |
| Windows build tools | Visual Studio 2022 with "Desktop development with C++" workload |
| Chrome or Edge | For web development |

Verify your setup:

```bash
flutter doctor
```

### Install Dependencies

```bash
flutter pub get
```

### Run Locally

```bash
# Windows Desktop
flutter run -d windows

# Web (Chrome)
flutter run -d chrome

# Web (Edge)
flutter run -d edge
```

> 💡 In VS Code, press **F5** and select a launch profile from `.vscode/launch.json`.

---

## 🏗️ Building for Release

### Windows

```bash
flutter build windows --release
```

Output: `build\windows\x64\runner\Release\`

### Web

```bash
flutter build web --release
```

Output: `build\web\`

> When building for GitHub Pages, pass the repository sub-path:
> ```bash
> flutter build web --release --base-href /your-repo-name/
> ```

---

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run static analysis
flutter analyze

# Run a single test file
flutter test test/quiz_view_model_test.dart
```

All tests live under `test/`. The suite includes:

| File | What it covers |
|---|---|
| `kana_symbol_test.dart` | `KanaSymbol` model, romanisation matching, dataset completeness |
| `quiz_view_model_test.dart` | Quiz queue, scoring, progress, restart logic |
| `theme_test.dart` | `ThemeController` defaults, mode switching, About dialog |
| `widget_test.dart` | End-to-end selection → quiz → results flow; ResultsScreen filtering; compact AppBar responsiveness |

---

## 📁 Project Structure

```
japanese-testing/
├── .github/
│   └── workflows/
│       └── ci.yml                  # GitHub Actions CI/CD (test → build → deploy)
│
├── .vscode/
│   ├── launch.json                 # VS Code debug profiles (Windows, Web, Tests)
│   ├── tasks.json                  # Build & test tasks
│   ├── settings.json               # Auto-format, organise imports
│   └── extensions.json             # Recommended extensions
│
├── assets/
│   └── icon/
│       └── app_icon.png            # Source icon used for launcher icons
│
├── lib/
│   ├── main.dart                   # App entry point; KanaQuizApp root widget; ThemeScope
│   │
│   ├── data/
│   │   ├── kana_dataset.dart       # All 142 kana symbols (Hiragana + Katakana)
│   │   └── kana_repository.dart    # Helpers to query symbols by script / group
│   │
│   ├── domain/
│   │   └── models/
│   │       └── kana_symbol.dart    # KanaSymbol model; KanaScript & KanaGroup enums; matches()
│   │
│   └── ui/
│       ├── core/
│       │   ├── app_theme.dart      # Material 3 Light & Dark themes (#7D5BA6 seed)
│       │   └── theme_controller.dart  # ChangeNotifier wrapping ThemeMode preference
│       │
│       └── features/
│           └── quiz/
│               ├── view_models/
│               │   ├── selection_view_model.dart  # Selected symbols, row toggles, script switch
│               │   └── quiz_view_model.dart        # Shuffle queue, answer evaluation, scoring
│               │
│               └── views/
│                   ├── selection_screen.dart       # Kana grid selection UI
│                   ├── quiz_screen.dart            # Flashcard quiz UI
│                   └── results_screen.dart         # Score summary & per-symbol breakdown
│
├── test/                           # Unit & widget tests (see Testing section)
│
├── web/
│   ├── index.html                  # Web entry point (title, meta, manifest link)
│   └── manifest.json               # PWA manifest (name, colours, icons)
│
├── windows/
│   └── runner/
│       └── main.cpp                # Windows runner; sets window title & initial size
│
├── pubspec.yaml                    # Flutter project manifest & dependencies
└── README.md                       # You are here
```

---

## 🗺️ Extending the App

### Adding More Kana / Characters

1. Open [`lib/data/kana_dataset.dart`](lib/data/kana_dataset.dart).
2. Add new `KanaSymbol` entries to the appropriate `const List<KanaSymbol>` (hiragana or katakana).
3. If the symbol has common alternative romanisations, add them to the `alternatives` list on `KanaSymbol`.
4. Add a new [`KanaGroup`](lib/domain/models/kana_symbol.dart) enum value if needed.

### Adding a New Script (e.g. Kanji)

1. Add a value to the `KanaScript` enum in [`kana_symbol.dart`](lib/domain/models/kana_symbol.dart).
2. Create a new dataset list in `kana_dataset.dart`.
3. Update `KanaRepository.allGroups()` in [`kana_repository.dart`](lib/data/kana_repository.dart) to include the new script.
4. Update the script segmented button in [`selection_screen.dart`](lib/ui/features/quiz/views/selection_screen.dart) to show the new option.

### Changing the Theme

Edit [`lib/ui/core/app_theme.dart`](lib/ui/core/app_theme.dart). Both `lightTheme` and `darkTheme` are generated from `ColorScheme.fromSeed` — change the `seedColor` to restyle the entire app.

### Adding a New Screen

1. Create a new `StatefulWidget` in `lib/ui/features/<feature>/views/`.
2. Create a matching `ChangeNotifier` ViewModel in `lib/ui/features/<feature>/view_models/`.
3. Navigate to it via `Navigator.of(context).push(MaterialPageRoute(...))` from wherever appropriate.
4. Add a corresponding test in `test/`.

---

## ⚙️ CI / CD

The GitHub Actions workflow in [`.github/workflows/ci.yml`](.github/workflows/ci.yml) runs on every push and pull request to `main`:

```
push / PR to main
│
├── test          (ubuntu-latest)   → flutter analyze + flutter test
│
├── build-windows (windows-latest)  → flutter build windows --release
│                                     uploads kana-quiz-master-windows.zip as artifact
│
└── build-web     (ubuntu-latest)   → flutter build web --release
                                      └── deploy-pages              → GitHub Pages
```

### Setting Up GitHub Pages

1. Go to your repository → **Settings → Pages**.
2. Under **Source**, choose **GitHub Actions**.
3. Push to `main` — the workflow will build and deploy automatically.
4. Your app will be live at `https://<username>.github.io/<repository>/`.

### Downloading the Windows Build

After a successful CI run, go to **Actions → CI / CD → (run) → Artifacts** and download `kana-quiz-master-windows.zip`. Extract and run `kana_quiz.exe`.

---

## 🔑 Key Dependencies

| Package | Purpose |
|---|---|
| `flutter` SDK | UI framework |
| `cupertino_icons` | iOS-style icon set |
| `flutter_launcher_icons` _(dev)_ | Generates platform launcher icons from a single source PNG |
| `flutter_lints` _(dev)_ | Recommended Dart/Flutter lint rules |

---

## 📄 Credits & Attribution

<a href="https://www.flaticon.com/free-icons/flashcard" title="flashcard icons">Flashcard icons created by Flat Icons - Flaticon</a>

---

## ⚖️ Licence

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for full details.

In short: free to use, modify, and distribute for any purpose, with attribution.
