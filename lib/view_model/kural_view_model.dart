import 'package:flutter_thirukural/helpers/common_helpers.dart';
import 'package:flutter_thirukural/model/api_response_model.dart';
import 'package:flutter_thirukural/services/api_services/api_services.dart';
import 'package:flutter_thirukural/services/api_services/url_services.dart';
import 'package:flutter_thirukural/states/kural_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/kural_model.dart';

final kuralViewModelProvider = StateNotifierProvider<KuralViewModel, KuralState>((ref)=> KuralViewModel(KuralState()));

class KuralViewModel extends StateNotifier<KuralState>{
  KuralViewModel(super.state);

  Kural? kuralOfDay;
  String? errorMessageForKuralOfDay = '';
  bool isKuralOfDayLoaded = false;

  List<Kural> kuralsInRangeList = [];
  String errorMessageForAllKuralsInRange = '';
  bool isAllKuralsInRangeLoaded = false;

  List<Kural> allKuralsList = [];
  String errorMessageForAllKurals = '';
  bool isAllKuralsLoaded = false;

  Kural? kuralByNumber;
  String? errorMessageForKuralByNum = '';
  bool isKuralByNumLoaded = false;

  List<String> tamilChapterNamesList = [];
  bool isAllTamilChaptersLoaded = false;
  String tamilChapterNamesErrorMessage = '';

  List<String> englishChapterNamesList = [];
  bool isAllEnglishChaptersLoaded = false;
  String englishChapterNamesErrorMessage = '';

  List<Kural> tamilChapterNameKuralsList = [];
  bool isAllTamilChaptersKuralsLoaded = false;
  String tamilChapterNameKuralsErrorMessage = '';

  List<Kural> englishChapterNameKuralsList = [];
  bool isAllEnglishChaptersKuralsLoaded = false;
  String englishChapterNameKuralsErrorMessage = '';

  List<Kural> tamilSectionNameKuralsList = [];
  bool isAllTamilSectionKuralsLoaded = false;
  String tamilSectionNameKuralsErrorMessage = '';

  List<Kural> englishSectionNameKuralsList = [];
  bool isAllEnglishSectionKuralsLoaded = false;
  String englishSectionNameKuralsErrorMessage = '';

  List<String> tamilSectionNamesList = ['அறத்துப்பால்', 'பொருட்பால்', 'காமத்துப்பால்'];
  List<String> englishSectionNamesList = ['Arathupaal', 'Porutpaal', 'Kaamathupaal'];


  Future getKuralOfTheDay({required String? date}) async{

    isKuralOfDayLoaded = false;
    kuralOfDay = null;
    errorMessageForKuralOfDay = '';

    String validDateMessage = isDateValid(date: date);
    logger.i(validDateMessage);
    if(validDateMessage.isEmpty) {
      try {
        ApiResponse response = await ApiServices.get(
            requestHeaders: {},
            requestParams: {
              'date': date
            },
            endpoint: UrlServices.GET_KURAL_OF_THE_DAY
        );

        logger.w(response.toJson());

        if (response.status != null && response.status!) {
          Map<String, dynamic> responseJson = response.response;
          if(responseJson.isNotEmpty) {
            kuralOfDay = Kural.fromJson(response.response);
            isKuralOfDayLoaded = true;
          } else{
            errorMessageForKuralOfDay = response.message ?? 'No response from server.';
          }
        } else {
          errorMessageForKuralOfDay = response.message ??
              'Server error, failed to load kural of the day';
        }
      } catch (e, stackTrace) {
        logger.e('Error while fetching kural of the day: $e, $stackTrace');
      }
    }else{
      errorMessageForKuralOfDay = validDateMessage;
    }

    logger.e('Error message while fetching kural of the day: $date');
    logger.e(errorMessageForKuralOfDay);

    state = state.kuralOfDayCopyWith(
        kuralOfTheDay: kuralOfDay,
        errorMessageForKuralOfDay: errorMessageForKuralOfDay,
        isKuralOfDayLoaded: isKuralOfDayLoaded
    );
  }

