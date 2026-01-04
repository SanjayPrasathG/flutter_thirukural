import 'package:flutter/material.dart';
import 'package:flutter_thirukural/helpers/common_helpers.dart';
import 'package:flutter_thirukural/view/screens/all_kurals_in_range_screen.dart';
import 'package:flutter_thirukural/view/widgets/common_widgets.dart';
import 'package:flutter_thirukural/view/widgets/thirukural_wrapper.dart';

/// A widget that displays a list of Thirukurals within a specified range.
///
/// This widget takes a [from] and [to] value (both inclusive) representing
/// the range of Kural numbers to display. It shows all Kurals in that range
/// in a scrollable list with expandable cards.
///
/// This widget is fully self-contained and handles all necessary setup internally.
/// You don't need to wrap your app with any special widgets to use this.
///
/// ## Example usage:
///
/// ```dart
/// import 'package:flutter_thirukural/flutter_thirukural.dart';
///
/// // Display Kurals 1 to 10
/// ThirukuralsInRange(from: 1, to: 10)
///
/// // Display a chapter's Kurals (each chapter has 10 Kurals)
/// ThirukuralsInRange(from: 11, to: 20)  // Chapter 2
///
/// // Use in navigation
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => ThirukuralsInRange(from: 100, to: 150),
///   ),
/// );
/// ```
///
/// ## Parameters:
/// - [from]: Required. Starting Kural number (1-1329)
/// - [to]: Required. Ending Kural number (2-1330, must be > from)
///
/// ## Features:
/// - Displays all Kurals in the specified range
/// - Expandable cards to show detailed information
/// - Pull-to-refresh functionality
/// - Responsive design for all screen sizes
/// - Shows Tamil and English explanations
/// - Displays section and chapter information
///
/// ## Error Handling:
/// - If from or to is null, an error message is displayed
/// - If from >= to, an error message is displayed
/// - If values are out of range (1-1330), an error message is displayed
/// - If the API fails, an appropriate error message is shown
class ThirukuralsInRange extends StatelessWidget {
  /// The starting Kural number of the range.
  ///
  /// Must be between 1 and 1329 (inclusive).
  final int? from;

  /// The ending Kural number of the range.
  ///
  /// Must be between 2 and 1330 (inclusive) and greater than [from].
  final int? to;

  /// Creates a widget to display Thirukurals from [from] to [to].
  ///
  /// Both [from] and [to] must be provided and should be in valid ranges.
  const ThirukuralsInRange({
    super.key,
    required this.from,
    required this.to,
  });

  @override
  Widget build(BuildContext context) {
    String validKuralMessage = isValidKuralNumberRange(from: from, to: to);
    return ThirukuralPackageWrapper(
      child: validKuralMessage.isEmpty
          ? AllKuralsScreenInRange(from: from, to: to)
          : Scaffold(
              body: Center(
                  child: showErrorWidget(errorMessage: validKuralMessage)),
            ),
    );
  }
}
