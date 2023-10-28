import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sales_management/api/http.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';

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
