import 'package:flutter/material.dart';
import 'package:flutter_thirukural/view/screens/kural_home_screen.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:toastification/toastification.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: ResponsiveBreakpoints(
        breakpoints: [
          Breakpoint(start: 0, end: 550, name: 'MOBILE'),
          Breakpoint(start: 551, end: 950, name: 'TABLET'),
          Breakpoint(start: 951, end: 1450, name: 'DESKTOP'),
          Breakpoint(start: 1451, end: double.infinity, name: 'TV'),
        ],
        child: GetMaterialApp(
          title: 'Flutter Thirukural',
          home: KuralHomeScreen(),
        ),
      ),
    );
  }
}
