import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<Uint8List> comporessList(Uint8List list) async {
  final Uint8List result = await FlutterImageCompress.compressWithList(
    list,
    quality: 90,
  );
  print(
      'origin length: ${list.length}, after compress length: ${result.length}');
  return result;
}