  Future getKuralByKuralNumber({required int? kuralNumber}) async{
    kuralByNumber = null;
    errorMessageForKuralByNum = '';
    isKuralByNumLoaded = false;

    if(kuralNumber != null && kuralNumber != 0) {
      try {
        ApiResponse response = await ApiServices.get(
            requestHeaders: {},
            requestParams: {
              'kuralNumber': kuralNumber
            },
            endpoint: UrlServices.GET_KURAL_BY_NUMBER
        );

        logger.w(response.toJson());

        if (response.status != null && response.status!) {
          Map<String, dynamic> responseJson = response.response;
          if(responseJson.isNotEmpty) {
            kuralByNumber = Kural.fromJson(response.response);
          } else{
            errorMessageForKuralByNum = response.message ?? 'No response from server.';
          }
        } else {
          errorMessageForKuralByNum = response.message ??
              'Server error, failed to load kural by number';
        }
      } catch (e, stackTrace) {
        logger.e('Error while fetching kural by number: $e, $stackTrace');
      }
    }else{
      errorMessageForKuralByNum = 'Invalid kural number.';
    }

    logger.e('Error message while fetching kural by number: $errorMessageForKuralByNum');
    logger.e(errorMessageForKuralByNum);

    state = state.kuralByNumCopyWith(
        kuralByNum: kuralByNumber,
        errorMessageForKuralByNum: errorMessageForKuralByNum,
        isKuralByNumLoaded: isKuralByNumLoaded
    );
  }

  Future getAllKurals() async{
    isAllKuralsLoaded = false;
    allKuralsList.clear();
    errorMessageForAllKurals = '';

    try {
      ApiResponse response = await ApiServices.get(
          requestHeaders: {},
          requestParams: {},
          endpoint: UrlServices.GET_ALL_THIRUKURALS
      );

      logger.w(response.toJson());

      if (response.status != null && response.status!) {
        List<dynamic> responseList = response.response ?? [];
        if(responseList.isNotEmpty) {
          for(var json in responseList){
            allKuralsList.add(Kural.fromJson(json));
            isAllKuralsLoaded = true;
          }
        } else{
          errorMessageForAllKurals = response.message ?? 'No response from server.';
        }
      } else {
        errorMessageForAllKurals = response.message ??
            'Server error, failed to load kurals, please try again later';
      }
    } catch (e, stackTrace) {
      logger.e('Error while fetching all kurals: $e, $stackTrace');
      errorMessageForAllKurals = 'Error while fetching all kurals: $e';
    }

    state = state.allKuralsCopyWith(
        isAllKuralsLoaded: isAllKuralsLoaded,
        allKuralsList: allKuralsList,
        errorMessageForAllKurals: errorMessageForAllKurals
    );
  }

  Future getAllKuralsInRange({required int from, required int to}) async{
      isAllKuralsInRangeLoaded = false;
      kuralsInRangeList.clear();
      errorMessageForAllKuralsInRange = '';

      try {
        ApiResponse response = await ApiServices.get(
            requestHeaders: {},
            requestParams: {
              'from': from,
              'to': to
            },
            endpoint: UrlServices.GET_ALL_THIRUKURALS_WITH_RANGE
        );

        logger.w(response.toJson());

        if (response.status != null && response.status!) {
          List<dynamic> responseList = response.response ?? [];
          if(responseList.isNotEmpty) {
            for(var json in responseList){
              kuralsInRangeList.add(Kural.fromJson(json));
              isAllKuralsInRangeLoaded = true;
            }
          } else{
            errorMessageForAllKuralsInRange = response.message ?? 'No response from server.';
          }
        } else {
          errorMessageForAllKuralsInRange = response.message ??
              'Server error, failed to load kurals, please try again later';
        }
      } catch (e, stackTrace) {
        logger.e('Error while fetching all kurals: $e, $stackTrace');
        errorMessageForAllKuralsInRange = 'Error while fetching all kurals: $e';
      }

    state = state.allKuralsInRangeCopyWith(
      isAllKuralsInRangeLoaded: isAllKuralsInRangeLoaded,
      kuralsInRangeList: kuralsInRangeList,
      errorMessageForAllKuralsInRange: errorMessageForAllKuralsInRange
    );
  }

