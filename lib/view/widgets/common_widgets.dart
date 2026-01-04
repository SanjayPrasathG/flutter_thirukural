import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/kural_model.dart';
import 'common_colors.dart';

String primaryFontFamily = GoogleFonts.poppins().fontFamily ?? '';
String tamilFontFamily = GoogleFonts.notoSansTamil().fontFamily ?? '';

Widget customText({
  required String text,
  required Color textColor,
  required double fontSize,
  required FontWeight fontWeight,
  required TextAlign textAlign,
  required TextOverflow textOverFlow,
  int? maxLines,
  String? fontFamily,
  double? letterSpacing,
  double? height,
}) {
  return Text(
    text,
    textAlign: textAlign,
    overflow: textOverFlow,
    maxLines: maxLines ?? 1,
    style: TextStyle(
      color: textColor,
      fontFamily: fontFamily ?? primaryFontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
    ),
  );
}

Widget showKural({
  required Kural kural,
  required double imgHeight,
  required double imgWidth,
  required bool isMobile,
}) {
  final fullText = kural.kural ?? '';

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white,
          CommonColors.lightPrimary.withValues(alpha: 0.5),
        ],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: CommonColors.primary.withValues(alpha: 0.15),
          blurRadius: 20,
          offset: const Offset(0, 8),
          spreadRadius: 0,
        ),
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.8),
          blurRadius: 10,
          offset: const Offset(-5, -5),
          spreadRadius: 0,
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildKuralHeader(kural.kuralNumber ?? 0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildKuralTextSection(fullText, isMobile),
                const SizedBox(height: 20.0),
                _buildExplanationsSection(kural),
                const SizedBox(height: 16.0),
                _buildMetadataSection(kural),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildKuralHeader(int kuralNumber) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          CommonColors.primary,
          CommonColors.primary.withValues(alpha: 0.8),
          CommonColors.secondaryColor,
        ],
      ),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.auto_stories,
            color: Colors.white.withValues(alpha: 0.9),
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: customText(
            text: 'குறள் #$kuralNumber',
            textColor: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.start,
            textOverFlow: TextOverflow.ellipsis,
            fontFamily: tamilFontFamily,
            letterSpacing: 0.5,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Kural $kuralNumber',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: primaryFontFamily,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildKuralTextSection(String kuralText, bool isMobile) {
  return Stack(
    children: [
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFEBCF8E),
              Color(0xFFD4A55C),
              Color(0xFFEBCF8E),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
          borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: const Color(0xFF8D5A2B),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            _buildThiruvalluvarImage(isMobile),
            const SizedBox(height: 16),
            _buildSplitKuralText(
              kuralText,
              isMobile,
              isOlaiChuvadi: true,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 2,
                  color: const Color(0xFF5D4037).withValues(alpha: 0.5),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: customText(
                    text: "திருவள்ளுவர்",
                    textColor: const Color(0xFF3E2723),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                    textOverFlow: TextOverflow.clip,
                    fontFamily: tamilFontFamily,
                  ),
                ),
                Container(
                  width: 40,
                  height: 2,
                  color: const Color(0xFF5D4037).withValues(alpha: 0.5),
                ),
              ],
            ),
          ],
        ),
      ),
      Positioned(
        left: 16,
        top: 0,
        bottom: 0,
        child: Center(
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: const Color(0xFF3E2723),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.5),
                  blurRadius: 1,
                  offset: const Offset(1, 1),
                )
              ],
            ),
          ),
        ),
      ),
      Positioned(
        right: 16,
        top: 0,
        bottom: 0,
        child: Center(
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: const Color(0xFF3E2723),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.5),
                  blurRadius: 1,
                  offset: const Offset(-1, 1),
                )
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildThiruvalluvarImage(bool isMobile) {
  final imageSize = isMobile ? 80.0 : 100.0;

  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFFD4AF37),
          const Color(0xFFF5E1A4),
          const Color(0xFFD4AF37),
        ],
      ),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFFD4AF37).withValues(alpha: 0.4),
          blurRadius: 15,
          offset: const Offset(0, 5),
          spreadRadius: 2,
        ),
      ],
    ),
    padding: const EdgeInsets.all(4),
    child: Container(
      width: imageSize,
      height: imageSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: CommonColors.primary.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/thiruvalluvar_img.png',
          package: 'flutter_thirukural',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/images/thiruvalluvar_img.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: CommonColors.lightPrimary,
                  child: Icon(
                    Icons.person,
                    size: imageSize * 0.5,
                    color: CommonColors.primary,
                  ),
                );
              },
            );
          },
        ),
      ),
    ),
  );
}

