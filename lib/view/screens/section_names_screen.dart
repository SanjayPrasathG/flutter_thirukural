import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
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
    var selectedIndexToShowMore = useState(0);

    Future onPageLoaded() async{
      isPageLoaded.value = false;
      selectedTamilSectionName.value = '';
      selectedEnglishSectionName.value = '';
      doShowSectionNamesOnly.value = true;
      selectedIndexToShowMore.value = 0;
      isPageLoaded.value = true;
    }

    useEffect((){
      onPageLoaded();
      return null;
    }, []);

    Widget showTamilSectionNames(){
      return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: kuralViewModel.tamilSectionNamesList.length,
          itemBuilder: (context, index){
            String sectionName = kuralViewModel.tamilSectionNamesList[index];
            return GestureDetector(
              onTap: () async{
                doShowSectionNamesOnly.value = false;
                selectedEnglishSectionName.value = '';
                selectedTamilSectionName.value = sectionName;
                isPageLoaded.value = false;
                await kuralViewModel.getKuralsByTamilSectionNames(sectionName: selectedTamilSectionName.value ?? '');
                isPageLoaded.value = true;
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: CommonColors.lightPrimary
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: customText(
                          text: '${index+1}.$sectionName',
                          textColor: CommonColors.red,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.start,
                          textOverFlow: TextOverflow.clip,
                          maxLines: 5
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: IconButton(
                            onPressed: () async{
                              doShowSectionNamesOnly.value = false;
                              selectedEnglishSectionName.value = '';
                              selectedTamilSectionName.value = sectionName;
                              isPageLoaded.value = false;
                              await kuralViewModel.getKuralsByTamilSectionNames(sectionName: selectedTamilSectionName.value ?? '');
                              isPageLoaded.value = true;
                            },
                            icon: Icon(Icons.arrow_forward_ios_outlined, color: CommonColors.grey, size: 15.0,)
                        )
                    )
                  ],
                ),
              ),
            );
          }
      );
    }

    Widget showEnglishSectionNames() {
      return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: kuralViewModel.englishSectionNamesList.length,
          itemBuilder: (context, index) {
            String sectionName = kuralViewModel.englishSectionNamesList[index];
            return GestureDetector(
              onTap: () async {
                doShowSectionNamesOnly.value = false;
                selectedEnglishSectionName.value = sectionName;
                selectedTamilSectionName.value = '';
                isPageLoaded.value = false;
                await kuralViewModel.getKuralsByEnglishSectionNames(sectionName: selectedEnglishSectionName.value ?? '');
                isPageLoaded.value = true;
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: CommonColors.lightPrimary
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: customText(
                          text: '${index + 1}.$sectionName',
                          textColor: CommonColors.red,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.start,
                          textOverFlow: TextOverflow.clip,
                          maxLines: 5
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: IconButton(
                            onPressed: () async {
                              doShowSectionNamesOnly.value = false;
                              selectedEnglishSectionName.value = sectionName;
                              selectedTamilSectionName.value = '';
                              isPageLoaded.value = false;
                              await kuralViewModel.getKuralsByEnglishSectionNames(sectionName: selectedEnglishSectionName.value ?? '');
                              isPageLoaded.value = true;
                            },
                            icon: Icon(Icons.arrow_forward_ios_outlined,
                              color: CommonColors.grey, size: 15.0,)
                        )
                    )
                  ],
                ),
              ),
            );
          }
      );
    }

    Widget showSectionNames(){
      return ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          customText(
              text: 'Thirukural Tamil Sections',
              textColor: CommonColors.green,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.start,
              textOverFlow: TextOverflow.clip,
              maxLines: 1
          ),
          SizedBox(height: 5.0,),
          showTamilSectionNames(),
          SizedBox(height: 20.0,),
          customText(
              text: 'Thirukural English Sections',
              textColor: CommonColors.green,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.start,
              textOverFlow: TextOverflow.clip,
              maxLines: 1
          ),
          SizedBox(height: 5.0,),
          showEnglishSectionNames(),
          SizedBox(height: 10.0,),
        ],
      );
    }

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

    Widget showKuralsInSelectedSection(){
      String errorMessage = '';
      List<Kural> kuralsList = [];
      bool isLoaded = false;

      if(selectedTamilSectionName.value.isNotEmpty){
        isLoaded = kuralState.isAllTamilSectionKuralsLoaded;
        kuralsList = kuralState.tamilSectionNameKuralsList;
        errorMessage = kuralState.tamilSectionNameKuralsErrorMessage;
      } else if(selectedEnglishSectionName.value.isNotEmpty){
        isLoaded = kuralState.isAllEnglishSectionKuralsLoaded;
        kuralsList = kuralState.englishSectionNameKuralsList;
        errorMessage = kuralState.englishSectionNameKuralsErrorMessage;
      }

      if(isLoaded && kuralsList.isNotEmpty && errorMessage.isEmpty){
        return Column(
          spacing: 10.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: customText(
                      text: 'Kurals in ${selectedTamilSectionName.value.isNotEmpty ? selectedTamilSectionName.value : selectedEnglishSectionName.value}',
                      textColor: CommonColors.gold,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start,
                      textOverFlow: TextOverflow.clip,
                      maxLines: 1
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: CustomLoaderButton(
                      title: 'Clear',
                      buttonTextSize: 15.0,
                      buttonTextColor: CommonColors.primary,
                      buttonColor: CommonColors.lightPrimary,
                      isIconButton: false,
                      onTap: () async{
                        await onPageLoaded();
                      },
                      loaderColor: CommonColors.primary
                  ),
                ),
              ],
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: kuralsList.length,
                itemBuilder: (context, index){
                  Kural kural = kuralsList[index];
                  return showKuralWithShowMore(
                      kural: kural,
                      imgHeight: height * 0.15,
                      imgWidth: width * 0.35,
                      index: index
                  );
                }
            ),
          ],
        );
      }
      else{
        return customText(
            text: errorMessage,
            textColor: CommonColors.red,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.start,
            textOverFlow: TextOverflow.clip,
            maxLines: 5
        );
      }
    }

    return isPageLoaded.value ? Scaffold(
      appBar: CustomHomeAppBar(
          title: 'Thirukurals Sections',
          titleColor: CommonColors.white,
        showLeading: true,
      ),
      backgroundColor: CommonColors.white,
      body: Center(
          child: Container(
              height: height,
              width: ResponsiveValue<double>(
                context,
                defaultValue: width * 0.5,
                conditionalValues: [
                  const Condition.smallerThan(
                      name: TABLET, value: double.infinity),
                ],
              ).value,
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
              child: ListView(
                  children: [
                    doShowSectionNamesOnly.value
                        ? showSectionNames() :
                          showKuralsInSelectedSection()
                  ]
              )
          )
      ),
    ) : showLoader();
  }
}