  Future getTamilChapterNames() async{
    isAllTamilChaptersLoaded = false;
    tamilChapterNamesList.clear();
    tamilChapterNamesErrorMessage = '';

    try {
      ApiResponse response = await ApiServices.get(
          requestHeaders: {},
          requestParams: {},
          endpoint: UrlServices.GET_ALL_TAMIL_CHAPTERS_NAMES
      );

      logger.w(response.toJson());

      if (response.status != null && response.status!) {
        List<dynamic> responseList = response.response ?? [];
        if(responseList.isNotEmpty) {
          for(var tamilChapterName in responseList){
            tamilChapterNamesList.add(tamilChapterName);
            isAllTamilChaptersLoaded = true;
          }
        } else{
          tamilChapterNamesErrorMessage = response.message ?? 'No response from server.';
        }
      } else {
        tamilChapterNamesErrorMessage = response.message ??
            'Server error, failed to load tamil chapter names, please try again later.';
      }
    } catch (e, stackTrace) {
      logger.e('Error while fetching all kurals: $e, $stackTrace');
      tamilChapterNamesErrorMessage = 'Error while fetching all tamil chapter names: $e';
    }

    state = state.copyWithTamilChapterNames(
        isAllTamilChaptersLoaded: isAllTamilChaptersLoaded,
        tamilChapterNamesList: tamilChapterNamesList,
        tamilChapterNamesErrorMessage: tamilChapterNamesErrorMessage
    );
  }

  Future getEnglishChapterNames() async {
    isAllEnglishChaptersLoaded = false;
    englishChapterNamesList.clear();
    englishChapterNamesErrorMessage = '';

    try {
      ApiResponse response = await ApiServices.get(
        requestHeaders: {},
        requestParams: {},
        endpoint: UrlServices.GET_ALL_ENGLISH_CHAPTERS_NAMES,
      );

      logger.w(response.toJson());

      if (response.status != null && response.status!) {
        List<dynamic> responseList = response.response ?? [];
        if (responseList.isNotEmpty) {
          for (var englishChapterName in responseList) {
            englishChapterNamesList.add(englishChapterName);
            isAllEnglishChaptersLoaded = true;
          }
        } else {
          englishChapterNamesErrorMessage = response.message ?? 'No response from server.';
        }
      } else {
        englishChapterNamesErrorMessage =
            response.message ?? 'Server error, failed to load english chapter names, please try again later.';
      }
    } catch (e, stackTrace) {
      logger.e('Error while fetching english chapter names: $e, $stackTrace');
      englishChapterNamesErrorMessage = 'Error while fetching english chapter names: $e';
    }

    state = state.copyWithEnglishChapterNames(
      englishChapterNamesList: englishChapterNamesList,
      isAllEnglishChaptersLoaded: isAllEnglishChaptersLoaded,
      englishChapterNamesErrorMessage: englishChapterNamesErrorMessage,
    );
  }

  Future getKuralsByTamilChapterNames({required String chapterName}) async {
    isAllTamilChaptersKuralsLoaded = false;
    tamilChapterNameKuralsList.clear();
    tamilChapterNameKuralsErrorMessage = '';

    try {
      ApiResponse response = await ApiServices.get(
        requestHeaders: {},
        requestParams: {'tamilChapterName': chapterName},
        endpoint: UrlServices.GET_ALL_KURALS_BY_TAMIL_CHAPTER_NAMES,
      );

      logger.w(response.toJson());

      if (response.status != null && response.status!) {
        List<dynamic> responseList = response.response ?? [];
        tamilChapterNameKuralsList = responseList.map((e) => Kural.fromJson(e)).toList();
        isAllTamilChaptersKuralsLoaded = true;
      } else {
        tamilChapterNameKuralsErrorMessage =
            response.message ?? 'Server error, failed to load tamil chapter kurals.';
      }
    } catch (e, stackTrace) {
      logger.e('Error while fetching tamil chapter kurals: $e, $stackTrace');
      tamilChapterNameKuralsErrorMessage = 'Error while fetching tamil chapter kurals: $e';
    }


    state = state.copyWithTamilChapterNameKurals(
      tamilChapterNameKuralsList: tamilChapterNameKuralsList,
      isAllTamilChaptersKuralsLoaded: isAllTamilChaptersKuralsLoaded,
      tamilChapterNameKuralsErrorMessage: tamilChapterNameKuralsErrorMessage,
    );
  }

