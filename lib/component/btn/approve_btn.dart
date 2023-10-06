import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';

class ApproveBtn extends StatelessWidget {
  final String txt;
  final EdgeInsetsGeometry padding;
  final bool isSmallTxt;
  final VoidCallback onPressed;
  const ApproveBtn(
      {super.key,
      required this.txt,
      required this.padding,
      this.isSmallTxt = false,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: padding,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: TableHighColor,
        shape: RoundedRectangleBorder(
          borderRadius: defaultBorderRadius,
        ),
      ),
      child: Text(
        txt,
        style: isSmallTxt ? subInfoStyLargeWhite400 : headStyleBigMediumWhite,
      ),
    );
  }
}
