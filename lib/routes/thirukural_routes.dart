/// Route constants for web navigation in the Thirukural package.
///
/// These routes can be used when integrating the package with web applications
/// to provide proper URL-based navigation.
class ThirukuralRoutes {
  /// Route for all kurals listing screen.
  static const String allKurals = '/thirukural/all';

  /// Route for kural of the day screen.
  /// Expects `date` query parameter in format dd-MM-yyyy.
  static const String kuralOfTheDay = '/thirukural/kural-of-the-day';

  /// Route for kural by number screen.
  /// Expects `number` query parameter (1-1330).
  static const String kuralByNumber = '/thirukural/kural';

  /// Route for kurals in range screen.
  /// Expects `from` and `to` query parameters.
  static const String kuralsInRange = '/thirukural/range';

  /// Route for section names screen.
  static const String sectionNames = '/thirukural/sections';

  /// Route for Tamil chapter names screen.
  static const String tamilChapters = '/thirukural/tamil-chapters';

  /// Route for English chapter names screen.
  static const String englishChapters = '/thirukural/english-chapters';
}
