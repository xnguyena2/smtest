import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';

class HomePageBottomBar extends StatelessWidget {
  final VoidCallbackArg<int> onPageSelected;
  final VoidCallback onPlustClicked;
  const HomePageBottomBar({
    super.key,
    required this.onPageSelected,
    required this.onPlustClicked,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      height: 46 + bottomPadding,
      padding: EdgeInsets.only(bottom: bottomPadding),
      decoration: const BoxDecoration(color: White, boxShadow: [wholeShadow]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              onPageSelected(1);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadSvg(assetPath: 'svg/home_bar.svg'),
                const Text(
                  'Quản lý',
                  style: subInfoStySmall,
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              onPlustClicked();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadSvg(assetPath: 'svg/plus_bar.svg'),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              onPageSelected(2);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadSvg(assetPath: 'svg/in_out_bar.svg'),
                const Text(
                  'Thu chi',
                  style: subInfoStySmall,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
