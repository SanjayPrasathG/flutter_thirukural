import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../helpers/common_helpers.dart';
import '../../view_model/kural_view_model.dart';
import '../widgets/common_colors.dart';
import '../widgets/common_widgets.dart';
import '../widgets/custom_app_bar.dart';

class GetKuralByNumber extends HookConsumerWidget{
  final int? kuralNumber;

  const GetKuralByNumber({super.key, required this.kuralNumber});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kuralViewModel = ref.read(kuralViewModelProvider.notifier);
    final kuralState = ref.watch(kuralViewModelProvider);

    var height = useState(getDeviceHeight(context));
    var width = useState(getDeviceWidth(context));
    var isPageLoaded = useState(false);

    Future onPageLoad() async{
      isPageLoaded.value = false;
      logger.w('page loading');
      await kuralViewModel.getKuralByKuralNumber(kuralNumber: kuralNumber);
      logger.w('page loaded');
      isPageLoaded.value = true;
    }

    useEffect((){
      Future.microtask(() {
        onPageLoad();
      });
      return null;
    }, []);

    return isPageLoaded.value ? RefreshIndicator(
      onRefresh: onPageLoad,
      color: CommonColors.white,
      backgroundColor: CommonColors.primary,
      child: Scaffold(
        appBar: CustomHomeAppBar(
          title: 'Kural by Number',
          titleColor: CommonColors.white,
          showLeading: true,
        ),
        backgroundColor: CommonColors.white,
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            height: height.value,
            width: ResponsiveValue<double>(
                context,
                defaultValue: width.value * 0.5,
                conditionalValues: [
                  const Condition.smallerThan(name: TABLET, value: double.infinity),
                ]
            ).value,
            child: ListView(
              shrinkWrap: true,
              children: [
                kuralState.errorMessageForKuralByNum != null && kuralState.errorMessageForKuralByNum!.isEmpty ?
                  kuralState.kuralByNumber != null ?
                    showKural(kural: kuralState.kuralByNumber!,
                        imgHeight: height.value * 0.2,
                        imgWidth: width.value * 0.5,
                        isMobile: ResponsiveBreakpoints.of(context).isMobile
                    )
                      :
                    showErrorWidget(errorMessage: kuralState.errorMessageForKuralByNum ?? 'Something went wrong, please try again later')
                  :
                showErrorWidget(errorMessage: kuralState.errorMessageForKuralByNum ?? 'Something went wrong, please try again later')
              ],
            ),
          ),
        ),
      ),
    ) : showLoader();
  }


}