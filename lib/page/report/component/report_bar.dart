import 'package:flutter/material.dart';
import 'package:sales_management/component/header.dart';
import 'package:sales_management/utils/constants.dart';

class ReportBar extends StatelessWidget implements PreferredSizeWidget {
  const ReportBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(color: White, boxShadow: [defaultShadow]),
      child: Header(
        title: 'Báo cáo',
        funcWidget: SizedBox(),
        extendsWidget: SizedBox(),
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}
