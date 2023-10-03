import 'package:flutter/material.dart';

import '../../../component/header.dart';
import '../../../component/app_search_bar.dart';
import '../../../utils/constants.dart';
import '../../../utils/svg_loader.dart';

class TableSelectorBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackPressed;
  const TableSelectorBar({super.key, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: White, boxShadow: [defaultShadow]),
      child: Header(
        title: 'Quản lý bàn',
        funcWidget: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
          child: Row(
            children: [
              LoadSvg(
                assetPath: 'svg/order.svg',
                width: 27,
                height: 27,
                colorFilter: const ColorFilter.mode(
                  Black,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
        extendsWidget: AppSearchBar(
          hint: 'Tìm theo tên',
        ),
        onBackPressed: onBackPressed,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(95);
}
