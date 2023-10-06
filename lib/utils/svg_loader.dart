import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

bool get isMobile {
  if (kIsWeb) {
    return false;
  } else {
    return Platform.isIOS || Platform.isAndroid;
  }
}

Widget LoadSvg(
    {required String assetPath, double? width, double? height, Color? color}) {
  return SvgPicture.asset(
    '${isMobile ? 'assets/' : ''}$assetPath',
    width: width,
    height: height,
    colorFilter:
        color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
  );
}
