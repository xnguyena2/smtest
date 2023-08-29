import 'package:flutter/material.dart';

import '../utils/constants.dart';

class TextRound extends StatelessWidget {
  final String txt;
  final bool isHigh;
  const TextRound({
    super.key,
    required this.txt,
    required this.isHigh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: isHigh ? BackgroundHigh : BackgroundRed,
        borderRadius: defaultBorderRadius,
      ),
      child: Text(
        txt,
        style: isHigh ? headStyleMediumHigh500 : headStyleMediumAlert500,
      ),
    );
  }
}
