import 'package:flutter/material.dart';

import '../../../component/header.dart';
import '../../../component/app_search_bar.dart';
import '../../../utils/constants.dart';
import '../../../utils/svg_loader.dart';

class ProductSelectorBar extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback onBackPressed;
  const ProductSelectorBar({super.key, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: White, boxShadow: [defaultShadow]),
      child: Header(
        onBackPressed: onBackPressed,
        title: 'Bán hàng',
        funcWidget: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
          child: Row(
            children: [
              LoadSvg(assetPath: 'svg/sort_by.svg'),
              const SizedBox(
                width: 20,
              ),
              LoadSvg(assetPath: 'svg/grid.svg'),
              const SizedBox(
                width: 20,
              ),
              LoadSvg(assetPath: 'svg/grid_left_panel.svg'),
              const SizedBox(
                width: 20,
              ),
              LoadSvg(assetPath: 'svg/list_ul.svg'),
              const SizedBox(
                width: 20,
              ),
              LoadSvg(
                assetPath: 'svg/order.svg',
                width: 27,
                height: 27,
                color: Black,
              ),
            ],
          ),
        ),
        extendsWidget: AppSearchBar(
          hint: 'Tìm theo tên, code, ...',
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(95);
}
