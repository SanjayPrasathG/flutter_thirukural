import 'package:flutter/material.dart';
import 'package:flutter_thirukural/helpers/common_helpers.dart';
import 'package:flutter_thirukural/view/screens/all_kurals_in_range_screen.dart';
import 'package:flutter_thirukural/view/widgets/common_widgets.dart';

/// A widget that displays a list of Thirukurals within a specified range.
///
/// This widget takes a [from] and [to] value (both inclusive) representing the
/// range of Kural numbers to display. If the range is valid, it shows
/// [AllKuralsScreenInRange]. If the range is invalid, it displays an error message.
///
/// Example usage:
/// ```dart
/// ThirukuralsInRange(from: 10, to: 20)
/// ```
///
/// [from] and [to] must be valid Thirukural numbers,
/// and [from] must be less than or equal to [to].
class ThirukuralsInRange extends StatelessWidget {
  /// The starting Kural number of the range.
  final int? from;

  /// The ending Kural number of the range.
  final int? to;

  /// Creates a widget to display Thirukurals from [from] to [to].
  const ThirukuralsInRange({
    super.key,
    required this.from,
    required this.to,
  });

  @override
  Widget build(BuildContext context) {
    String validKuralMessage = isValidKuralNumberRange(from: from, to: to);
    return validKuralMessage.isEmpty
        ? AllKuralsScreenInRange(from: from, to: to)
        : Center(child: showErrorWidget(errorMessage: validKuralMessage));
  }
}
