import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_thirukural/view/widgets/common_colors.dart';
import 'package:flutter_thirukural/view/widgets/common_widgets.dart';
import 'package:flutter_thirukural/view/widgets/custom_app_bar.dart';
import 'package:flutter_thirukural/view_model/kural_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../helpers/common_helpers.dart';

class GetThirukuralOfDayScreen extends HookConsumerWidget {
  final String? date;

  const GetThirukuralOfDayScreen({super.key, required this.date});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kuralViewModel = ref.read(kuralViewModelProvider.notifier);
    final kuralState = ref.watch(kuralViewModelProvider);

    var height = getDeviceHeight(context);
    var width = getDeviceWidth(context);
    var isPageLoaded = useState(false);

    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    Future onPageLoad() async {
      isPageLoaded.value = false;
      logger.w('page loading');
      await kuralViewModel.getKuralOfTheDay(date: date);
      logger.w('page loaded');
      isPageLoaded.value = true;
    }

    useEffect(() {
      Future.microtask(() {
        onPageLoad();
      });
      return null;
    }, []);

    // Build the kural content widget
    Widget buildKuralContent() {
      // Check if loaded successfully
      final isLoaded = kuralState.isKuralOfDayLoaded == true;
      final hasKural = kuralState.kuralOfTheDay != null;
      final errorMsg = kuralState.errorMessageForKuralOfDay ?? '';

      if (isLoaded && hasKural && errorMsg.isEmpty) {
        return showKural(
          kural: kuralState.kuralOfTheDay!,
          imgHeight: height * 0.18,
          imgWidth: width * 0.45,
          isMobile: isMobile,
        );
      } else {
        return showErrorWidget(
          errorMessage: errorMsg.isNotEmpty
              ? errorMsg
              : 'Failed to load kural of the day. Please try again.',
        );
      }
    }

    return isPageLoaded.value
        ? RefreshIndicator(
            onRefresh: onPageLoad,
            color: CommonColors.white,
            backgroundColor: CommonColors.primary,
            child: Scaffold(
              appBar: CustomHomeAppBar(
                title: 'Kural of the Day',
                titleColor: CommonColors.white,
                showLeading: true,
              ),
              backgroundColor: const Color(0xFFF8F9FA),
              body: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 12.0),
                  height: height,
                  width: ResponsiveValue<double>(
                    context,
                    defaultValue: width * 0.7,
                    conditionalValues: [
                      const Condition.smallerThan(
                          name: TABLET, value: double.infinity),
                    ],
                  ).value,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      // Date Badge
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                CommonColors.primary,
                                CommonColors.secondaryColor,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: CommonColors.primary.withValues(alpha: 0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                                size: 18,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                date ?? 'Today',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: primaryFontFamily,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Kural Card
                      buildKuralContent(),
                    ],
                  ),
                ),
              ),
            ),
          )
        : showLoader();
  }
}
