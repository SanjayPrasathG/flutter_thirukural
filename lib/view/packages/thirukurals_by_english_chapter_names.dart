import 'package:flutter/material.dart';
import 'package:flutter_thirukural/view/widgets/thirukural_wrapper.dart';
import '../screens/thirukural_by_english_chapter_names_screen.dart';

/// A widget that displays Thirukurals grouped by English chapter names.
///
/// Thirukural contains 133 chapters (Adhikarams), each with 10 Kurals.
/// This widget displays all chapter names in English and allows users to
/// browse Kurals within each chapter.
///
/// Example English chapter names:
/// - The Praise of God
/// - The Excellence of Rain
/// - The Greatness of Ascetics
/// - Assertion of the Strength of Virtue
///
/// This widget is fully self-contained and handles all necessary setup internally.
/// You don't need to wrap your app with any special widgets to use this.
///
/// ## Example usage:
///
/// ```dart
/// import 'package:flutter_thirukural/flutter_thirukural.dart';
///
/// // Display English chapter browser
/// ThirukuralByEnglishChapterNames()
///
/// // Use in navigation
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (context) => ThirukuralByEnglishChapterNames()),
/// );
/// ```
///
/// ## Features:
/// - Browse all 133 chapters by English name
/// - View all 10 Kurals within a selected chapter
/// - Expandable cards for detailed Kural information
/// - Pull-to-refresh functionality
/// - Responsive design for all screen sizes
/// - Clear filter to return to chapter selection
class ThirukuralByEnglishChapterNames extends StatelessWidget {
  /// Creates a widget to browse Thirukurals by English chapter names.
  const ThirukuralByEnglishChapterNames({super.key});

  @override
  Widget build(BuildContext context) {
    return ThirukuralPackageWrapper(
      child: ThirukuralByEnglishChapterName(),
    );
  }
}
