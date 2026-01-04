/// Flutter Thirukural - A comprehensive package for integrating Thirukural
/// into your Flutter applications.
///
/// Thirukural is a classic Tamil sangam literature consisting of 1330 kurals
/// (couplets) divided into 133 chapters, authored by the great Tamil poet
/// Thiruvalluvar. This package provides beautiful, ready-to-use widgets
/// to display Kurals in various ways.
///
/// ## Getting Started
///
/// Simply import the package and use any of the provided widgets:
///
/// ```dart
/// import 'package:flutter_thirukural/flutter_thirukural.dart';
/// ```
///
/// All widgets are self-contained and can be used directly without any
/// additional setup or configuration.
///
/// ## Available Widgets
///
/// - [ThirukuralOfTheDay] - Display the Kural of the Day for any date
/// - [ThirukuralByNumber] - Display a specific Kural by its number (1-1330)
/// - [AllThirukurals] - Browse all 1330 Kurals
/// - [ThirukuralsInRange] - Display Kurals within a number range
/// - [ThirukuralBySectionNames] - Browse by section (Paal)
/// - [ThirukuralByTamilChapterNames] - Browse by Tamil chapter names
/// - [ThirukuralByEnglishChapterNames] - Browse by English chapter names
library;

// Widget exports
export 'view/packages/all_thirukurals.dart';
export 'view/packages/thirukural_by_number.dart';
export 'view/packages/thirukural_of_the_day.dart';
export 'view/packages/thirukurals_in_range.dart';
export 'view/packages/thirukurals_by_section_names.dart';
export 'view/packages/thirukurals_by_tamil_chapter_names.dart';
export 'view/packages/thirukurals_by_english_chapter_names.dart';

// Route exports for web navigation
export 'routes/thirukural_routes.dart';

// Model exports
export 'model/kural_model.dart';
