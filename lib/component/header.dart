import 'package:flutter/material.dart';
import 'package:sales_management/utils/svg_loader.dart';

import '../utils/constants.dart';

class Header extends StatelessWidget {
  final String title;
  const Header({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HeaderTitle(title: title),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    LoadSvg(assetPath: 'svg/sort_by.svg'),
                    SizedBox(
                      width: 20,
                    ),
                    LoadSvg(assetPath: 'svg/grid.svg'),
                    SizedBox(
                      width: 20,
                    ),
                    LoadSvg(assetPath: 'svg/grid_left_panel.svg'),
                    SizedBox(
                      width: 20,
                    ),
                    LoadSvg(assetPath: 'svg/list_ul.svg'),
                    SizedBox(
                      width: 20,
                    ),
                    LoadSvg(
                        assetPath: 'svg/order.svg',
                        width: 27,
                        height: 27,
                        colorFilter: const ColorFilter.mode(
                          Black,
                          BlendMode.srcIn,
                        )),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class HeaderTitle extends StatelessWidget {
  final String title;
  const HeaderTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 47,
      child: Row(
        children: [
          LoadSvg(assetPath: 'svg/back.svg'),
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
