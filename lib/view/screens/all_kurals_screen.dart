import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_thirukural/helpers/common_helpers.dart';
import 'package:flutter_thirukural/view/widgets/common_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../model/kural_model.dart';
import '../../view_model/kural_view_model.dart';
import '../widgets/common_colors.dart';
import '../widgets/custom_app_bar.dart';

class AllKuralsScreen extends HookConsumerWidget {
  const AllKuralsScreen({super.key});

  static const int itemsPerPage = 10;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kuralViewModel = ref.read(kuralViewModelProvider.notifier);
    final kuralState = ref.watch(kuralViewModelProvider);

    var height = useState(getDeviceHeight(context));
    var width = useState(getDeviceWidth(context));

    var isPageLoaded = useState(false);
    var currentPage = useState(1);
    var expandedIndex = useState<int>(-1);

    Future onPageLoad() async {
      isPageLoaded.value = false;
      logger.w('page loading');
      await kuralViewModel.getAllKurals();
      logger.w('page loaded');
      isPageLoaded.value = true;
    }

    useEffect(() {
      Future.microtask(() {
        onPageLoad();
      });
      return null;
    }, const []);

    // Calculate pagination
    final allKurals = kuralState.allKuralsList ?? [];
    final totalItems = allKurals.length;
    final totalPages = (totalItems / itemsPerPage).ceil();

    // Get current page items
    final startIndex = (currentPage.value - 1) * itemsPerPage;
    final endIndex = (startIndex + itemsPerPage).clamp(0, totalItems);
    final currentPageKurals =
        totalItems > 0 ? allKurals.sublist(startIndex, endIndex) : <Kural>[];

    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return isPageLoaded.value
        ? RefreshIndicator(
            onRefresh: () async {
              currentPage.value = 1;
              expandedIndex.value = -1;
              await onPageLoad();
            },
            color: CommonColors.white,
            backgroundColor: CommonColors.primary,
            child: Scaffold(
              appBar: CustomHomeAppBar(
                title: 'All Thirukurals',
                titleColor: CommonColors.white,
                showLeading: true,
              ),
              backgroundColor: const Color(0xFFF8F9FA),
              body: Center(
                child: SizedBox(
                  height: height.value,
                  width: ResponsiveValue<double>(
                    context,
                    defaultValue: width.value * 0.6,
                    conditionalValues: [
                      const Condition.smallerThan(
                          name: TABLET, value: double.infinity),
                    ],
                  ).value,
                  child: Column(
                    children: [
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
                        child: (kuralState.errorMessageForAllKurals == null ||
                                    kuralState
                                        .errorMessageForAllKurals!.isEmpty) &&
                                currentPageKurals.isNotEmpty
                            ? ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                itemCount: currentPageKurals.length,
                                itemBuilder: (context, index) {
                                  final kural = currentPageKurals[index];
                                  final globalIndex = startIndex + index;
                                  return showKuralWithShowMore(
                                    kural: kural,
                                    imgHeight: height.value * 0.15,
                                    imgWidth: width.value * 0.5,
                                    index: globalIndex,
                                    isMobile: isMobile,
                                    isExpanded:
                                        expandedIndex.value == globalIndex,
                                    onToggle: () {
                                      if (expandedIndex.value == globalIndex) {
                                        expandedIndex.value = -1;
                                      } else {
                                        expandedIndex.value = globalIndex;
                                      }
                                    },
                                  );
                                },
                              )
                            : showErrorWidget(
                                errorMessage: kuralState
                                        .errorMessageForAllKurals ??
                                    'Something went wrong while fetching all kurals.',
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
                  ),
                ),
              ),
            ),
          )
        : showLoader();
  }
}
