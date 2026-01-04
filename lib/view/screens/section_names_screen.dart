import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_thirukural/model/kural_model.dart';
import 'package:flutter_thirukural/view/widgets/custom_loader_button.dart';
import 'package:flutter_thirukural/view_model/kural_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../helpers/common_helpers.dart';
import '../widgets/common_colors.dart';
import '../widgets/common_widgets.dart';
import '../widgets/custom_app_bar.dart';

class SectionNamesScreen extends HookConsumerWidget {
  const SectionNamesScreen({super.key});

  static const int itemsPerPage = 10;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kuralState = ref.watch(kuralViewModelProvider);
    final kuralViewModel = ref.watch(kuralViewModelProvider.notifier);

    var isPageLoaded = useState(false);
    var height = getDeviceHeight(context);
    var width = getDeviceWidth(context);

    var selectedTamilSectionName = useState('');
    var selectedEnglishSectionName = useState('');
    var doShowSectionNamesOnly = useState(true);
    var expandedIndex = useState<int>(-1);
    var currentPage = useState(1);

    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    Future onPageLoaded() async {
      isPageLoaded.value = false;
      selectedTamilSectionName.value = '';
      selectedEnglishSectionName.value = '';
      doShowSectionNamesOnly.value = true;
      expandedIndex.value = -1;
      currentPage.value = 1;
      isPageLoaded.value = true;
    }

    useEffect(() {
      onPageLoaded();
      return null;
    }, []);

