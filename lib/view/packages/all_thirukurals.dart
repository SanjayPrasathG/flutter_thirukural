import 'package:flutter/material.dart';
import 'package:flutter_thirukural/view/screens/all_kurals_screen.dart';
import 'package:flutter_thirukural/view/widgets/thirukural_wrapper.dart';

/// A widget that displays the complete list of all Thirukurals.
///
/// This widget shows all 1330 Thirukurals in a scrollable list with lazy loader.
/// Each Kural can be expanded to show more details including Tamil and English
/// explanations, section names, and chapter names.
///
/// This widget is fully self-contained and handles all necessary setup internally.
/// You don't need to wrap your app with any special widgets to use this.
///
/// ## Example usage:
///
/// ```dart
/// import 'package:flutter_thirukural/flutter_thirukural.dart';
///
/// // Use directly in your widget tree
/// Scaffold(
///   body: AllThirukurals(),
/// )
///
/// // Or navigate to it
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (context) => AllThirukurals()),
/// );
/// ```
///
/// ## Features:
/// - Displays all 1330 Thirukurals
/// - Expandable cards to show detailed information
/// - Pull-to-refresh functionality
/// - Responsive design for mobile, tablet, and desktop
/// - Shows Tamil and English explanations
/// - Displays section and chapter information
class AllThirukurals extends StatelessWidget {
  /// Creates a widget that displays all Thirukurals.
  const AllThirukurals({super.key});

  @override
  Widget build(BuildContext context) {
    return ThirukuralPackageWrapper(
      child: AllKuralsScreen(),
    );
  }
}
