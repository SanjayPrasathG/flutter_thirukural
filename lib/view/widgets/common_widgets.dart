import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/kural_model.dart';
import 'common_colors.dart';
import 'custom_loader_button.dart';

String primaryFontFamily = GoogleFonts.lexend().fontFamily ?? '';

Widget customText({
  required String text,
  required Color textColor,
  required double fontSize,
  required FontWeight fontWeight,
  required TextAlign textAlign,
  required TextOverflow textOverFlow,
  int? maxLines,
}){
  return Text(
    text,
    textAlign: textAlign,
    overflow: textOverFlow,
    maxLines: maxLines ?? 1,
    style: TextStyle(
      color: textColor,
      fontFamily: primaryFontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight
    ),
  );
}

Widget showKural({required Kural kural, required double imgHeight, required double imgWidth}){
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 3.0, vertical: 1.5),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: CommonColors.lightPrimary,
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 10.0,
          children: [
            Expanded(
              flex: 1,
              child: ClipOval(
                child: SizedBox(
                  width: imgWidth,
                  height: imgHeight,
                  child: Image.asset(
                    'assets/images/thiruvalluvar_img.png',
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
                child: customText(
                    text: kural.kural ?? '',
                    textColor: CommonColors.blue,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.start,
                    textOverFlow: TextOverflow.clip,
                  maxLines: 2
                ),
            ),
          ],
        ),
        SizedBox(height: 10.0,),
        customText(
            text: 'Kural Number : ${kural.kuralNumber ?? 'N/A'}',
            textColor: CommonColors.purple,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.start,
            textOverFlow: TextOverflow.clip
        ),
        SizedBox(height: 10.0,),
        customText(
            text: 'Tamil Explanation: ',
            textColor: CommonColors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.start,
            textOverFlow: TextOverflow.clip
        ),
        SizedBox(height: 5.0,),
        customText(
            text: kural.tamilExplanation ?? '',
            textColor: CommonColors.green,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.start,
            textOverFlow: TextOverflow.clip,
            maxLines: 5
        ),
        SizedBox(height: 10.0,),
        customText(
            text: 'English Explanation: ',
            textColor: CommonColors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.start,
            textOverFlow: TextOverflow.clip,
        ),
        SizedBox(height: 5.0,),
        customText(
            text: kural.englishExplanation ?? '',
            textColor: CommonColors.green,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.start,
            textOverFlow: TextOverflow.clip,
            maxLines: 5
        ),
        SizedBox(height: 10.0,),
        customText(
            text: 'Section Name',
            textColor: CommonColors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.start,
            textOverFlow: TextOverflow.clip
        ),
        SizedBox(height: 5.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 5.0,
          children: [
            Expanded(
              child: customText(
                  text: kural.tamilSectionName ?? '',
                  textColor: CommonColors.gold,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.start,
                  textOverFlow: TextOverflow.clip
              ),
            ),
            Expanded(
              child: customText(
                  text: kural.englishSectionName ?? '',
                  textColor: CommonColors.gold,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.end,
                  textOverFlow: TextOverflow.clip
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0,),
        customText(
            text: 'Chapter Name',
            textColor: CommonColors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.start,
            textOverFlow: TextOverflow.clip
        ),
        SizedBox(height: 5.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 5.0,
          children: [
            Expanded(
              child: customText(
                  text: kural.tamilChapterName ?? '',
                  textColor: CommonColors.orange,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.start,
                  textOverFlow: TextOverflow.clip
              ),
            ),
            Expanded(
              child: customText(
                  text: kural.englishChapterName ?? '',
                  textColor: CommonColors.orange,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.end,
                  textOverFlow: TextOverflow.clip
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0,),
      ],
    ),
  );
}

Widget showLoader(){
  return Scaffold(
      backgroundColor: CommonColors.white,
      body: Center(child: CircularProgressIndicator(color: CommonColors.primary,),
      )
  );
}

Widget customListTile({
  required IconData leadingIcon,
  required String title,
  required Function() navigateTo,
  required double height
}){
  return ListTile(
    leading: Icon(leadingIcon, color: CommonColors.secondaryColor, size: 18.0,),
    title: customText(
        text: title,
        textColor: CommonColors.black,
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.center,
        textOverFlow: TextOverflow.clip,
        maxLines: 2
    ),
    onTap: navigateTo,
    trailing: CustomLoaderButton(
      isIconButton: true,
      onTap: () async{
        await navigateTo();
      },
      icon: Icons.arrow_forward_ios,
      iconColor: CommonColors.white,
      iconSize: 15.0,
      buttonColor: CommonColors.primary,
      loaderColor: CommonColors.white,
      height: height,
    ),
  );
}

Widget spaceDivider(){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    child: Divider(
      color: CommonColors.grey,
      height: 5.0,
      thickness: 0.25,
    ),
  );
}

Widget showErrorWidget({required String errorMessage}){
  return Center(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
      child: customText(
          text: errorMessage,
          maxLines: 5,
          textColor: CommonColors.red,
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
          textOverFlow: TextOverflow.clip
      ),
    ),
  );
}

