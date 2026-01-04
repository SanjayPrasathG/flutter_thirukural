/// Represents a single Thirukural (couplet) with all its metadata.
///
/// A Kural contains the original Tamil text, explanations in both
/// Tamil and English, and information about which section (Paal)
/// and chapter (Adhikaram) it belongs to.
///
/// Example:
/// ```dart
/// final kural = Kural(
///   kuralNumber: 1,
///   kural: 'அகர முதல எழுத்தெல்லாம் ஆதி பகவன் முதற்றே உலகு',
///   tamilSectionName: 'அறத்துப்பால்',
///   englishSectionName: 'Virtue',
///   tamilChapterName: 'கடவுள் வாழ்த்து',
///   englishChapterName: 'The Praise of God',
///   tamilExplanation: 'அகர எழுத்து...',
///   englishExplanation: 'As the letter A is the first...',
/// );
/// ```
class Kural {
  /// The unique number of this Kural (1-1330).
  final int? kuralNumber;

  /// The original Tamil text of the Kural couplet.
  final String? kural;

  /// The Tamil name of the section (Paal) this Kural belongs to.
  ///
  /// There are three sections:
  /// - அறத்துப்பால் (Virtue)
  /// - பொருட்பால் (Wealth)
  /// - காமத்துப்பால் (Love)
  final String? tamilSectionName;

  /// The English name of the section (Paal) this Kural belongs to.
  final String? englishSectionName;

  /// The Tamil name of the chapter (Adhikaram) this Kural belongs to.
  ///
  /// There are 133 chapters, each containing 10 Kurals.
  final String? tamilChapterName;

  /// The English name of the chapter (Adhikaram) this Kural belongs to.
  final String? englishChapterName;

  /// The explanation of this Kural in Tamil.
  final String? tamilExplanation;

  /// The explanation of this Kural in English.
  final String? englishExplanation;

  /// Creates a new [Kural] instance.
  Kural({
    this.kuralNumber,
    this.kural,
    this.tamilSectionName,
    this.englishSectionName,
    this.tamilChapterName,
    this.englishChapterName,
    this.tamilExplanation,
    this.englishExplanation,
  });

  /// Creates a [Kural] from a JSON map.
  ///
  /// Used for deserializing API responses.
  factory Kural.fromJson(Map<String, dynamic> json) {
    return Kural(
      kuralNumber: json['kuralNumber'] as int?,
      kural: json['kural'] as String?,
      tamilSectionName: json['tamilSectionName'] as String?,
      englishSectionName: json['englishSectionName'] as String?,
      tamilChapterName: json['tamilChapterName'] as String?,
      englishChapterName: json['englishChapterName'] as String?,
      tamilExplanation: json['tamilExplanation'] as String?,
      englishExplanation: json['englishExplanation'] as String?,
    );
  }

  /// Converts this [Kural] to a JSON map.
  ///
  /// Useful for caching or sending data.
  Map<String, dynamic> toJson() {
    return {
      'kuralNumber': kuralNumber,
      'kural': kural,
      'tamilSectionName': tamilSectionName,
      'englishSectionName': englishSectionName,
      'tamilChapterName': tamilChapterName,
      'englishChapterName': englishChapterName,
      'tamilExplanation': tamilExplanation,
      'englishExplanation': englishExplanation,
    };
  }

  @override
  String toString() {
    return 'Kural(number: $kuralNumber, chapter: $englishChapterName)';
  }
}
