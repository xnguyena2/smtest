import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../utils/svg_loader.dart';

class header extends StatelessWidget {
  final String title;
  final String titleImg;
  final Widget endChild;
  const header({
    super.key,
    required this.title,
    required this.titleImg,
    required this.endChild,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              title,
              style: headStyleLarge,
            ),
            LoadSvg(assetPath: titleImg),
          ],
        ),
        endChild,
      ],
    );
  }
}
