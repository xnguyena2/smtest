import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../utils/svg_loader.dart';

class NavigationNext extends StatelessWidget {
  final String title;
  final String assetPath;
  const NavigationNext({
    super.key,
    required this.title,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LoadSvg(assetPath: assetPath),
        Text(
          title,
          style: headStyleMediumHigh,
        ),
        LoadSvg(assetPath: 'svg/navigate_next.svg'),
      ],
    );
  }
}
