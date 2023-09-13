import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sales_management/api/http.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/api/model/search_result.dart';
import 'package:sales_management/page/product_selector/api/model/search_query.dart';

Future<SearchResult<BeerSubmitData>> getall() async {
  final request = SearchQuery(
      query: 'all',
      page: 0,
      size: 1000,
      filter: 'default',
      group_id: 'trumbien_store');

  final response = await postC('/beer/admin/getall', request);

  print(response.statusCode);
  if (response.statusCode == 200) {
    debugPrint(response.body, wrapWidth: 1024);
    return SearchResult<BeerSubmitData>.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}
