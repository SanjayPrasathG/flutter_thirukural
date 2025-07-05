import '../model/kural_model.dart';

class KuralState{
  Kural? kuralOfTheDay;
  String? errorMessageForKuralOfDay = '';
  bool? isKuralOfDayLoaded;

  List<Kural>? kuralsInRangeList;
  String? errorMessageForAllKuralsInRange = '';
  bool? isAllKuralsInRangeLoaded;

  List<Kural>? allKuralsList = [];
  String? errorMessageForAllKurals = '';
  bool? isAllKuralsLoaded = false;

  Kural? kuralByNumber;
  String? errorMessageForKuralByNum = '';
  bool? isKuralByNumLoaded = false;

  List<String>? tamilChapterNamesList = [];
  bool? isAllTamilChaptersLoaded = false;
  String? tamilChapterNamesErrorMessage = '';

  List<String>? englishChapterNamesList = [];
  bool? isAllEnglishChaptersLoaded = false;
  String? englishChapterNamesErrorMessage = '';

  List<Kural>? tamilChapterNameKuralsList = [];
  bool? isAllTamilChaptersKuralsLoaded = false;
  String? tamilChapterNameKuralsErrorMessage = '';

  List<Kural>? englishChapterNameKuralsList = [];
  bool? isAllEnglishChaptersKuralsLoaded = false;
  String? englishChapterNameKuralsErrorMessage = '';

  List<Kural>? tamilSectionNameKuralsList = [];
  bool? isAllTamilSectionKuralsLoaded = false;
  String? tamilSectionNameKuralsErrorMessage = '';

  List<Kural>? englishSectionNameKuralsList = [];
  bool? isAllEnglishSectionKuralsLoaded = false;
  String? englishSectionNameKuralsErrorMessage = '';

  KuralState();

  KuralState.kuralOfDay({
    required this.kuralOfTheDay,
    required this.errorMessageForKuralOfDay,
    required this.isKuralOfDayLoaded
  });

  KuralState.allKurals({
    required this.allKuralsList,
    required this.isAllKuralsLoaded,
    required this.errorMessageForAllKurals
  });

  KuralState.allKuralsInRange({
    required this.kuralsInRangeList,
    required this.isAllKuralsInRangeLoaded,
    required this.errorMessageForAllKuralsInRange
  });

  KuralState.kuralByNumber({
    required this.kuralByNumber,
    required this.errorMessageForKuralByNum,
    required this.isKuralByNumLoaded
  });

  KuralState.tamilChapterNames({
    required this.tamilChapterNamesList,
    required this.isAllTamilChaptersLoaded,
    required this.tamilChapterNamesErrorMessage,
  });

  KuralState.englishChapterNames({
    required this.englishChapterNamesList,
    required this.isAllEnglishChaptersLoaded,
    required this.englishChapterNamesErrorMessage,
  });

  KuralState.tamilChapterNameKurals({
    required this.tamilChapterNameKuralsList,
    required this.isAllTamilChaptersKuralsLoaded,
    required this.tamilChapterNameKuralsErrorMessage,
  });

  KuralState.englishChapterNameKurals({
    required this.englishChapterNameKuralsList,
    required this.isAllEnglishChaptersKuralsLoaded,
    required this.englishChapterNameKuralsErrorMessage,
  });

  KuralState.tamilSectionKurals({
    required this.tamilSectionNameKuralsList,
    required this.isAllTamilSectionKuralsLoaded,
    required this.tamilSectionNameKuralsErrorMessage,
  });

  KuralState.englishSectionKurals({
    required this.englishSectionNameKuralsList,
    required this.isAllEnglishSectionKuralsLoaded,
    required this.englishSectionNameKuralsErrorMessage,
  });

  KuralState kuralOfDayCopyWith({
    required Kural? kuralOfTheDay,
    required String? errorMessageForKuralOfDay,
    required bool isKuralOfDayLoaded
  }){
   return KuralState.kuralOfDay(
       kuralOfTheDay: kuralOfTheDay ?? this.kuralOfTheDay,
       errorMessageForKuralOfDay: errorMessageForKuralOfDay ?? this.errorMessageForKuralOfDay,
       isKuralOfDayLoaded: isKuralOfDayLoaded
   );
  }

  KuralState allKuralsCopyWith({
    required List<Kural>? allKuralsList,
    required bool? isAllKuralsLoaded,
    required String? errorMessageForAllKurals
  }){
    return KuralState.allKurals(
        allKuralsList: allKuralsList ?? this.allKuralsList,
        isAllKuralsLoaded: isAllKuralsLoaded ?? this.isAllKuralsLoaded,
        errorMessageForAllKurals: errorMessageForAllKurals ?? this.errorMessageForAllKurals
    );
  }

