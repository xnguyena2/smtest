import 'package:flutter/material.dart';

Widget loadImg(String path) {
  return Image.asset(
    path,
    filterQuality: FilterQuality.high,
  );
}
