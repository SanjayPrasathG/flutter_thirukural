import 'package:flutter/material.dart';
import 'package:flutter_thirukural/helpers/common_helpers.dart';
import 'package:flutter_thirukural/view/widgets/common_widgets.dart';

import '../screens/get_kural_of_day_screen.dart';

/// A widget that displays the Thirukural for a specific day.
///
/// This widget takes an optional [date] in the format `dd-MM-yyyy`.
/// - If the [date] is valid, it shows the [GetThirukuralOfDayScreen] for that date.
/// - If the [date] is invalid, it displays an error message.
///
/// Example usage:
/// ```dart
/// ThirukuralOfTheDay(date: '22-06-2025')
/// ```
///
/// If you want to display the Kural of the current day,
/// pass the current date string or handle that logic before calling this widget.
class ThirukuralOfTheDay extends StatelessWidget {
  /// The date for which to fetch the Thirukural, in `dd-MM-yyyy` format.
  final String? date;

  /// Creates a widget to display the Thirukural for the given [date].
  const ThirukuralOfTheDay({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    String validDateMsg = isDateValid(date: date);
    return validDateMsg.isEmpty
        ? GetThirukuralOfDayScreen(date: date)
        : Center(child: showErrorWidget(errorMessage: validDateMsg));
  }
}
