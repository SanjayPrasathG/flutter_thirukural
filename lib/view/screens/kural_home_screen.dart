import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_thirukural/helpers/common_helpers.dart';
import 'package:flutter_thirukural/view/screens/all_kurals_in_range__screen.dart';
import 'package:flutter_thirukural/view/screens/get_kural_by_number.dart';
import 'package:flutter_thirukural/view/screens/get_kural_of_day_screen.dart';
import 'package:flutter_thirukural/view/screens/section_names_screen.dart';
import 'package:flutter_thirukural/view/screens/thirukural_by_english_chapter_names_screen.dart';
import 'package:flutter_thirukural/view/screens/thirukural_by_tamil_chapter_names_screen.dart';
import 'package:flutter_thirukural/view/widgets/common_colors.dart';
import 'package:flutter_thirukural/view/widgets/common_widgets.dart';
import 'package:flutter_thirukural/view/widgets/custom_app_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:get/get.dart' as GET;

import '../widgets/custom_loader_button.dart';
import 'all_kurals_screen.dart';

class KuralHomeScreen extends HookConsumerWidget{
  const KuralHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    var isPageLoaded=  useState(false);
    var selectedTile = useState('');
    var height = getDeviceHeight(context);
    var width = getDeviceWidth(context);
    var deviceName = getDeviceInfo(context);
    
    Future onPageLoaded() async{
      isPageLoaded.value = false;
      isPageLoaded.value = true;
    }
    
    useEffect((){
      onPageLoaded();
      return null;
    }, []);
    
    return Scaffold(
      appBar: CustomHomeAppBar(
          title: 'Thirukurals', 
          titleColor: CommonColors.white
      ),
      backgroundColor: CommonColors.white,
      body: Center(
        child: Container(
          height: height,
          width: ResponsiveValue<double>(
            context,
            defaultValue: width * 0.5,
            conditionalValues: [
            const Condition.smallerThan(name: TABLET, value: double.infinity),
          ],).value,
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
          child: ListView(
            children: [
              customListTile(
                  leadingIcon: Icons.today,
                  title: 'Thirukural of the Day',
                  navigateTo: (){
                    selectedTile.value= 'Thirukural of the Day';
                    GET.Get.to(()=> GetThirukuralOfDayScreen(date: '22-06-2025'));
                  },
                height: height * 0.045,
              ),
              spaceDivider(),
              customListTile(
                  leadingIcon: Icons.search,
                  title: 'Search Thirukural by Number',
                  navigateTo: (){
                    selectedTile.value= 'Search Thirukural by Number';
                    GET.Get.to(()=> GetKuralByNumber(kuralNumber: 153,));
                  },
                height: height * 0.045,
              ),
              spaceDivider(),
              customListTile(
                  leadingIcon: Icons.list,
                  title: 'All Thirukurals',
                  navigateTo: (){
                    selectedTile.value= 'All Thirukurals';
                    GET.Get.to(()=> AllKuralsScreen());
                  },
                height: height * 0.045,
              ),
              spaceDivider(),
              customListTile(
                  leadingIcon: Icons.straighten,
                  title: 'Thirukurals in range',
                  navigateTo: (){
                    selectedTile.value= 'Thirukural in range';
                    GET.Get.to(()=> AllKuralsScreenInRange(from: 1, to: 10,));
                  },
                height: height * 0.045,
              ),
              spaceDivider(),
              customListTile(
                  leadingIcon: Icons.book,
                  title: 'Section Names with Thirukurals',
                  navigateTo: (){
                    selectedTile.value= 'Thirukural Section Names';
                    GET.Get.to(()=> SectionNamesScreen());
                  },
                height: height * 0.045,
              ),
              spaceDivider(),
              customListTile(
                  leadingIcon: Icons.auto_stories,
                  title: 'Tamil Chapter Names with Thirukural',
                  navigateTo: (){
                    selectedTile.value= 'Get Thirukurals By Tamil Chapter Names';
                    GET.Get.to(()=> ThirukuralByTamilChapterName());
                  },
                height: height * 0.045,
              ),
              spaceDivider(),
              customListTile(
                  leadingIcon: Icons.auto_stories,
                  title: 'English Chapter Names with Thirukural',
                  navigateTo: (){
                    selectedTile.value= 'Get Thirukurals By English Chapter Names';
                    GET.Get.to(()=> ThirukuralByEnglishChapterName());
                  },
                height: height * 0.045,
              ),
              spaceDivider(),
            ],
          ),
        ),
      ),
    );
  }

}