Widget _buildExplanationsSection(Kural kural) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildExplanationCard(
        icon: Icons.translate,
        title: 'தமிழ் விளக்கம்',
        titleEnglish: 'Tamil Explanation',
        content: kural.tamilExplanation ?? '',
        gradientColors: [
          const Color(0xFF667eea).withValues(alpha: 0.1),
          const Color(0xFF764ba2).withValues(alpha: 0.05),
        ],
        iconColor: const Color(0xFF667eea),
        fontFamily: tamilFontFamily,
      ),
      const SizedBox(height: 12),
      _buildExplanationCard(
        icon: Icons.language,
        title: 'English Explanation',
        titleEnglish: '',
        content: kural.englishExplanation ?? '',
        gradientColors: [
          const Color(0xFF11998e).withValues(alpha: 0.1),
          const Color(0xFF38ef7d).withValues(alpha: 0.05),
        ],
        iconColor: const Color(0xFF11998e),
        fontFamily: primaryFontFamily,
      ),
    ],
  );
}

Widget _buildExplanationCard({
  required IconData icon,
  required String title,
  required String titleEnglish,
  required String content,
  required List<Color> gradientColors,
  required Color iconColor,
  required String fontFamily,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: gradientColors,
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(
        color: iconColor.withValues(alpha: 0.2),
        width: 1,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: iconColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: title.contains('தமிழ்')
                          ? tamilFontFamily
                          : primaryFontFamily,
                    ),
                  ),
                  if (titleEnglish.isNotEmpty)
                    Text(
                      titleEnglish,
                      style: TextStyle(
                        color: iconColor.withValues(alpha: 0.7),
                        fontSize: 11,
                        fontFamily: primaryFontFamily,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: fontFamily,
            height: 1.6,
          ),
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

Widget _buildMetadataSection(Kural kural) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(
        color: Colors.grey.shade200,
        width: 1,
      ),
    ),
    child: Column(
      children: [
        _buildMetadataRow(
          icon: Icons.folder_outlined,
          label: 'Section',
          tamilValue: kural.tamilSectionName ?? '',
          englishValue: kural.englishSectionName ?? '',
          iconColor: const Color(0xFFFF6B6B),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Divider(
            color: Colors.grey.shade300,
            height: 1,
          ),
        ),
        _buildMetadataRow(
          icon: Icons.bookmark_outline,
          label: 'Chapter',
          tamilValue: kural.tamilChapterName ?? '',
          englishValue: kural.englishChapterName ?? '',
          iconColor: const Color(0xFF4ECDC4),
        ),
      ],
    ),
  );
}

Widget _buildMetadataRow({
  required IconData icon,
  required String label,
  required String tamilValue,
  required String englishValue,
  required Color iconColor,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: iconColor, size: 18),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                fontFamily: primaryFontFamily,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              tamilValue,
              style: TextStyle(
                color: iconColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: tamilFontFamily,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              englishValue,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                fontFamily: primaryFontFamily,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
Widget showKuralWithShowMore({
  required int index,
  required Kural kural,
  required double imgHeight,
  required double imgWidth,
  required bool isMobile,
  required bool isExpanded,
  required VoidCallback onToggle,
}) {
  final fullText = kural.kural ?? '';

  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: isExpanded
              ? CommonColors.primary.withValues(alpha: 0.2)
              : Colors.grey.withValues(alpha: 0.1),
          blurRadius: isExpanded ? 20 : 10,
          offset: const Offset(0, 4),
          spreadRadius: isExpanded ? 2 : 0,
        ),
      ],
      border: Border.all(
        color: isExpanded
            ? CommonColors.primary.withValues(alpha: 0.3)
            : Colors.transparent,
        width: 1.5,
      ),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(18.0),
      child: Column(
        children: [
          _buildCollapsibleHeader(kural.kuralNumber ?? 0, isExpanded, onToggle),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildCompactKuralText(fullText, isMobile),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  _buildExplanationsSection(kural),
                  const SizedBox(height: 16),
                  _buildMetadataSection(kural),
                ],
              ),
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    ),
  );
}

