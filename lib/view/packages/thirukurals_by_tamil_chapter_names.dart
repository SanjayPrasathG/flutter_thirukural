import 'package:flutter/material.dart';
import 'package:flutter_thirukural/view/widgets/thirukural_wrapper.dart';
import '../screens/thirukural_by_tamil_chapter_names_screen.dart';

/// A widget that displays Thirukurals grouped by Tamil chapter names.
///
/// Thirukural contains 133 chapters (Adhikarams), each with 10 Kurals.
/// This widget displays all chapter names in Tamil and allows users to
/// browse Kurals within each chapter.
///
/// Example Tamil chapter names:
/// - கடவுள் வாழ்த்து (The Praise of God)
/// - வான்சிறப்பு (The Excellence of Rain)
/// - நீத்தார் பெருமை (The Greatness of Ascetics)
///
/// This widget is fully self-contained and handles all necessary setup internally.
/// You don't need to wrap your app with any special widgets to use this.
///
/// ## Example usage:
///
/// ```dart
/// import 'package:flutter_thirukural/flutter_thirukural.dart';
///
/// // Display Tamil chapter browser
/// ThirukuralByTamilChapterNames()
///
/// // Use in navigation
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (context) => ThirukuralByTamilChapterNames()),
/// );
/// ```
///
/// ## Features:
/// - Browse all 133 chapters by Tamil name
/// - View all 10 Kurals within a selected chapter
/// - Expandable cards for detailed Kural information
/// - Pull-to-refresh functionality
/// - Responsive design for all screen sizes
/// - Clear filter to return to chapter selection
class ThirukuralByTamilChapterNames extends StatelessWidget {
  /// Creates a widget to browse Thirukurals by Tamil chapter names.
  const ThirukuralByTamilChapterNames({super.key});

  @override
  Widget build(BuildContext context) {
    return ThirukuralPackageWrapper(
      child: ThirukuralByTamilChapterName(),
    );
  }
}
