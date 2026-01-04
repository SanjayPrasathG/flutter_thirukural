import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../helpers/common_helpers.dart';
import '../../view_model/kural_view_model.dart';
import '../widgets/common_colors.dart';
import '../widgets/common_widgets.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_loader_button.dart';

class ThirukuralByEnglishChapterName extends HookConsumerWidget {
  const ThirukuralByEnglishChapterName({super.key});

  static const int itemsPerPage = 10;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kuralState = ref.watch(kuralViewModelProvider);
    final kuralViewModel = ref.read(kuralViewModelProvider.notifier);

    var isPageLoaded = useState(false);
    var height = getDeviceHeight(context);
    var width = getDeviceWidth(context);

    var selectedEnglishChapterName = useState<String?>('');
    var doShowChapterNamesOnly = useState(true);
    var expandedIndex = useState<int>(-1);
    var currentPage = useState(1);

    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    Future onPageLoad() async {
      selectedEnglishChapterName.value = '';
      doShowChapterNamesOnly.value = true;
      expandedIndex.value = -1;
      currentPage.value = 1;

      isPageLoaded.value = false;
      await kuralViewModel.getEnglishChapterNames();
      isPageLoaded.value = true;
    }

    useEffect(() {
      Future.microtask(() => onPageLoad());
      return null;
    }, []);

    Widget buildChapterCard(String chapterName, int index) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () async {
              doShowChapterNamesOnly.value = false;
              selectedEnglishChapterName.value = chapterName;
              currentPage.value = 1;
              expandedIndex.value = -1;
              isPageLoaded.value = false;
              await kuralViewModel.getKuralsByEnglishChapterNames(
                  chapterName: chapterName);
              isPageLoaded.value = true;
            },
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF11998e),
                          const Color(0xFF38ef7d),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      chapterName,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: primaryFontFamily,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF11998e).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF11998e),
                      size: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget showAllChapterNames() {
      if (kuralState.isAllEnglishChaptersLoaded != null &&
          kuralState.isAllEnglishChaptersLoaded! &&
          kuralState.englishChapterNamesErrorMessage != null &&
          kuralState.englishChapterNamesErrorMessage!.isEmpty) {
        final chapters = kuralState.englishChapterNamesList ?? [];

        // Pagination for chapters
        final totalItems = chapters.length;
        final totalPages = (totalItems / 20).ceil(); // 20 chapters per page
        final startIndex = (currentPage.value - 1) * 20;
        final endIndex = (startIndex + 20).clamp(0, totalItems);
        final currentPageChapters = chapters.sublist(startIndex, endIndex);

        return Column(
          children: [
            // Header
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF11998e).withValues(alpha: 0.1),
                    const Color(0xFF38ef7d).withValues(alpha: 0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF11998e).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.auto_stories,
                      color: Color(0xFF11998e),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'English Chapters',
                          style: TextStyle(
                            color: const Color(0xFF11998e),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: primaryFontFamily,
                          ),
                        ),
                        Text(
                          '${chapters.length} Chapters (Adhikarams)',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                            fontFamily: primaryFontFamily,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Page Info
            if (totalPages > 1)
              buildPageInfo(
                currentPage: currentPage.value,
                totalPages: totalPages,
                totalItems: totalItems,
                itemsPerPage: 20,
              ),
            // Chapter List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: currentPageChapters.length,
                itemBuilder: (context, index) {
                  final globalIndex = startIndex + index;
                  return buildChapterCard(
                    currentPageChapters[index],
                    globalIndex,
                  );
                },
              ),
            ),
            // Pagination
            if (totalPages > 1)
              buildPaginationControls(
                currentPage: currentPage.value,
                totalPages: totalPages,
                onPageChanged: (page) {
                  currentPage.value = page;
                },
                isMobile: isMobile,
              ),
            const SizedBox(height: 8),
          ],
        );
      } else {
        return showErrorWidget(
          errorMessage: kuralState.englishChapterNamesErrorMessage ??
              'Error loading chapters',
        );
      }
    }

    Widget showKuralsInSelectedChapter() {
      final kuralsList = kuralState.englishChapterNameKuralsList ?? [];
      final errorMessage =
          kuralState.englishChapterNameKuralsErrorMessage ?? '';

      if (kuralsList.isNotEmpty && errorMessage.isEmpty) {
        // Pagination
        final totalItems = kuralsList.length;
        final totalPages = (totalItems / itemsPerPage).ceil();
        final startIndex = (currentPage.value - 1) * itemsPerPage;
        final endIndex = (startIndex + itemsPerPage).clamp(0, totalItems);
        final currentPageKurals = kuralsList.sublist(startIndex, endIndex);

        return Column(
          children: [
            // Chapter Header
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF11998e).withValues(alpha: 0.1),
                    const Color(0xFF38ef7d).withValues(alpha: 0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF11998e).withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chapter',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                            fontFamily: primaryFontFamily,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          selectedEnglishChapterName.value ?? '',
                          style: TextStyle(
                            color: const Color(0xFF11998e),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: primaryFontFamily,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomLoaderButton(
                    title: 'Back',
                    buttonTextSize: 14.0,
                    buttonTextColor: Colors.white,
                    buttonColor: const Color(0xFF11998e),
                    isIconButton: false,
                    onTap: () async {
                      currentPage.value = 1;
                      await onPageLoad();
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
            // Pagination
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
        return showErrorWidget(
          errorMessage:
              errorMessage.isNotEmpty ? errorMessage : 'Something went wrong.',
        );
      }
    }

    return Scaffold(
      appBar: CustomHomeAppBar(
        title: 'English Chapters',
        titleColor: CommonColors.white,
        showLeading: true,
      ),
      backgroundColor: const Color(0xFFF8F9FA),
      body: isPageLoaded.value
          ? Center(
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
                child: doShowChapterNamesOnly.value
                    ? showAllChapterNames()
                    : showKuralsInSelectedChapter(),
              ),
            )
          : showLoader(),
    );
  }
}