Widget _buildCollapsibleHeader(
    int kuralNumber, bool isExpanded, VoidCallback onToggle) {
  return InkWell(
    onTap: onToggle,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: isExpanded
              ? [CommonColors.primary, CommonColors.secondaryColor]
              : [CommonColors.lightPrimary, CommonColors.lightPrimary],
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isExpanded
                  ? Colors.white.withValues(alpha: 0.2)
                  : CommonColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '$kuralNumber',
                style: TextStyle(
                  color: isExpanded ? Colors.white : CommonColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: primaryFontFamily,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'குறள் எண் $kuralNumber',
              style: TextStyle(
                color: isExpanded ? Colors.white : CommonColors.primary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: tamilFontFamily,
              ),
            ),
          ),
          AnimatedRotation(
            turns: isExpanded ? 0.5 : 0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isExpanded
                    ? Colors.white.withValues(alpha: 0.2)
                    : CommonColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: isExpanded ? Colors.white : CommonColors.primary,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildCompactKuralText(String kuralText, bool isMobile) {
  return Stack(
    children: [
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFEBCF8E),
              Color(0xFFD4A55C),
              Color(0xFFEBCF8E),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF8D5A2B),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            _buildSmallThiruvalluvarImage(),
            const SizedBox(height: 12),
            _buildSplitKuralText(
              kuralText,
              isMobile,
              isCompact: true,
              isOlaiChuvadi: true,
            ),
            const SizedBox(height: 8),
            Text(
              "— திருவள்ளுவர்",
              style: TextStyle(
                color: const Color(0xFF3E2723).withValues(alpha: 0.8),
                fontSize: 12,
                fontStyle: FontStyle.italic,
                fontFamily: tamilFontFamily,
              ),
            ),
          ],
        ),
      ),
      Positioned(
        left: 10,
        top: 0,
        bottom: 0,
        child: Center(
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFF3E2723),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.5),
                  blurRadius: 1,
                  offset: const Offset(1, 1),
                )
              ],
            ),
          ),
        ),
      ),
      Positioned(
        right: 10,
        top: 0,
        bottom: 0,
        child: Center(
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFF3E2723),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.5),
                  blurRadius: 1,
                  offset: const Offset(-1, 1),
                )
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildSmallThiruvalluvarImage() {
  const imageSize = 50.0;

  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFFD4AF37),
          const Color(0xFFF5E1A4),
          const Color(0xFFD4AF37),
        ],
      ),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
          blurRadius: 8,
          offset: const Offset(0, 3),
          spreadRadius: 1,
        ),
      ],
    ),
    padding: const EdgeInsets.all(3),
    child: Container(
      width: imageSize,
      height: imageSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: CommonColors.primary.withValues(alpha: 0.2),
          width: 1.5,
        ),
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/thiruvalluvar_img.png',
          package: 'flutter_thirukural',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/images/thiruvalluvar_img.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: CommonColors.lightPrimary,
                  child: Icon(
                    Icons.person,
                    size: imageSize * 0.5,
                    color: CommonColors.primary,
                  ),
                );
              },
            );
          },
        ),
      ),
    ),
  );
}

Widget _buildSplitKuralText(
  String text,
  bool isMobile, {
  bool isCompact = false,
  bool isOlaiChuvadi = false,
}) {
  final words = text.trim().split(RegExp(r'\s+'));
  String line1 = text;
  String line2 = '';

  if (words.length > 4) {
    line1 = words.sublist(0, 4).join(' ');
    line2 = words.sublist(4).join(' ');
  }

  Color textColor;
  if (isOlaiChuvadi) {
    textColor = const Color(0xFF3E2723);
  } else {
    textColor = isCompact ? const Color(0xFF2D3748) : const Color(0xFF1A237E);
  }

  final fontSize =
      isCompact ? (isMobile ? 15.0 : 17.0) : (isMobile ? 16.0 : 18.0);
  final fontWeight = FontWeight.w600;

  return Column(
    children: [
      customText(
        text: line1,
        textColor: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        textAlign: TextAlign.center,
        textOverFlow: TextOverflow.visible,
        maxLines: 2,
        fontFamily: tamilFontFamily,
        height: 1.6,
      ),
      if (line2.isNotEmpty) ...[
        SizedBox(height: isCompact ? 4 : 8),
        customText(
          text: line2,
          textColor: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          textAlign: TextAlign.center,
          textOverFlow: TextOverflow.visible,
          maxLines: 2,
          fontFamily: tamilFontFamily,
          height: 1.6,
        ),
      ],
    ],
  );
}

