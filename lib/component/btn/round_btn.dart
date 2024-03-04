import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';

class RoundBtn extends StatelessWidget {
  final String txt;
  final Widget? icon;
  final bool isSelected;
  final VoidCallback onPressed;
  final bool isDelete;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final bool isFitContent;
  const RoundBtn({
    super.key,
    required this.txt,
    this.icon,
    required this.onPressed,
    this.isSelected = false,
    this.isDelete = false,
    this.padding = const EdgeInsets.symmetric(vertical: 10),
    this.backgroundColor,
    this.isFitContent = false,
  });

  BoxBorder get getBoxBorder {
    if (isDelete) {
      return alertBorder;
    }
    if (isSelected) {
      return tableHighBorder;
    }
    return lightBorder;
  }

  TextStyle get getTextStyle {
    if (isDelete) {
      return headStyleSemiLargeAlert500;
    }
    if (isSelected) {
      return headStyleSemiLargeHigh500;
    }
    return headStyleSemiLargeLigh500;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: defaultBorderRadius,
          border: getBoxBorder,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: isFitContent ? MainAxisSize.min : MainAxisSize.max,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(
                width: 10,
              ),
            ],
            Text(
              txt,
              style: getTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
