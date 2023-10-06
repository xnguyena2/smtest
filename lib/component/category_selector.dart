import 'package:flutter/material.dart';
import 'package:sales_management/utils/typedef.dart';

import '../page/product_selector/product_selector_page.dart';
import '../utils/svg_loader.dart';

class CategorySelector extends StatelessWidget {
  final bool multiSelected;
  final bool isFlip;
  final List<String> listCategory;
  final VoidCallbackArg<List<String>> onChanged;
  final List<String> itemsSelected;
  const CategorySelector({
    super.key,
    required this.listCategory,
    required this.onChanged,
    required this.itemsSelected,
    required this.isFlip,
    this.multiSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    // print(widget.itemsSelected);
    return SizedBox(
      height: 60,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index == 0) {
              return LoadSvg(assetPath: 'svg/grid_horizontal.svg');
            }
            String value = listCategory[index - 1];
            return CategoryItem(
              txt: value,
              isFlip: isFlip,
              isActive: itemsSelected.contains(value),
              onTap: (isSelected) {
                if (multiSelected) {
                  if (isSelected) {
                    itemsSelected.add(value);
                  } else {
                    itemsSelected.remove(value);
                  }
                  onChanged(itemsSelected);
                  return;
                }
                itemsSelected.clear();
                if (isSelected) {
                  itemsSelected.add(value);
                }
                onChanged(itemsSelected);
              },
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
          itemCount: listCategory.length + 1),
    );
  }
}
