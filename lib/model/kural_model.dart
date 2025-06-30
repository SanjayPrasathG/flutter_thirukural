class Kural {
  final int? kuralNumber;
  final String? kural;
  final String? tamilSectionName;
  final String? englishSectionName;
  final String? tamilChapterName;
  final String? englishChapterName;
  final String? tamilExplanation;
  final String? englishExplanation;

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
}
