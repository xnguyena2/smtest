import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget LoadSvg(
    {required String assetPath,
    double? width,
    double? height,
    ColorFilter? colorFilter}) {
  return SvgPicture.asset(
    assetPath,
    width: width,
    height: height,
    colorFilter: colorFilter,
  );
}
