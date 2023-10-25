import 'package:flutter/material.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

Future<T?> showDefaultModal<T>(
    {required BuildContext context, required Widget content}) {
  return showModalBottomSheet<T>(
    isScrollControlled: true,
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
            Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: content,
            )
          ]);
    },
  );
}
