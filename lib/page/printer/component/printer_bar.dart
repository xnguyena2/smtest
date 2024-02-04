import 'package:flutter/material.dart';
import 'package:sales_management/component/bar/bar_small.dart';
import 'package:sales_management/component/header.dart';
import 'package:sales_management/utils/constants.dart';

class PrinterBar extends BarSmall {
  const PrinterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(color: White, boxShadow: [
        defaultShadow,
      ]),
      child: Header(
        title: 'Máy in',
        funcWidget: SizedBox(),
        extendsWidget: SizedBox(),
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
