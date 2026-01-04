import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// A wrapper widget that provides necessary dependencies for Thirukural widgets.
///
/// This widget ensures that all Thirukural package widgets have access to:
/// - Riverpod's ProviderScope for state management
/// - ResponsiveBreakpoints for responsive design
///
/// All exported widgets use this wrapper internally, so users don't need to
/// configure anything special in their app.
class ThirukuralWrapper extends StatelessWidget {
  final Widget child;

  const ThirukuralWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Check if we're already inside a ProviderScope
    // by trying to use ProviderScope.containerOf
    final existingContainer = ProviderScope.containerOf(context, listen: false);

    Widget wrappedChild = child;

    // Wrap with ResponsiveBreakpoints if not already present
    try {
      ResponsiveBreakpoints.of(context);
      // Already has ResponsiveBreakpoints, just use child directly
    } catch (_) {
      // No ResponsiveBreakpoints found, wrap with one
      wrappedChild = ResponsiveBreakpoints(
        breakpoints: const [
          Breakpoint(start: 0, end: 550, name: 'MOBILE'),
          Breakpoint(start: 551, end: 950, name: 'TABLET'),
          Breakpoint(start: 951, end: 1450, name: 'DESKTOP'),
          Breakpoint(start: 1451, end: double.infinity, name: 'TV'),
        ],
        child: Builder(
          builder: (context) => child,
        ),
      );
    }

    // If no existing container, wrap with ProviderScope
    // ignore: unnecessary_null_comparison
    if (existingContainer == null) {
      return ProviderScope(child: wrappedChild);
    }

    return wrappedChild;
  }
}

/// A simpler wrapper that always provides the necessary context
/// This is used internally by package widgets
class ThirukuralPackageWrapper extends StatelessWidget {
  final Widget child;

  const ThirukuralPackageWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF9C1C1C),
          ),
        ),
        home: ResponsiveBreakpoints(
          breakpoints: const [
            Breakpoint(start: 0, end: 550, name: 'MOBILE'),
            Breakpoint(start: 551, end: 950, name: 'TABLET'),
            Breakpoint(start: 951, end: 1450, name: 'DESKTOP'),
            Breakpoint(start: 1451, end: double.infinity, name: 'TV'),
          ],
          child: child,
        ),
      ),
    );
  }
}
