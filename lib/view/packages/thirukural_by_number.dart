import 'package:flutter/material.dart';
import 'package:flutter_thirukural/helpers/common_helpers.dart';
import 'package:flutter_thirukural/view/screens/get_kural_by_number.dart';
import 'package:flutter_thirukural/view/widgets/common_widgets.dart';

/// A widget to display a specific Thirukural by its number.
///
/// This widget validates the provided [kuralNumber] and:
/// - If valid, shows the [GetKuralByNumber] screen displaying that Kural.
/// - If invalid (e.g. out of range), displays an error message.
///
/// Example usage:
/// ```dart
/// ThirukuralByNumber(kuralNumber: 153)
/// ```
///
/// [kuralNumber] must be between 1 and 1330 (inclusive).
class ThirukuralByNumber extends StatelessWidget {
  /// The number of the Thirukural to display.
  final int? kuralNumber;

  /// Creates a widget to display a Thirukural for the given [kuralNumber].
  ///
  /// [kuralNumber] must be provided and should be in the valid range.
  const ThirukuralByNumber({super.key, required this.kuralNumber});

  @override
  Widget build(BuildContext context) {
    String validKuralMessage = isValidKuralNumber(kuralNumber: kuralNumber);
    return validKuralMessage.isEmpty
        ? GetKuralByNumber(kuralNumber: kuralNumber)
        : Center(child: showErrorWidget(errorMessage: validKuralMessage));
  }
}
