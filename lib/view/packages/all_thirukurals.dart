import 'package:flutter/material.dart';
import 'package:flutter_thirukural/view/screens/all_kurals_screen.dart';

/// A widget that displays the complete list of all Thirukurals.
///
/// This widget shows the [AllKuralsScreen], which presents
/// all 1330 Thirukurals in a scrollable list with lazy loader.
///
/// Example usage:
/// ```dart
/// AllThirukurals()
/// ```
class AllThirukurals extends StatelessWidget {
  /// Creates a widget that displays all Thirukurals.
  const AllThirukurals({super.key});

  @override
  Widget build(BuildContext context) {
    return AllKuralsScreen();
  }
}
