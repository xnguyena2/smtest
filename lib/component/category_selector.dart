import 'package:flutter/material.dart';
import 'package:sales_management/utils/typedef.dart';

import '../page/product_selector/product_selector_page.dart';
import '../utils/svg_loader.dart';

class CategorySelector extends StatefulWidget {
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
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
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
            String value = widget.listCategory[index - 1];
            return CategoryItem(
              txt: value,
              isFlip: widget.isFlip,
              isActive: widget.itemsSelected.contains(value),
              onTap: (isSelected) {
                if (widget.multiSelected) {
                  if (isSelected) {
                    widget.itemsSelected.add(value);
                  } else {
                    widget.itemsSelected.remove(value);
                  }
                  widget.onChanged(widget.itemsSelected);
                  setState(() {});
                  return;
                }
                widget.itemsSelected.clear();
                if (isSelected) {
                  widget.itemsSelected.add(value);
                }
                widget.onChanged(widget.itemsSelected);
                setState(() {});
              },
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
          itemCount: widget.listCategory.length + 1),
    );
  }
}
