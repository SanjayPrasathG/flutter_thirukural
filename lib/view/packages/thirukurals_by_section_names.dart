import 'package:flutter/material.dart';
import 'package:flutter_thirukural/view/widgets/thirukural_wrapper.dart';
import '../screens/section_names_screen.dart';

/// A widget that displays Thirukurals grouped by section names.
///
/// Thirukural is divided into three main sections (Paals):
/// - **அறத்துப்பால் (Arathupaal)** - The Book of Virtue (Kurals 1-380)
/// - **பொருட்பால் (Porutpaal)** - The Book of Wealth (Kurals 381-1080)
/// - **காமத்துப்பால் (Kaamathupaal)** - The Book of Love (Kurals 1081-1330)
///
/// This widget displays both Tamil and English section names, and allows
/// users to browse all Kurals within each section.
///
/// This widget is fully self-contained and handles all necessary setup internally.
/// You don't need to wrap your app with any special widgets to use this.
///
/// ## Example usage:
///
/// ```dart
/// import 'package:flutter_thirukural/flutter_thirukural.dart';
///
/// // Display section browser
/// ThirukuralBySectionNames()
///
/// // Use in navigation
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (context) => ThirukuralBySectionNames()),
/// );
/// ```
///
/// ## Features:
/// - Browse all 3 sections in Tamil and English
/// - View all Kurals within a selected section
/// - Expandable cards for detailed Kural information
/// - Pull-to-refresh functionality
/// - Responsive design for all screen sizes
/// - Clear filter to return to section selection
class ThirukuralBySectionNames extends StatelessWidget {
  /// Creates a widget that displays Thirukurals categorized by section names.
  const ThirukuralBySectionNames({super.key});

  @override
  Widget build(BuildContext context) {
    return ThirukuralPackageWrapper(
      child: SectionNamesScreen(),
    );
  }
}
