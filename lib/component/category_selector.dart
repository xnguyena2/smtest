import 'package:flutter/material.dart';

import '../page/product_selector/product_selector_page.dart';
import '../utils/svg_loader.dart';

class CategorySelector extends StatelessWidget {
  final List<String> listCategory;
  const CategorySelector({
    super.key,
    required this.listCategory,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index == 0) {
              return LoadSvg(assetPath: 'svg/grid_horizontal.svg');
            }
            if (index == 1) {
              return CategoryItem(
                txt: 'Tất cả',
                isActive: true,
              );
            }
            return CategoryItem(
              txt: listCategory[index - 2],
              isActive: false,
            );
          },
          separatorBuilder: (context, index) => SizedBox(
                width: 10,
              ),
          itemCount: listCategory.length + 2),
    );
  }
}
