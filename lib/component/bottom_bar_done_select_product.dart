import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class BottomBarDoneSelectProduct extends StatelessWidget {
  const BottomBarDoneSelectProduct({
    super.key,
    required this.done,
    required this.numItem,
    required this.totalPriceFormat,
  });

  final int numItem;
  final VoidCallback done;
  final String totalPriceFormat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        right: 10,
        left: 10,
        bottom: max(10, MediaQuery.of(context).padding.bottom),
      ),
      decoration: const BoxDecoration(
        color: White,
        boxShadow: [wholeShadow],
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: defaultBorderRadius,
          color: TableHighColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    LoadSvg(assetPath: 'svg/cart.svg'),
                    Positioned(
                      right: -6,
                      top: -6,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Red,
                        child: Text(
                          '$numItem',
                          style: headStyleMediumWhite500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 28,
                ),
                Text(
                  '$totalPriceFormat',
                  style: customerNameBigWhite600,
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: done,
                  child: const Text(
                    'Tiếp tục',
                    style: headStyleLargeWhite,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
