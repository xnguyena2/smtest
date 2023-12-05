import 'package:flutter/material.dart';
import 'package:sales_management/component/bar/bar_large.dart';

import '../../../component/header.dart';
import '../../../utils/constants.dart';

class AddressSelectBar extends BarLarge {
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
}
