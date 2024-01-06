import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';

class RoundBtn extends StatelessWidget {
  final String txt;
  final Widget icon;
  final bool isSelected;
  final VoidCallback onPressed;
  final bool isDelete;
  final EdgeInsetsGeometry? padding;
  const RoundBtn({
    super.key,
    required this.txt,
    required this.icon,
    required this.onPressed,
    this.isSelected = false,
    this.isDelete = false,
    this.padding = const EdgeInsets.symmetric(vertical: 10),
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
          borderRadius: defaultBorderRadius,
          border: getBoxBorder,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(
              width: 10,
            ),
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
