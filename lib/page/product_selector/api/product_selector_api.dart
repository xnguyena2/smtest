import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sales_management/api/http.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/api/model/package_result.dart';
import 'package:sales_management/api/model/package/product_package.dart';
import 'package:sales_management/api/model/response_result.dart';
import 'package:sales_management/api/model/search_result.dart';
import 'package:sales_management/api/model/user_info_query.dart';
import 'package:sales_management/page/product_selector/api/model/search_query.dart';
import 'package:sales_management/utils/constants.dart';

Future<SearchResult<BeerSubmitData>> getall() async {
  final request = SearchQuery(
    query: 'all',
    page: 0,
    size: 1000,
    filter: 'default',
    group_id: groupID,
  );

  final response = await postC('/beer/getall', request);

  print(response.statusCode);
  if (response.statusCode == 200) {
    // debugPrint(response.body, wrapWidth: 1024);
    return SearchResult<BeerSubmitData>.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}

Future<ResponseResult> addToPackage(ProductPackage productPackage) async {
  final response = await postE(
    '/package/add',
    productPackage,
  );

  if (response.statusCode == 200) {
    debugPrint(response.body);
    return ResponseResult.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load data');
  }
}

Future<PackageResult> fetchPackage(UserInfoQuery query) async {
  // query.page = 0;
  // query.size = 10000;

  final response = await postE(
    '/package/getall',
    query,
  );

  if (response.statusCode == 200) {
    print(response.body);
    return PackageResult.fromJson(
      {"list_result": jsonDecode(utf8.decode(response.bodyBytes))},
    );
  } else {
    throw Exception('Failed to load data');
  }
}
