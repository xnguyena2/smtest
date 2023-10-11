import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class ModalBase extends StatelessWidget {
  final Widget child;
  final String headerTxt;
  const ModalBase({
    super.key,
    required this.child,
    required this.headerTxt,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: BackgroundColorLigh,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      headerTxt,
                      style: headStyleLargeHigh,
                    ),
                  ],
                ),
                Positioned(
                  right: 10,
                  child: LoadSvg(
                    assetPath: 'svg/close.svg',
                  ),
                ),
              ],
            ),
            child,
          ],
        ),
      ),
    );
  }
}
