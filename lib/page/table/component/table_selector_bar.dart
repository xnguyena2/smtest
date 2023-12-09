import 'package:flutter/material.dart';
import 'package:sales_management/component/bar/bar_large.dart';
import 'package:sales_management/component/bar/function_bar_item.dart';

import '../../../component/header.dart';
import '../../../utils/constants.dart';
import '../../../utils/svg_loader.dart';

class TableSelectorBar extends BarLarge {
  final bool onEditting;
  final VoidCallback onBackPressed;
  final VoidCallback onEdit;
  const TableSelectorBar(
      {super.key,
      required this.onBackPressed,
      required this.onEditting,
      required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(color: White, boxShadow: [defaultShadow]),
      child: Header(
        title: onEditting ? 'Cài đặt bàn' : 'Quản lý bàn',
        funcWidget: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
          child: Row(
            children: [
              if (!onEditting) ...[
                FunctionItem(
                  icon: 'svg/edit_clipboard.svg',
                  title: 'Sửa',
                  onTap: onEdit,
                ),
                // const SizedBox(
                //   width: 20,
                // ),
                // FunctionItem(
                //   icon: '',
                //   iconSvg: LoadSvg(
                //     assetPath: 'svg/order.svg',
                //     width: 27,
                //     height: 27,
                //     color: Black,
                //   ),
                //   title: 'Đơn hàng',
                // ),
              ]
            ],
          ),
        ),
        extendsWidget: null,
        onBackPressed: onBackPressed,
      ),
    );
  }
}
