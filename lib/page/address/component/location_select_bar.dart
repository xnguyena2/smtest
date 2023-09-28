import 'package:flutter/material.dart';

import '../../../component/header.dart';
import '../../../utils/constants.dart';
import '../../../utils/svg_loader.dart';

class AddressSelectBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackPressed;
  const AddressSelectBar({super.key, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: White, boxShadow: [defaultShadow]),
      child: Header(
        title: 'Nhập địa chỉ',
        funcWidget: SizedBox(),
        extendsWidget: SizedBox(),
        onBackPressed: onBackPressed,
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
