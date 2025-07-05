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

class AllKuralsScreenInRange extends HookConsumerWidget {
  final int? from;
  final int? to;

  const AllKuralsScreenInRange({super.key, required this.from, required this.to});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kuralViewModel = ref.read(kuralViewModelProvider.notifier);
    final kuralState = ref.watch(kuralViewModelProvider);

    var height = useState(getDeviceHeight(context));
    var width = useState(getDeviceWidth(context));

    var isPageLoaded = useState(false);
    var selectedIndexToShowMore = useState(0);

    Future onPageLoad() async {
      isPageLoaded.value = false;
      logger.w('page loading');
      await kuralViewModel.getAllKuralsInRange(from: from ?? 0, to: to ?? 0);
      logger.w('page loaded');
      isPageLoaded.value = true;
    }

    useEffect(() {
      Future.microtask(() {
        onPageLoad();
      });
      return null;
    }, [kuralState.kuralsInRangeList]);


    Widget showKuralWithShowMore({
      required int index,
      required Kural kural,
      required double imgHeight,
      required double imgWidth,
    }) {
      final fullText = kural.kural ?? '';
      final words = fullText.split(' ');

      final firstLineWords = words.length >= 4
          ? words.sublist(0, 4)
          : words;

      final secondLineWords = words.length > 4
          ? words.sublist(4, words.length > 7 ? 7 : words.length)
          : [];

      final firstLine = firstLineWords.join(' ');
      final secondLine = secondLineWords.join(' ');

      final displayText = [
        firstLine,
        if (secondLine.isNotEmpty) secondLine,
      ].join('\n');

      final isMobile = ResponsiveBreakpoints.of(context).isMobile;

      Widget kuralContent = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 20.0,),
          customText(
            text: displayText,
            textColor: CommonColors.blue,
            fontSize: isMobile ? 13.0 : 15.0,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.start,
            textOverFlow: TextOverflow.clip,
            maxLines: 3,
          ),
          SizedBox(height: 5.0),
          Align(
            alignment: Alignment.bottomRight,
            child: customText(
              text: "- திருவள்ளுவர்",
              textColor: CommonColors.purple,
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.end,
              textOverFlow: TextOverflow.clip,
            ),
          ),
        ],
      );

      Widget imageWidget = ClipOval(
        child: SizedBox(
          width: imgWidth,
          height: imgHeight,
          child: Image.asset(
            'assets/images/thiruvalluvar_img.png',
            fit: BoxFit.cover,
            alignment: Alignment.center,
            filterQuality: FilterQuality.high,
          ),
        ),
      );

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: CommonColors.lightPrimary,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: customText(
                    text: 'Kural Number : ${kural.kuralNumber ?? 'N/A'}',
                    textColor: CommonColors.purple,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.start,
                    textOverFlow: TextOverflow.clip,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                      if (selectedIndexToShowMore.value == index) {
                        selectedIndexToShowMore.value = -1;
                      } else {
                        selectedIndexToShowMore.value = index;
                      }
                    },
                    icon: selectedIndexToShowMore.value == index
                        ? Icon(Icons.keyboard_arrow_down, color: CommonColors.primary)
                        : Icon(Icons.keyboard_arrow_right_rounded, color: CommonColors.black),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            isMobile
                ? Column(
              children: [
                Center(child: imageWidget),
                SizedBox(height: 10.0),
                kuralContent,
              ],
            )
                : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(flex: 1,child: imageWidget),
                SizedBox(width: 10.0),
                Expanded(flex: 4,child: kuralContent),
              ],
            ),
            SizedBox(height: 10.0),
            Visibility(
              visible: selectedIndexToShowMore.value == index,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                    text: 'Tamil Explanation: ',
                    textColor: CommonColors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.start,
                    textOverFlow: TextOverflow.clip,
                  ),
                  SizedBox(height: 5.0),
                  customText(
                    text: kural.tamilExplanation ?? '',
                    textColor: CommonColors.green,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.start,
                    textOverFlow: TextOverflow.clip,
                    maxLines: 5,
                  ),
                  SizedBox(height: 10.0),
                  customText(
                    text: 'English Explanation: ',
                    textColor: CommonColors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.start,
                    textOverFlow: TextOverflow.clip,
                  ),
                  SizedBox(height: 5.0),
                  customText(
                    text: kural.englishExplanation ?? '',
                    textColor: CommonColors.green,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.start,
                    textOverFlow: TextOverflow.clip,
                    maxLines: 5,
                  ),
                  SizedBox(height: 10.0),
                  customText(
                    text: 'Section Name',
                    textColor: CommonColors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.start,
                    textOverFlow: TextOverflow.clip,
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: customText(
                          text: kural.tamilSectionName ?? '',
                          textColor: CommonColors.gold,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.start,
                          textOverFlow: TextOverflow.clip,
                        ),
                      ),
                      Expanded(
                        child: customText(
                          text: kural.englishSectionName ?? '',
                          textColor: CommonColors.gold,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.end,
                          textOverFlow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  customText(
                    text: 'Chapter Name',
                    textColor: CommonColors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.start,
                    textOverFlow: TextOverflow.clip,
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: customText(
                          text: kural.tamilChapterName ?? '',
                          textColor: CommonColors.orange,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.start,
                          textOverFlow: TextOverflow.clip,
                        ),
                      ),
                      Expanded(
                        child: customText(
                          text: kural.englishChapterName ?? '',
                          textColor: CommonColors.orange,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.end,
                          textOverFlow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
          ],
        ),
      );
    }

    return isPageLoaded.value
        ? RefreshIndicator(
            onRefresh: onPageLoad,
            color: CommonColors.white,
            backgroundColor: CommonColors.primary,
            child: Scaffold(
              appBar: CustomHomeAppBar(
                title: 'Thirukurals in Range $from - $to',
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
                    children: [
                      Visibility(
                        visible: (kuralState.errorMessageForAllKuralsInRange == null || kuralState.errorMessageForAllKuralsInRange!.isEmpty)
                            && (kuralState.kuralsInRangeList != null && kuralState.kuralsInRangeList!.isNotEmpty),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: kuralState.kuralsInRangeList?.length,
                            itemBuilder: (context, index){
                              Kural? kural = kuralState.kuralsInRangeList?[index];
                              if(kural != null){
                                return showKuralWithShowMore(
                                    kural: kural,
                                    imgHeight: height.value * 0.15,
                                    imgWidth: width.value * 0.5,
                                  index: index
                                );
                              }
                              return SizedBox();
                            }
                        ),
                      ),
                      Visibility(
                        visible: (kuralState.errorMessageForAllKuralsInRange != null && kuralState.errorMessageForAllKuralsInRange!.isNotEmpty)
                            || kuralState.kuralsInRangeList == null || kuralState.kuralsInRangeList!.isEmpty,
                          child: showErrorWidget(errorMessage: kuralState.errorMessageForAllKuralsInRange ?? 'Some thing went wrong while fetching all kurals.')
                      ),
                      SizedBox(height: 10.0,),
                    ],
                  ),
                ),
              ),
            ),
          )
        : showLoader();
  }
}
