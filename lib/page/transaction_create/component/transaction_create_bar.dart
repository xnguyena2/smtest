import 'package:flutter/material.dart';
import 'package:sales_management/component/bar/bar_small.dart';
import 'package:sales_management/component/header.dart';
import 'package:sales_management/utils/constants.dart';

class TransactionCreateBar extends BarSmall {
  final bool isIncome;
  const TransactionCreateBar({super.key, required this.isIncome});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: White,
      child: Header(
        title: isIncome ? 'Khoản thu' : 'Khoản chi',
        funcWidget: SizedBox(),
        extendsWidget: SizedBox(),
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
