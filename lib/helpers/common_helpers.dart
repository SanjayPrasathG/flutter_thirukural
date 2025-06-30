import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:intl/intl.dart';

getDeviceHeight(dynamic context){
  return ResponsiveBreakpoints.of(context).screenHeight;
}

getDeviceWidth(dynamic context){
  return ResponsiveBreakpoints.of(context).screenWidth;
}

getDeviceInfo(dynamic context){
  return ResponsiveBreakpoints.of(context).breakpoint.name ?? '';
}

Widget space(){
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