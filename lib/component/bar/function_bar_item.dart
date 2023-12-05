import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class FunctionItem extends StatelessWidget {
  final String icon;
  final String title;
  final Widget? iconSvg;
  final VoidCallback? onTap;
  const FunctionItem({
    super.key,
    required this.icon,
    required this.title,
    this.iconSvg,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          iconSvg ?? LoadSvg(assetPath: icon),
          Text(
            title,
            style: subInfoStyMedium400Light,
          )
        ],
      ),
    );
  }
}