    Widget buildSectionCard({
      required String sectionName,
      required int index,
      required bool isTamil,
      required Color accentColor,
    }) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.white,
              accentColor.withValues(alpha: 0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: accentColor.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: accentColor.withValues(alpha: 0.2),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () async {
              doShowSectionNamesOnly.value = false;
              currentPage.value = 1;
              expandedIndex.value = -1;
              if (isTamil) {
                selectedEnglishSectionName.value = '';
                selectedTamilSectionName.value = sectionName;
                isPageLoaded.value = false;
                await kuralViewModel.getKuralsByTamilSectionNames(
                    sectionName: sectionName);
              } else {
                selectedTamilSectionName.value = '';
                selectedEnglishSectionName.value = sectionName;
                isPageLoaded.value = false;
                await kuralViewModel.getKuralsByEnglishSectionNames(
                    sectionName: sectionName);
              }
              isPageLoaded.value = true;
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          accentColor,
                          accentColor.withValues(alpha: 0.7)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sectionName,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily:
                                isTamil ? tamilFontFamily : primaryFontFamily,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isTamil ? 'Tamil Section' : 'English Section',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                            fontFamily: primaryFontFamily,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: accentColor,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget showSectionNames() {
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tamil Sections Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF667eea).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.translate,
                      color: Color(0xFF667eea),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'தமிழ் பிரிவுகள்',
                    style: TextStyle(
                      color: const Color(0xFF667eea),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: tamilFontFamily,
                    ),
                  ),
                ],
              ),
            ),
            ...kuralViewModel.tamilSectionNamesList.asMap().entries.map(
                  (entry) => buildSectionCard(
                    sectionName: entry.value,
                    index: entry.key,
                    isTamil: true,
                    accentColor: const Color(0xFF667eea),
                  ),
                ),
            const SizedBox(height: 24),
            // English Sections Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF11998e).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.language,
                      color: Color(0xFF11998e),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'English Sections',
                    style: TextStyle(
                      color: const Color(0xFF11998e),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: primaryFontFamily,
                    ),
                  ),
                ],
              ),
            ),
            ...kuralViewModel.englishSectionNamesList.asMap().entries.map(
                  (entry) => buildSectionCard(
                    sectionName: entry.value,
                    index: entry.key,
                    isTamil: false,
                    accentColor: const Color(0xFF11998e),
                  ),
                ),
            const SizedBox(height: 20),
          ],
        ),
      );
    }

    Widget showKuralsInSelectedSection() {
      String errorMessage = '';
      List<Kural> kuralsList = [];
      bool isLoaded = false;
      String sectionName = '';

      if (selectedTamilSectionName.value.isNotEmpty) {
        isLoaded = kuralState.isAllTamilSectionKuralsLoaded ?? false;
        kuralsList = kuralState.tamilSectionNameKuralsList ?? [];
        errorMessage = kuralState.tamilSectionNameKuralsErrorMessage ??
            'Error while loading kurals.';
        sectionName = selectedTamilSectionName.value;
      } else if (selectedEnglishSectionName.value.isNotEmpty) {
        isLoaded = kuralState.isAllEnglishSectionKuralsLoaded ?? false;
        kuralsList = kuralState.englishSectionNameKuralsList ?? [];
        errorMessage = kuralState.englishSectionNameKuralsErrorMessage ??
            'Error while loading kurals.';
        sectionName = selectedEnglishSectionName.value;
      }

      // Pagination
      final totalItems = kuralsList.length;
      final totalPages = (totalItems / itemsPerPage).ceil();
      final startIndex = (currentPage.value - 1) * itemsPerPage;
      final endIndex = (startIndex + itemsPerPage).clamp(0, totalItems);
      final currentPageKurals =
          totalItems > 0 ? kuralsList.sublist(startIndex, endIndex) : <Kural>[];

      if (isLoaded && kuralsList.isNotEmpty && errorMessage.isEmpty) {
        return Column(
          children: [
            // Section Header with Back Button
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    CommonColors.primary.withValues(alpha: 0.1),
                    CommonColors.secondaryColor.withValues(alpha: 0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: CommonColors.primary.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Section',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                            fontFamily: primaryFontFamily,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          sectionName,
                          style: TextStyle(
                            color: CommonColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily:
                                selectedTamilSectionName.value.isNotEmpty
                                    ? tamilFontFamily
                                    : primaryFontFamily,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomLoaderButton(
                    title: 'Back',
                    buttonTextSize: 14.0,
                    buttonTextColor: Colors.white,
                    buttonColor: CommonColors.primary,
                    isIconButton: false,
                    onTap: () async {
                      await onPageLoaded();
                    },
                    loaderColor: Colors.white,
                    width: 80,
                    height: 40,
                  ),
                ],
              ),
            ),
            // Page Info
            if (totalItems > 0)
              buildPageInfo(
                currentPage: currentPage.value,
                totalPages: totalPages,
                totalItems: totalItems,
                itemsPerPage: itemsPerPage,
              ),
            // Kural List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: currentPageKurals.length,
                itemBuilder: (context, index) {
                  final kural = currentPageKurals[index];
                  final globalIndex = startIndex + index;
                  return showKuralWithShowMore(
                    kural: kural,
                    imgHeight: height * 0.15,
                    imgWidth: width * 0.35,
                    index: globalIndex,
                    isMobile: isMobile,
                    isExpanded: expandedIndex.value == globalIndex,
                    onToggle: () {
                      if (expandedIndex.value == globalIndex) {
                        expandedIndex.value = -1;
                      } else {
                        expandedIndex.value = globalIndex;
                      }
                    },
                  );
                },
              ),
            ),
            // Pagination Controls
            if (totalPages > 1)
              buildPaginationControls(
                currentPage: currentPage.value,
                totalPages: totalPages,
                onPageChanged: (page) {
                  currentPage.value = page;
                  expandedIndex.value = -1;
                },
                isMobile: isMobile,
              ),
            const SizedBox(height: 8),
          ],
        );
      } else {
        return showErrorWidget(errorMessage: errorMessage);
      }
    }

    return isPageLoaded.value
        ? Scaffold(
            appBar: CustomHomeAppBar(
              title: 'Thirukural Sections',
              titleColor: CommonColors.white,
              showLeading: true,
            ),
            backgroundColor: const Color(0xFFF8F9FA),
            body: Center(
              child: SizedBox(
                height: height,
                width: ResponsiveValue<double>(
                  context,
                  defaultValue: width * 0.6,
                  conditionalValues: [
                    const Condition.smallerThan(
                        name: TABLET, value: double.infinity),
                  ],
                ).value,
                child: doShowSectionNamesOnly.value
                    ? showSectionNames()
                    : showKuralsInSelectedSection(),
              ),
            ),
          )
        : showLoader();
  }
}
