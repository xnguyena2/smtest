import 'package:flutter/material.dart';
import 'package:sales_management/component/btn/base_btn.dart';
import 'package:sales_management/utils/constants.dart';

class CancelBtn extends BaseBtn {
  const CancelBtn({
    super.key,
    required super.txt,
    required super.padding,
    required super.onPressed,
    super.backgroundColor = White,
    super.isSmallTxt = false,
    super.borderSide = const BorderSide(color: borderColor),
    super.headIcon,
  }) : super(
          textStyle: isSmallTxt ? subInfoStyLargeLigh400 : headStyleBigMedium,
        );
}
