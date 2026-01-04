import 'package:flutter/material.dart';
import 'package:flutter_thirukural/helpers/common_helpers.dart';
import 'package:flutter_thirukural/view/widgets/common_widgets.dart';
import 'package:flutter_thirukural/view/widgets/thirukural_wrapper.dart';

import '../screens/get_kural_of_day_screen.dart';

/// A widget that displays the Thirukural for a specific day.
///
/// This widget takes a [date] in the format `dd-MM-yyyy` and displays
/// the corresponding Kural of the Day. Each date maps to a unique Kural,
/// making it perfect for daily wisdom features in your app.
///
/// This widget is fully self-contained and handles all necessary setup internally.
/// You don't need to wrap your app with any special widgets to use this.
///
/// ## Example usage:
///
/// ```dart
/// import 'package:flutter_thirukural/flutter_thirukural.dart';
/// import 'package:intl/intl.dart';
///
/// // Get today's Kural
/// ThirukuralOfTheDay(
///   date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
/// )
///
/// // Get Kural for a specific date
/// ThirukuralOfTheDay(date: '04-01-2026')
/// ```
///
/// ## Parameters:
/// - [date]: Required. The date in `dd-MM-yyyy` format (e.g., '04-01-2026')
///
/// ## Features:
/// - Displays the Kural of the Day with full details
/// - Shows Tamil and English explanations
/// - Shows section and chapter information
/// - Pull-to-refresh functionality
/// - Responsive design for all screen sizes
/// - Beautiful card-based UI with Thiruvalluvar image
///
/// ## Error Handling:
/// - If the date format is invalid, an error message is displayed
/// - If the API fails, an appropriate error message is shown
class ThirukuralOfTheDay extends StatelessWidget {
  /// The date for which to fetch the Thirukural, in `dd-MM-yyyy` format.
  ///
  /// Example: '04-01-2026', '25-12-2025'
  final String? date;

  /// Creates a widget to display the Thirukural for the given [date].
  ///
  /// [date] must be provided in `dd-MM-yyyy` format.
  const ThirukuralOfTheDay({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    String validDateMsg = isDateValid(date: date);
    return ThirukuralPackageWrapper(
      child: validDateMsg.isEmpty
          ? GetThirukuralOfDayScreen(date: date)
          : Scaffold(
              body: Center(child: showErrorWidget(errorMessage: validDateMsg)),
            ),
    );
  }
}
