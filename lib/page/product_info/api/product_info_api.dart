import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sales_management/api/http.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/page/product_info/api/model/id_container.dart';
import 'package:sales_management/utils/typedef.dart';

Future<BeerSubmitData> createProduct(BeerSubmitData product) async {
  final request = product;
  // print(request.toJson());

  final response = await postC('/beer/admin/create', request);

  print(response.statusCode);
  if (response.statusCode == 200) {
    debugPrint(response.body, wrapWidth: 1024);
    return BeerSubmitData.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}

Future<int> deleteProduct(BeerSubmitData product) async {
  // print(request.toJson());

  final response = await deleteC(
      '/beer/admin/delete/${product.groupId}/${product.beerSecondID}', null);

  print(response.statusCode);
  if (response.statusCode == 200) {
    debugPrint(response.body, wrapWidth: 1024);
    return response.statusCode;
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}

Future<Images> uploadFile(String path, Uint8List photoBytes,
    {VoidCallbackArg<double>? onUploadProgress}) async {
  final request = await createMultiPartRequest(path, photoBytes);
  final httpResponse = await createHttpClientRequest(path, request,
      onUploadProgress: onUploadProgress);
  var statusCode = httpResponse.statusCode;

  print(statusCode);
  if (statusCode == 200) {
    String body = await readResponse(httpResponse);
    debugPrint(body, wrapWidth: 1024);
    return Images.fromJson(jsonDecode(body));
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}

Future<int> deleteImg(IDContainer img) async {
  final request = img;
  // print(request.toJson());

  final response = await postC('/beer/admin/img/delete', request);

  print(response.statusCode);
  if (response.statusCode == 200) {
    debugPrint(response.body, wrapWidth: 1024);
    return response.statusCode;
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}
