import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';

class BaseBtn extends StatelessWidget {
  final String txt;
  final EdgeInsetsGeometry padding;
  final bool isSmallTxt;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final BorderSide borderSide;
  final TextStyle? textStyle;
  const BaseBtn({
    super.key,
    required this.txt,
    required this.padding,
    required this.backgroundColor,
    this.textStyle,
    this.borderSide = BorderSide.none,
    this.onPressed,
    this.isSmallTxt = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: padding,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: backgroundColor,
        disabledBackgroundColor: Black40,
        shape: RoundedRectangleBorder(
          side: borderSide,
          borderRadius: defaultBorderRadius,
        ),
      ),
      child: Text(
        txt,
        style: textStyle ??
            (isSmallTxt ? subInfoStyLargeWhite400 : headStyleBigMediumWhite),
      ),
    );
  }
}
