import 'dart:convert';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sales_management/api/token.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/img_compress.dart';

const String CookiePrefix = 'hoduongvuong66666';

Future<Response> postC(String path, Object? body) {
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Cookie': '$CookiePrefix=$token',
  };
  return post(
    Uri.parse('$host$path'),
    body: jsonEncode(body),
    headers: requestHeaders,
  );
}

Future<Response> postE(String path, Object? body) {
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  return post(
    Uri.parse('$host$path'),
    body: jsonEncode(body),
    headers: requestHeaders,
  );
}

Future<Response> getC(String path) {
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Cookie': '$CookiePrefix=$token',
  };
  return get(
    Uri.parse('$host$path'),
    headers: requestHeaders,
  );
}

Future<Response> getE(String path) {
  return get(
    Uri.parse('$host$path'),
  );
}

Future<int> uploadFile(String path, XFile photo) async {
  ///MultiPart request
  var bytes = await photo.readAsBytes();

  var bytes_compressed = await comporessList(bytes);

  var request = MultipartRequest(
    'POST',
    Uri.parse('$host$path'),
  );
  Map<String, String> headers = {
    "Content-type": "multipart/form-data",
    'Cookie': '$CookiePrefix=$token',
    "Accept": "*/*",
  };
  request.files.add(
    await MultipartFile.fromBytes('file', bytes_compressed,
        filename: 'test.jpg'),
    // await MultipartFile.fromPath('file', photo.path),
  );
  request.headers.addAll(headers);

  /// optional if require to add other fields then image

  print("request: " + request.toString());
  var res = await request.send();
  print("This is response:" + res.statusCode.toString());
  print("This is response:" + res.headers.toString());
  // res.stream.listen((value) { })
  return res.statusCode;
}
