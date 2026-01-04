import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:intl/intl.dart';

getDeviceHeight(dynamic context) {
  return ResponsiveBreakpoints.of(context).screenHeight;
}

getDeviceWidth(dynamic context) {
  return ResponsiveBreakpoints.of(context).screenWidth;
}

getDeviceInfo(dynamic context) {
  return ResponsiveBreakpoints.of(context).breakpoint.name ?? '';
}

Widget space() {
  return SizedBox(height: 10.0);
}

List<int> validStatusCodes = [200, 201, 202];

Logger logger = Logger();

//date helpers
String isDateValid({required String? date}) {
  if (date == null || date.trim().isEmpty) {
    return 'Date should not be blank to get Kural of the Day.';
  }

  try {
    final inputFormat = DateFormat('dd-MM-yyyy');
    inputFormat.parseStrict(date.trim());
    return ''; // Valid
  } catch (_) {
    return 'Invalid date. Please provide the date in DD-MM-YYYY format.';
  }
}

String isValidKuralNumber({required int? kuralNumber}) {
  if (kuralNumber == null) {
    return 'Kural number should not be null.';
  }
  if (kuralNumber == 0 || kuralNumber > 1331) {
    return 'Kural number should be between 1 - 1330.';
  }
  return '';
}

String isValidKuralNumberRange({required int? from, required int? to}) {
  if (from == null) {
    return 'Kural from number should not be null.';
  }
  if (to == null) {
    return 'Kural to number should not be null.';
  }
  if (from == to) {
    return 'From and To range should not be same.';
  }
  if (from == 0 || from < 0 || from > 1329) {
    return 'Kural from number should be between 1 - 1329.';
  }
  if (to == 0 || to < 0 || to > 1330) {
    return 'Kural to number should be between 1 - 1330.';
  }
  return '';
}
