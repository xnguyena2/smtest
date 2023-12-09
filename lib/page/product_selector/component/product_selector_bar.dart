import 'package:flutter/material.dart';
import 'package:sales_management/component/bar/bar_x_large.dart';
import 'package:sales_management/utils/typedef.dart';

import '../../../component/header.dart';
import '../../../component/app_search_bar.dart';
import '../../../utils/constants.dart';

class ProductSelectorBar extends BarXLarge {
  final VoidCallback onBackPressed;
  final VoidCallbackArg<String>? onChanged;
  const ProductSelectorBar(
      {super.key, required this.onBackPressed, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(color: White, boxShadow: [defaultShadow]),
      child: Header(
        onBackPressed: onBackPressed,
        title: 'Bán hàng',
        funcWidget: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
          child: Row(
            children: [
              // LoadSvg(assetPath: 'svg/sort_by.svg'),
              // const SizedBox(
              //   width: 20,
              // ),
              // LoadSvg(assetPath: 'svg/grid.svg'),
              // const SizedBox(
              //   width: 20,
              // ),
              // LoadSvg(assetPath: 'svg/grid_left_panel.svg'),
              // const SizedBox(
              //   width: 20,
              // ),
              // LoadSvg(assetPath: 'svg/list_ul.svg'),
              // const SizedBox(
              //   width: 20,
              // ),
              // LoadSvg(
              //   assetPath: 'svg/order.svg',
              //   width: 27,
              //   height: 27,
              //   color: Black,
              // ),
            ],
          ),
        ),
        extendsWidget: AppSearchBar(
          onChanged: onChanged,
          hint: 'Tìm theo tên, code, ...',
        ),
      ),
    );
  }
}
