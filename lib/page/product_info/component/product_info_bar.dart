import 'package:flutter/material.dart';
import 'package:sales_management/component/header.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class ProductInfoBar extends StatelessWidget implements PreferredSizeWidget {
  const ProductInfoBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: White,
      child: Header(
        title: 'Tạo sản phẩm',
        funcWidget: SizedBox(),
        extendsWidget: SizedBox(),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(47);
}
