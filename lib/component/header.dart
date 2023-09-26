import 'package:flutter/material.dart';
import 'package:sales_management/utils/svg_loader.dart';

import '../utils/constants.dart';

class Header extends StatelessWidget {
  final String title;
  final Widget funcWidget;
  final Widget extendsWidget;
  final VoidCallback? onBackPressed;
  const Header(
      {super.key,
      required this.title,
      required this.funcWidget,
      required this.extendsWidget,
      this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HeaderTitle(
                title: title,
                onBackPressed: onBackPressed,
              ),
              funcWidget
            ],
          ),
          Expanded(child: extendsWidget)
        ],
      ),
    );
  }
}

class HeaderTitle extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final String title;
  const HeaderTitle({
    super.key,
    required this.title,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 47,
      child: Row(
        children: [
          GestureDetector(
              onTap: onBackPressed, child: LoadSvg(assetPath: 'svg/back.svg')),
          const SizedBox(
            width: 15,
          ),
          Text(
            title,
            style: headStyleXLarge,
          ),
        ],
      ),
    );
  }
}
