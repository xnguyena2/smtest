import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_management/component/bar/bar_x_large.dart';
import 'package:sales_management/page/order_list/provider/search_provider.dart';

import '../../../component/app_search_bar.dart';
import '../../../component/header.dart';
import '../../../utils/constants.dart';
import '../../../utils/svg_loader.dart';

class OrderListBar extends BarXLarge {
  final VoidCallback onBackPressed;
  const OrderListBar({
    super.key,
    required this.onBackPressed,
  });

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
          onChanged: (txt) {
            context.read<SearchProvider>().updateValue = txt;
          },
        ),
        onBackPressed: onBackPressed,
      ),
    );
  }
}
