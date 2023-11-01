import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sales_management/api/token.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/img_compress.dart';
import 'package:sales_management/utils/typedef.dart';

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

Future<int> uploadFile(String path, XFile photo,
    {VoidCallbackArg<int>? onUploadProgress}) async {
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

  int byteCount = 0;

  var totalByteLength = request.contentLength;
  var msStream = request.finalize();
  Stream<List<int>> streamUpload = msStream.transform(
    StreamTransformer.fromHandlers(
      handleData: (data, sink) {
        sink.add(data);

        byteCount += data.length;

        onUploadProgress?.call((100 * byteCount / totalByteLength).round());
      },
      handleError: (error, stack, sink) {
        throw error;
      },
      handleDone: (sink) {
        sink.close();
        print('done stream!');
        // UPLOAD DONE;
      },
    ),
  );

  final httpClient = HttpClient();

  final post_request = await httpClient.postUrl(
    Uri.parse('$host$path'),
  );

  post_request.contentLength = totalByteLength;

  post_request.headers.set(HttpHeaders.contentTypeHeader,
      request.headers[HttpHeaders.contentTypeHeader]!);
  post_request.headers.set(HttpHeaders.cookieHeader, '$CookiePrefix=$token');

  await post_request.addStream(streamUpload);

  final httpResponse = await post_request.close();

  var statusCode = httpResponse.statusCode;

  print("This is response:" + statusCode.toString());
  return statusCode;
}
