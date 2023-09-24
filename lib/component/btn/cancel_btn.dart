import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';

class CancelBtn extends StatelessWidget {
  final String txt;
  final EdgeInsetsGeometry padding;
  final bool isSmallTxt;
  final VoidCallback onPressed;
  const CancelBtn(
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
        backgroundColor: White,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        txt,
        style: isSmallTxt ? subInfoStyLargeLigh400 : headStyleBigMedium,
      ),
    );
  }
}
