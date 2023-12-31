import 'package:flutter/material.dart';
import 'package:sales_management/component/bar/bar_small.dart';

import '../../../component/header.dart';
import '../../../utils/constants.dart';

class AddressSelectBar extends BarSmall {
  final VoidCallback onBackPressed;
  const AddressSelectBar({super.key, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
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
