import 'package:flutter/material.dart';

import '../../../component/header.dart';

class ProductSelectorBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ProductSelectorBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Header(
      title: 'Bán hàng',
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(95);
}
