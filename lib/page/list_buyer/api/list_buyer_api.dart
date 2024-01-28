import 'dart:convert';

import 'package:sales_management/api/http.dart';
import 'package:sales_management/page/list_buyer/api/model/list_buyer.dart';
import 'package:sales_management/page/product_selector/api/model/search_query.dart';
import 'package:sales_management/utils/constants.dart';

Future<ListBuyerDataResult> getAllBuyer() async {
  final request = SearchQuery(
    query: '',
    page: 0,
    size: 1000,
    filter: 'default',
    group_id: groupID,
  );
  final response = await postC('/buyer/admin/getall', request);

  print(response.statusCode);
  if (response.statusCode == 200) {
    // debugPrint(response.body, wrapWidth: 1024);
    // print(response.body);
    return ListBuyerDataResult.fromJson(
      {"list_result": jsonDecode(utf8.decode(response.bodyBytes))},
    );
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}
