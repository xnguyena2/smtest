import 'package:flutter/material.dart';
import 'package:sales_management/component/header.dart';
import 'package:sales_management/utils/constants.dart';
// ignore: unused_import
import 'package:sales_management/utils/svg_loader.dart';

class IncomeOutComeBar extends StatefulWidget implements PreferredSizeWidget {
  const IncomeOutComeBar({
    super.key,
  });

  @override
  State<IncomeOutComeBar> createState() => _IncomeOutComeBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}

class _IncomeOutComeBarState extends State<IncomeOutComeBar> {
  String currentRange = 'Tháng này';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: White,
      child: Header(
        title: 'Thu chi',
        funcWidget: SizedBox(),
        extendsWidget: SizedBox(),
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
