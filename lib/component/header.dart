import 'package:flutter/material.dart';
import 'package:sales_management/utils/svg_loader.dart';

import '../utils/constants.dart';

class Header extends StatelessWidget {
  final String title;
  final Widget? tailHeader;
  final Widget funcWidget;
  final Widget? extendsWidget;
  final VoidCallback? onBackPressed;
  const Header(
      {super.key,
      required this.title,
      required this.funcWidget,
      required this.extendsWidget,
      this.onBackPressed,
      this.tailHeader});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  HeaderTitle(
                    title: title,
                    onBackPressed: onBackPressed,
                  ),
                  tailHeader ?? SizedBox(),
                ],
              ),
              funcWidget
            ],
          ),
          if (extendsWidget != null) Expanded(child: extendsWidget!)
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
            onTap: onBackPressed,
            child: Container(
              padding:
                  const EdgeInsets.only(left: 0, top: 0, right: 15, bottom: 0),
              decoration: const BoxDecoration(color: White),
              child: LoadSvg(assetPath: 'svg/back.svg'),
            ),
          ),
          // const SizedBox(
          //   width: 15,
          // ),
          Text(
            title,
            style: headStyleXLarge,
          ),
        ],
      ),
    );
  }
}
