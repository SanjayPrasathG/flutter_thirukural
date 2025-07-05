import 'package:flutter/material.dart';
import '../screens/section_names_screen.dart';

/// A widget that displays Thirukurals grouped by section names.
///
/// This widget serves as a wrapper around the [SectionNamesScreen].
/// Use this widget to allow users to browse Thirukurals by selecting
/// different section categories and fetch kurals based on the
/// selected sections.
///
/// Example usage:
/// ```dart
/// ThirukuralBySectionNames()
/// ```
class ThirukuralBySectionNames extends StatelessWidget {
  /// Creates a widget that displays Thirukurals categorized by section names.
  const ThirukuralBySectionNames({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionNamesScreen();
  }
}