  Future getKuralsByEnglishChapterNames({required String chapterName}) async {
    isAllEnglishChaptersKuralsLoaded = false;
    englishChapterNameKuralsList.clear();
    englishChapterNameKuralsErrorMessage = '';

    try {
      ApiResponse response = await ApiServices.get(
        requestHeaders: {},
        requestParams: {'englishChapterName': chapterName},
        endpoint: UrlServices.GET_ALL_KURALS_BY_ENGLISH_CHAPTER_NAMES,
      );

      logger.w(response.toJson());

      if (response.status != null && response.status!) {
        List<dynamic> responseList = response.response ?? [];
        englishChapterNameKuralsList = responseList.map((e) => Kural.fromJson(e)).toList();
        isAllEnglishChaptersKuralsLoaded = true;
      } else {
        englishChapterNameKuralsErrorMessage =
            response.message ?? 'Server error, failed to load kurals.';
      }
    } catch (e, stackTrace) {
      logger.e('Error while fetching english chapter kurals: $e, $stackTrace');
      englishChapterNameKuralsErrorMessage = 'Error while fetching kurals: $e';
    }

    state = state.copyWithEnglishChapterNameKurals(
      englishChapterNameKuralsList: englishChapterNameKuralsList,
      isAllEnglishChaptersKuralsLoaded: isAllEnglishChaptersKuralsLoaded,
      englishChapterNameKuralsErrorMessage: englishChapterNameKuralsErrorMessage,
    );
  }

  Future getKuralsByTamilSectionNames({required String sectionName}) async {
    isAllTamilSectionKuralsLoaded = false;
    tamilSectionNameKuralsList.clear();
    tamilSectionNameKuralsErrorMessage = '';

    try {
      ApiResponse response = await ApiServices.get(
        requestHeaders: {},
        requestParams: {'tamilSectionName': sectionName},
        endpoint: UrlServices.GET_ALL_KURALS_BY_TAMIL_SECTION_NAMES,
      );

      logger.w(response.toJson());

      if (response.status != null && response.status!) {
        List<dynamic> responseList = response.response ?? [];
        tamilSectionNameKuralsList = responseList.map((e) => Kural.fromJson(e)).toList();
        isAllTamilSectionKuralsLoaded = true;
      } else {
        tamilSectionNameKuralsErrorMessage =
            response.message ?? 'Server error, failed to load kurals.';
      }
    } catch (e, stackTrace) {
      logger.e('Error while fetching tamil section kurals: $e, $stackTrace');
      tamilSectionNameKuralsErrorMessage = 'Error while fetching kurals: $e';
    }

    state = state.copyWithTamilSectionKurals(
      tamilSectionNameKuralsList: tamilSectionNameKuralsList,
      isAllTamilSectionKuralsLoaded: isAllTamilSectionKuralsLoaded,
      tamilSectionNameKuralsErrorMessage: tamilSectionNameKuralsErrorMessage,
    );
  }

  Future getKuralsByEnglishSectionNames({required String sectionName}) async {
    isAllEnglishSectionKuralsLoaded = false;
    englishSectionNameKuralsList.clear();
    englishSectionNameKuralsErrorMessage = '';

    try {
      ApiResponse response = await ApiServices.get(
        requestHeaders: {},
        requestParams: {'englishSectionName': sectionName},
        endpoint: UrlServices.GET_ALL_KURALS_BY_ENGLISH_SECTION_NAMES,
      );

      logger.w(response.toJson());

      if (response.status != null && response.status!) {
        List<dynamic> responseList = response.response ?? [];
        englishSectionNameKuralsList = responseList.map((e) => Kural.fromJson(e)).toList();
        isAllEnglishSectionKuralsLoaded = true;
      } else {
        englishSectionNameKuralsErrorMessage =
            response.message ?? 'Server error, failed to load kurals.';
      }
    } catch (e, stackTrace) {
      logger.e('Error while fetching english section kurals: $e, $stackTrace');
      englishSectionNameKuralsErrorMessage = 'Error while fetching kurals: $e';
    }

    state = state.copyWithEnglishSectionKurals(
      englishSectionNameKuralsList: englishSectionNameKuralsList,
      isAllEnglishSectionKuralsLoaded: isAllEnglishSectionKuralsLoaded,
      englishSectionNameKuralsErrorMessage: englishSectionNameKuralsErrorMessage,
    );
  }

}