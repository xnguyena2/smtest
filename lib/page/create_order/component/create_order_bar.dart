import 'package:flutter/material.dart';
import 'package:sales_management/component/bar/bar_large.dart';
import 'package:sales_management/component/bar/function_bar_item.dart';

import '../../../component/header.dart';
import '../../../utils/constants.dart';

class CreateOrderBar extends BarLarge {
  final VoidCallback onBackPressed;
  final VoidCallback? onReturn;
  const CreateOrderBar({
    super.key,
    required this.onBackPressed,
    required this.onReturn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(color: White, boxShadow: [defaultShadow]),
      child: Header(
        title: 'Chi tiết đơn',
        funcWidget: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
          child: Row(
            children: [
              // FunctionItem(
              //   icon: 'svg/edit_clipboard.svg',
              //   title: 'Sửa',
              // ),
              // const SizedBox(
              //   width: 20,
              // ),
              // FunctionItem(
              //   icon: 'svg/copy.svg',
              //   title: 'Copy',
              // ),
              // const SizedBox(
              //   width: 20,
              // ),
              if (onReturn != null)
                FunctionItem(
                  icon: 'svg/order_cancel.svg',
                  title: 'Trả/Hủy',
                  onTap: onReturn,
                ),
              // const SizedBox(
              //   width: 20,
              // ),
              // FunctionItem(
              //   icon: 'svg/print.svg',
              //   title: 'In hóa đơn',
              // ),
            ],
          ),
        ),
        extendsWidget: SizedBox(),
        onBackPressed: onBackPressed,
      ),
    );
  }
}
