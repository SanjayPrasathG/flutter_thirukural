import 'package:flutter/material.dart';
import 'package:flutter_thirukural/view/screens/kural_home_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints(
      breakpoints: const [
        Breakpoint(start: 0, end: 550, name: 'MOBILE'),
        Breakpoint(start: 551, end: 950, name: 'TABLET'),
        Breakpoint(start: 951, end: 1450, name: 'DESKTOP'),
        Breakpoint(start: 1451, end: double.infinity, name: 'TV'),
      ],
      child: MaterialApp(
        title: 'Flutter Thirukural',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF9C1C1C),
          ),
        ),
        home: const KuralHomeScreen(),
      ),
    );
  }
}
