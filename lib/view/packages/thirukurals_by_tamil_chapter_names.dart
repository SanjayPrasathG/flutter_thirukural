import 'package:flutter/material.dart';
import '../screens/thirukural_by_tamil_chapter_names_screen.dart';

/// A widget that displays Thirukurals grouped by their Tamil chapter names.
///
/// This widget is a wrapper around [ThirukuralByTamilChapterName] screen.
/// Use this widget to allow users to browse Thirukurals by selecting Tamil chapter titles.
///
/// Example usage:
/// ```dart
/// ThirukuralByTamilChapterNames()
/// ```
class ThirukuralByTamilChapterNames extends StatelessWidget {
  /// Creates a widget that displays Thirukurals categorized by Tamil chapters.
  const ThirukuralByTamilChapterNames({super.key});

  @override
  Widget build(BuildContext context) {
    return ThirukuralByTamilChapterName();
  }
}