Widget buildPaginationControls({
  required int currentPage,
  required int totalPages,
  required Function(int) onPageChanged,
  required bool isMobile,
}) {
  int startPage = (currentPage - 2).clamp(1, totalPages);
  int endPage = (startPage + 4).clamp(1, totalPages);
  if (endPage - startPage < 4 && startPage > 1) {
    startPage = (endPage - 4).clamp(1, totalPages);
  }

  List<int> visiblePages = [];
  for (int i = startPage; i <= endPage; i++) {
    visiblePages.add(i);
  }

  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPaginationButton(
          icon: Icons.first_page,
          isEnabled: currentPage > 1,
          onTap: () => onPageChanged(1),
        ),
        const SizedBox(width: 4),
        _buildPaginationButton(
          icon: Icons.chevron_left,
          isEnabled: currentPage > 1,
          onTap: () => onPageChanged(currentPage - 1),
        ),
        const SizedBox(width: 8),
        if (!isMobile) ...[
          if (startPage > 1) ...[
            _buildPageNumber(1, currentPage == 1, () => onPageChanged(1)),
            if (startPage > 2)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child:
                    Text('...', style: TextStyle(color: Colors.grey.shade600)),
              ),
          ],
        ],
        ...visiblePages.map((page) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: _buildPageNumber(
                page,
                currentPage == page,
                () => onPageChanged(page),
              ),
            )),
        if (!isMobile) ...[
          if (endPage < totalPages) ...[
            if (endPage < totalPages - 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child:
                    Text('...', style: TextStyle(color: Colors.grey.shade600)),
              ),
            _buildPageNumber(totalPages, currentPage == totalPages,
                () => onPageChanged(totalPages)),
          ],
        ],
        const SizedBox(width: 8),
        _buildPaginationButton(
          icon: Icons.chevron_right,
          isEnabled: currentPage < totalPages,
          onTap: () => onPageChanged(currentPage + 1),
        ),
        const SizedBox(width: 4),
        _buildPaginationButton(
          icon: Icons.last_page,
          isEnabled: currentPage < totalPages,
          onTap: () => onPageChanged(totalPages),
        ),
      ],
    ),
  );
}

Widget _buildPaginationButton({
  required IconData icon,
  required bool isEnabled,
  required VoidCallback onTap,
}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: isEnabled ? onTap : null,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isEnabled
              ? CommonColors.primary.withValues(alpha: 0.1)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: isEnabled ? CommonColors.primary : Colors.grey.shade400,
          size: 20,
        ),
      ),
    ),
  );
}

Widget _buildPageNumber(int number, bool isSelected, VoidCallback onTap) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isSelected ? CommonColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? CommonColors.primary : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            '$number',
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey.shade700,
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              fontFamily: primaryFontFamily,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buildPageInfo({
  required int currentPage,
  required int totalPages,
  required int totalItems,
  required int itemsPerPage,
}) {
  final startItem = ((currentPage - 1) * itemsPerPage) + 1;
  final endItem = (currentPage * itemsPerPage).clamp(0, totalItems);

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Text(
      'Showing $startItem-$endItem of $totalItems Kurals',
      style: TextStyle(
        color: Colors.grey.shade600,
        fontSize: 13,
        fontFamily: primaryFontFamily,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Widget showLoader() {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: CommonColors.lightPrimary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: CircularProgressIndicator(
              color: CommonColors.primary,
              strokeWidth: 3,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Loading Kurals...',
            style: TextStyle(
              color: CommonColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: primaryFontFamily,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget customListTile({
  required IconData leadingIcon,
  required String title,
  required Function() navigateTo,
  required double height,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.08),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              CommonColors.primary.withValues(alpha: 0.15),
              CommonColors.secondaryColor.withValues(alpha: 0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          leadingIcon,
          color: CommonColors.primary,
          size: 22,
        ),
      ),
      title: customText(
        text: title,
        textColor: Colors.black87,
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        textAlign: TextAlign.start,
        textOverFlow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
      onTap: navigateTo,
      trailing: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [CommonColors.primary, CommonColors.secondaryColor],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
          size: 14,
        ),
      ),
    ),
  );
}

Widget spaceDivider() {
  return const SizedBox(height: 4);
}

Widget showErrorWidget({required String errorMessage}) {
  return Center(
    child: Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red.shade400,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            errorMessage,
            style: TextStyle(
              color: Colors.red.shade700,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: primaryFontFamily,
            ),
            textAlign: TextAlign.center,
            maxLines: 5,
          ),
        ],
      ),
    ),
  );
}
