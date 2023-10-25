import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';

class CategorySelector extends StatelessWidget {
  final Widget firstWidget;
  final Widget? lastWidget;
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
    required this.firstWidget,
    this.lastWidget,
    this.multiSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    int count = listCategory.length + 1 + (lastWidget == null ? 0 : 1);
    return SizedBox(
      height: 60,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index == 0) {
              return firstWidget;
            }
            if (lastWidget != null && index == count - 1) {
              return lastWidget;
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
          itemCount: count),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String txt;
  final bool isActive;
  final bool isFlip;
  final VoidCallbackArg<bool> onTap;
  const CategoryItem({
    super.key,
    required this.txt,
    required this.isActive,
    required this.onTap,
    this.isFlip = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isActive && !isFlip) {
          return;
        }
        onTap(!isActive);
      },
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: White,
            borderRadius: defaultBorderRadius,
            border: isActive ? mainHighBorder : categoryBorder,
          ),
          child: Row(
            children: [
              Text(
                txt,
                style:
                    isActive ? headStyleMediumHigh : headStyleMediumNormalLight,
              ),
              if (isActive && isFlip) ...[
                SizedBox(
                  width: 10,
                ),
                LoadSvg(
                    color: TableHighColor, assetPath: 'svg/close_circle.svg')
              ],
            ],
          ),
        ),
      ),
    );
  }
}
