import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/svg_loader.dart';

class AppSearchBar extends StatelessWidget {
  final String hint;
  const AppSearchBar({
    super.key,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: searchBackgroundColor,
        borderRadius: defaultBorderRadius,
        border: defaultBorder,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 25,
          ),
          LoadSvg(assetPath: 'svg/search.svg'),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextField(
              maxLines: 1,
              style: headStyleSemiLarge,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                isDense: true,
                border: InputBorder.none,
                hintText: hint,
              ),
            ),
          ),
          LoadSvg(assetPath: 'svg/close_circle.svg'),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
