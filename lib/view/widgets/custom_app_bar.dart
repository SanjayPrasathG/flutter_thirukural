import 'package:flutter/material.dart';
import 'package:flutter_thirukural/view/widgets/common_colors.dart';
import 'package:flutter_thirukural/view/widgets/common_widgets.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color titleColor;
  final bool? showLeading;
  final bool? isCenterTitle;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;

  const CustomHomeAppBar({
    super.key,
    required this.title,
    required this.titleColor,
    this.showLeading,
    this.isCenterTitle,
    this.actions,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CommonColors.primary,
      elevation: 4,
      automaticallyImplyLeading: false,
      leading: showLeading != null && showLeading!
          ? IconButton(
              onPressed: () {
                if (onBackPressed != null) {
                  onBackPressed!();
                } else if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 15.0,
                color: CommonColors.white,
              ),
            )
          : null,
      actions: actions,
      title: customText(
        text: title,
        textColor: titleColor,
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
        textAlign: isCenterTitle != null && isCenterTitle!
            ? TextAlign.center
            : TextAlign.start,
        textOverFlow: TextOverflow.clip,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
