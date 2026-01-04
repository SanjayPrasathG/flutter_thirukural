import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../helpers/common_helpers.dart';
import '../../view_model/kural_view_model.dart';
import '../widgets/common_colors.dart';
import '../widgets/common_widgets.dart';
import '../widgets/custom_app_bar.dart';

class GetKuralByNumber extends HookConsumerWidget {
  final int? kuralNumber;

  const GetKuralByNumber({super.key, required this.kuralNumber});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kuralViewModel = ref.read(kuralViewModelProvider.notifier);
    final kuralState = ref.watch(kuralViewModelProvider);

    var height = useState(getDeviceHeight(context));
    var width = useState(getDeviceWidth(context));
    var isPageLoaded = useState(false);

    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    Future onPageLoad() async {
      isPageLoaded.value = false;
      logger.w('page loading');
      await kuralViewModel.getKuralByKuralNumber(kuralNumber: kuralNumber);
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
      final isLoaded = kuralState.isKuralByNumLoaded == true;
      final hasKural = kuralState.kuralByNumber != null;
      final errorMsg = kuralState.errorMessageForKuralByNum ?? '';

      if (isLoaded && hasKural && errorMsg.isEmpty) {
        return showKural(
          kural: kuralState.kuralByNumber!,
          imgHeight: height.value * 0.2,
          imgWidth: width.value * 0.5,
          isMobile: isMobile,
        );
      } else {
        return showErrorWidget(
          errorMessage: errorMsg.isNotEmpty
              ? errorMsg
              : 'Failed to load kural. Please try again.',
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
                title: 'Kural #$kuralNumber',
                titleColor: CommonColors.white,
                showLeading: true,
              ),
              backgroundColor: const Color(0xFFF8F9FA),
              body: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 12.0),
                  height: height.value,
                  width: ResponsiveValue<double>(
                    context,
                    defaultValue: width.value * 0.7,
                    conditionalValues: [
                      const Condition.smallerThan(
                          name: TABLET, value: double.infinity),
                    ],
                  ).value,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      // Kural Number Badge
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
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
                                Icons.numbers,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Kural Number: $kuralNumber',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
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
