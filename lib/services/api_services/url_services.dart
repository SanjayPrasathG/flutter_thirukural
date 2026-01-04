/// URL endpoints for the Thirukural API.
///
/// This class contains all the API endpoint constants used to fetch
/// Thirukural data from the backend server.
class UrlServices {
  /// Base URL for the Thirukural API server.
  static const String baseUrl =
      'https://spring-thirukural.onrender.com/thirukural';

  /// Endpoint to get all Thirukurals.
  static const String getAllThirukurals = 'getAllThirukurals';

  /// Endpoint to get Thirukurals within a specific range.
  static const String getAllThirukuralsWithRange = 'getAllThirukuralsWithRange';

  /// Endpoint to get the Kural of the Day.
  static const String getKuralOfTheDay = 'getKuralOfDay';

  /// Endpoint to get a Thirukural by its number (1-1330).
  static const String getKuralByNumber = 'getThirukuralByKuralNumber';

  /// Endpoint to get all Tamil chapter names.
  static const String getAllTamilChaptersNames = 'getAllTamilChaptersName';

  /// Endpoint to get all English chapter names.
  static const String getAllEnglishChaptersNames = 'getAllEnglishChaptersName';

  /// Endpoint to get Thirukurals by Tamil chapter name.
  static const String getKuralsByTamilChapterName =
      'getThirukuralByTamilChapterName';

  /// Endpoint to get Thirukurals by English chapter name.
  static const String getKuralsByEnglishChapterName =
      'getThirukuralByEnglishChapterName';

  /// Endpoint to get Thirukurals by Tamil section name.
  static const String getKuralsByTamilSectionName =
      'getThirukuralByTamilSectionName';

  /// Endpoint to get Thirukurals by English section name.
  static const String getKuralsByEnglishSectionName =
      'getThirukuralByEnglishSectionName';
}
