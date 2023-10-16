import 'package:flutter/material.dart';
import 'package:sales_management/component/btn/base_btn.dart';
import 'package:sales_management/utils/constants.dart';

class ApproveBtn extends BaseBtn {
  const ApproveBtn(
      {super.key,
      required String txt,
      required EdgeInsetsGeometry padding,
      required VoidCallback onPressed,
      bool isSmallTxt = false,
      bool isActiveOk = false})
      : super(
          txt: txt,
          backgroundColor: TableHighColor,
          padding: padding,
          isSmallTxt: isSmallTxt,
          onPressed: isActiveOk ? onPressed : null,
        );
}
