import 'package:flutter/material.dart';
import 'package:flutter_thirukural/helpers/common_helpers.dart';
import 'package:flutter_thirukural/view/screens/get_kural_by_number.dart';
import 'package:flutter_thirukural/view/widgets/common_widgets.dart';
import 'package:flutter_thirukural/view/widgets/thirukural_wrapper.dart';

/// A widget to display a specific Thirukural by its number.
///
/// This widget validates the provided [kuralNumber] and displays the
/// corresponding Kural with all its details including Tamil and English
/// explanations, section and chapter information.
///
/// This widget is fully self-contained and handles all necessary setup internally.
/// You don't need to wrap your app with any special widgets to use this.
///
/// ## Example usage:
///
/// ```dart
/// import 'package:flutter_thirukural/flutter_thirukural.dart';
///
/// // Display a specific Kural
/// ThirukuralByNumber(kuralNumber: 1)
///
/// // Use in navigation
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => ThirukuralByNumber(kuralNumber: 153),
///   ),
/// );
///
/// // Display a random Kural
/// import 'dart:math';
/// ThirukuralByNumber(kuralNumber: Random().nextInt(1330) + 1)
/// ```
///
/// ## Parameters:
/// - [kuralNumber]: Required. Must be between 1 and 1330 (inclusive)
///
/// ## Features:
/// - Displays complete Kural information
/// - Shows Tamil and English explanations
/// - Shows section and chapter names
/// - Pull-to-refresh functionality
/// - Responsive design for all screen sizes
/// - Beautiful card-based UI with Thiruvalluvar image
///
/// ## Error Handling:
/// - If kuralNumber is null, 0, or > 1330, an error message is displayed
/// - If the API fails, an appropriate error message is shown
class ThirukuralByNumber extends StatelessWidget {
  /// The number of the Thirukural to display.
  ///
  /// Must be between 1 and 1330 (inclusive).
  final int? kuralNumber;

  /// Creates a widget to display a Thirukural for the given [kuralNumber].
  ///
  /// [kuralNumber] must be provided and should be in the valid range (1-1330).
  const ThirukuralByNumber({super.key, required this.kuralNumber});

  @override
  Widget build(BuildContext context) {
    String validKuralMessage = isValidKuralNumber(kuralNumber: kuralNumber);
    return ThirukuralPackageWrapper(
      child: validKuralMessage.isEmpty
          ? GetKuralByNumber(kuralNumber: kuralNumber)
          : Scaffold(
              body: Center(
                  child: showErrorWidget(errorMessage: validKuralMessage)),
            ),
    );
  }
}
