import 'package:flutter/material.dart';
import '../screens/thirukural_by_english_chapter_names_screen.dart';

/// A widget that displays Thirukurals grouped by their English chapter names.
///
/// This widget is a wrapper around [ThirukuralByEnglishChapterName] screen.
/// Use this widget to allow users to browse Thirukurals by selecting English chapter titles.
///
/// Example usage:
/// ```dart
/// ThirukuralByEnglishChapterNames()
/// ```
class ThirukuralByEnglishChapterNames extends StatelessWidget {
  /// Creates a widget that displays Thirukurals categorized by English chapters.
  const ThirukuralByEnglishChapterNames({super.key});

  @override
  Widget build(BuildContext context) {
    return ThirukuralByEnglishChapterName();
  }
}
