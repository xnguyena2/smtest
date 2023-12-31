import 'package:flutter/material.dart';

import '../../../component/header.dart';
import '../../../utils/constants.dart';
import '../../../utils/svg_loader.dart';

class CreateOrderBar extends StatelessWidget implements PreferredSizeWidget {
  const CreateOrderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: White, boxShadow: [defaultShadow]),
      child: Header(
        title: 'Chi tiết đơn',
        funcWidget: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
          child: Row(
            children: [
              FunctionItem(
                icon: 'svg/edit_clipboard.svg',
                title: 'Sửa',
              ),
              const SizedBox(
                width: 20,
              ),
              FunctionItem(
                icon: 'svg/copy.svg',
                title: 'Copy',
              ),
              const SizedBox(
                width: 20,
              ),
              FunctionItem(
                icon: 'svg/order_cancel.svg',
                title: 'Trả/Hủy',
              ),
              const SizedBox(
                width: 20,
              ),
              FunctionItem(
                icon: 'svg/print.svg',
                title: 'In hóa đơn',
              ),
            ],
          ),
        ),
        extendsWidget: SizedBox(),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(64);
}

class FunctionItem extends StatelessWidget {
  final String icon;
  final String title;
  const FunctionItem({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LoadSvg(assetPath: icon),
        Text(
          title,
          style: subInfoStyMedium400Light,
        )
      ],
    );
  }
}
