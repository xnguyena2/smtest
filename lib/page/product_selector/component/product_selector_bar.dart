import 'package:flutter/material.dart';

import '../../../component/header.dart';
import '../../../utils/constants.dart';
import '../../../utils/svg_loader.dart';

class ProductSelectorBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ProductSelectorBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: White, boxShadow: [defaultShadow]),
      child: Header(
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
                colorFilter: const ColorFilter.mode(
                  Black,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
        extendsWidget: SearchBar(
          hint: 'Tìm theo tên, code, ...',
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(95);
}

class SearchBar extends StatelessWidget {
  final String hint;
  const SearchBar({
    super.key,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: searchBackgroundColor,
        borderRadius: defaultBorderRadius,
        border: defaultBorder,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 25,
          ),
          LoadSvg(assetPath: 'svg/search.svg'),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextField(
              maxLines: 1,
              style: headStyleSemiLarge,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                isDense: true,
                border: InputBorder.none,
                hintText: hint,
              ),
            ),
          ),
          LoadSvg(assetPath: 'svg/close_circle.svg'),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
