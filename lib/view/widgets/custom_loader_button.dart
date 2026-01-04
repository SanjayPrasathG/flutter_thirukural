import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_thirukural/view/widgets/common_colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'common_widgets.dart';

class CustomLoaderButton extends HookConsumerWidget {
  final String? title;
  final Color buttonColor;
  final Color? buttonTextColor;
  final double? buttonTextSize;
  final double? width;
  final double? height;
  final bool isIconButton;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final Function() onTap;
  final Color loaderColor;

  const CustomLoaderButton({
    super.key,
    this.title,
    required this.buttonColor,
    this.buttonTextColor,
    this.buttonTextSize,
    required this.isIconButton,
    required this.onTap,
    this.width,
    this.height,
    this.icon,
    this.iconColor,
    this.iconSize,
    required this.loaderColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isLoading = useState(false);

    Widget buildLoader() {
      return SizedBox(
        width: buttonTextSize ?? iconSize ?? 20.0,
        height: buttonTextSize ?? iconSize ?? 20.0,
        child: CircularProgressIndicator(
          color: loaderColor,
          strokeWidth: 2.5,
        ),
      );
    }

    return isIconButton
        ? SizedBox(
            height: height,
            child: IconButton(
              style: ButtonStyle(
                iconSize: WidgetStateProperty.all(width ?? 25.0),
                shape: WidgetStateProperty.all(
                  const CircleBorder(),
                ),
                backgroundColor: WidgetStateProperty.all(buttonColor),
              ),
              color: buttonTextColor,
              onPressed: () async {
                isLoading.value = true;
                await Future.delayed(const Duration(milliseconds: 500));
                await onTap();
                isLoading.value = false;
              },
              icon: isLoading.value
                  ? buildLoader()
                  : Icon(
                      icon ?? Icons.arrow_forward_ios,
                      color: iconColor ?? CommonColors.black,
                      size: iconSize ?? 20.0,
                    ),
            ),
          )
        : MaterialButton(
            height: height ?? 50.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: buttonColor,
            minWidth: width ?? 75.0,
            elevation: 0.0,
            onPressed: () async {
              isLoading.value = true;
              await Future.delayed(const Duration(milliseconds: 500));
              await onTap();
              isLoading.value = false;
            },
            child: isLoading.value
                ? buildLoader()
                : customText(
                    text: title ?? 'Click here',
                    textColor: buttonTextColor ?? CommonColors.white,
                    fontSize: buttonTextSize ?? 15.0,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    textOverFlow: TextOverflow.clip,
                  ),
          );
  }
}