  KuralState allKuralsInRangeCopyWith({
    required List<Kural>? kuralsInRangeList,
    required bool? isAllKuralsInRangeLoaded,
    required String? errorMessageForAllKuralsInRange
  }){
    return KuralState.allKuralsInRange(
        kuralsInRangeList: kuralsInRangeList ?? this.kuralsInRangeList,
        isAllKuralsInRangeLoaded: isAllKuralsInRangeLoaded ?? this.isAllKuralsInRangeLoaded,
        errorMessageForAllKuralsInRange: errorMessageForAllKuralsInRange ?? this.errorMessageForAllKuralsInRange
    );
  }

  KuralState kuralByNumCopyWith({
    required Kural? kuralByNum,
    required String? errorMessageForKuralByNum,
    required bool? isKuralByNumLoaded
  }){
    return KuralState.kuralByNumber(
        kuralByNumber: kuralByNum ?? kuralByNumber,
        errorMessageForKuralByNum: errorMessageForKuralByNum ?? this.errorMessageForKuralByNum,
        isKuralByNumLoaded: isKuralByNumLoaded ?? this.isKuralByNumLoaded
    );
  }

  KuralState copyWithTamilChapterNames({
    required List<String>? tamilChapterNamesList,
    required bool? isAllTamilChaptersLoaded,
    required String? tamilChapterNamesErrorMessage,
  }) {
    return KuralState.tamilChapterNames(
      tamilChapterNamesList: tamilChapterNamesList ?? this.tamilChapterNamesList,
      isAllTamilChaptersLoaded: isAllTamilChaptersLoaded ?? this.isAllTamilChaptersLoaded,
      tamilChapterNamesErrorMessage: tamilChapterNamesErrorMessage ?? this.tamilChapterNamesErrorMessage,
    );
  }

  KuralState copyWithEnglishChapterNames({
    required List<String> englishChapterNamesList,
    required bool isAllEnglishChaptersLoaded,
    required String englishChapterNamesErrorMessage,
  }) {
    return KuralState.englishChapterNames(
      englishChapterNamesList: englishChapterNamesList,
      isAllEnglishChaptersLoaded: isAllEnglishChaptersLoaded,
      englishChapterNamesErrorMessage: englishChapterNamesErrorMessage,
    );
  }

  KuralState copyWithTamilChapterNameKurals({
    required List<Kural> tamilChapterNameKuralsList,
    required bool isAllTamilChaptersKuralsLoaded,
    required String tamilChapterNameKuralsErrorMessage,
  }) {
    return KuralState.tamilChapterNameKurals(
      tamilChapterNameKuralsList: tamilChapterNameKuralsList,
      isAllTamilChaptersKuralsLoaded: isAllTamilChaptersKuralsLoaded,
      tamilChapterNameKuralsErrorMessage: tamilChapterNameKuralsErrorMessage,
    );
  }

  KuralState copyWithEnglishChapterNameKurals({
    required List<Kural> englishChapterNameKuralsList,
    required bool isAllEnglishChaptersKuralsLoaded,
    required String englishChapterNameKuralsErrorMessage,
  }) {
    return KuralState.englishChapterNameKurals(
      englishChapterNameKuralsList: englishChapterNameKuralsList,
      isAllEnglishChaptersKuralsLoaded: isAllEnglishChaptersKuralsLoaded,
      englishChapterNameKuralsErrorMessage: englishChapterNameKuralsErrorMessage,
    );
  }

  KuralState copyWithTamilSectionKurals({
    required List<Kural> tamilSectionNameKuralsList,
    required bool isAllTamilSectionKuralsLoaded,
    required String tamilSectionNameKuralsErrorMessage,
  }) {
    return KuralState.tamilSectionKurals(
      tamilSectionNameKuralsList: tamilSectionNameKuralsList,
      isAllTamilSectionKuralsLoaded: isAllTamilSectionKuralsLoaded,
      tamilSectionNameKuralsErrorMessage: tamilSectionNameKuralsErrorMessage,
    );
  }

  KuralState copyWithEnglishSectionKurals({
    required List<Kural> englishSectionNameKuralsList,
    required bool isAllEnglishSectionKuralsLoaded,
    required String englishSectionNameKuralsErrorMessage,
  }) {
    return KuralState.englishSectionKurals(
      englishSectionNameKuralsList: englishSectionNameKuralsList,
      isAllEnglishSectionKuralsLoaded: isAllEnglishSectionKuralsLoaded,
      englishSectionNameKuralsErrorMessage: englishSectionNameKuralsErrorMessage,
    );
  }
}