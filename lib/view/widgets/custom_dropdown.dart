import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_thirukural/view/widgets/common_colors.dart';
import 'package:flutter_thirukural/view/widgets/common_widgets.dart';

class CustomDropDown extends HookWidget {
  final String? title;
  final String hintText;
  final String? selectedItem;
  final List<String>? itemsList;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final double? borderRadius;
  final double? elevation;
  final Color? fillColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;

  const CustomDropDown({
    super.key,
    this.title,
    required this.hintText,
    required this.selectedItem,
    required this.itemsList,
    required this.onChanged,
    this.validator,
    this.borderRadius,
    this.elevation,
    this.fillColor,
    this.padding,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final localSelected = useState<String?>(selectedItem);

    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 15.0),
        color: fillColor ?? Colors.grey.shade100,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          value: localSelected.value,
          isExpanded: true,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: CommonColors.grey,
              fontWeight: FontWeight.w600,
              fontSize: 15.0,
              fontFamily: primaryFontFamily
            ),
            labelText: title,
            filled: true,
            fillColor: fillColor ?? Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 15.0),
              borderSide: BorderSide(color: CommonColors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 15.0),
              borderSide: BorderSide(color: CommonColors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 15.0),
              borderSide: BorderSide(color: CommonColors.primary),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 15.0),
              borderSide: BorderSide(color: CommonColors.red),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
          validator: validator,
          style: style ?? TextStyle(color: CommonColors.black, fontSize: 16),
          elevation: elevation?.toInt() ?? 8,
          icon: const Icon(Icons.keyboard_arrow_down),
          dropdownColor: CommonColors.white,
          items: (itemsList ?? []).map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: customText(
                text: value,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
                textColor: CommonColors.black,
                textOverFlow: TextOverflow.clip
              ),
            );
          }).toList(),
          onChanged: (value) {
            localSelected.value = value;
            if (onChanged != null) {
              onChanged!(value);
            }
          },
        ),
      ),
    );
  }
}
