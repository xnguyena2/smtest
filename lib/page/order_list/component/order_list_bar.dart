import 'package:flutter/material.dart';

import '../../../component/app_search_bar.dart';
import '../../../component/header.dart';
import '../../../utils/constants.dart';
import '../../../utils/svg_loader.dart';

class OrderListBar extends StatelessWidget implements PreferredSizeWidget {
  const OrderListBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: White,
      child: Header(
        title: 'Đơn hàng',
        funcWidget: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
          child: Row(
            children: [
              LoadSvg(
                assetPath: 'svg/filter.svg',
              ),
              const SizedBox(
                width: 20,
              ),
              LoadSvg(
                assetPath: 'svg/print.svg',
              ),
            ],
          ),
        ),
        extendsWidget: AppSearchBar(
          hint: 'Tìm theo tên',
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(95);
}
