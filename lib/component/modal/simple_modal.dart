import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

Future<T?> showDefaultModal<T>(
    {required BuildContext context, required Widget content}) {
  return showModalBottomSheet<T>(
    context: context,
    builder: (BuildContext context) {
      return Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -10,
              child: LoadSvg(
                  assetPath: 'svg/close_navigator.svg', color: BackgroundColor),
            ),
            content
          ]);
    },
  );
}
