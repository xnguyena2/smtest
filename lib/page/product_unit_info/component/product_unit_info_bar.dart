import 'package:flutter/material.dart';
import 'package:sales_management/component/bar/bar_small.dart';
import 'package:sales_management/component/header.dart';
import 'package:sales_management/utils/constants.dart';
// ignore: unused_import
import 'package:sales_management/utils/svg_loader.dart';

class ProductUnitInfoBar extends BarSmall {
  const ProductUnitInfoBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: White,
      child: Header(
        title: 'Chi tiết phân loại',
        funcWidget: SizedBox(),
        extendsWidget: SizedBox(),
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}