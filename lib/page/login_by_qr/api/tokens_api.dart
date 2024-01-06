import 'dart:convert';

import 'package:sales_management/api/http.dart';
import 'package:sales_management/page/account/api/model/token.dart';
import 'package:sales_management/page/login_by_qr/api/list_tokens_result.dart';
import 'package:sales_management/page/product_info/api/model/id_container.dart';
import 'package:sales_management/page/product_selector/api/model/search_query.dart';
import 'package:sales_management/utils/constants.dart';

Future<ListTokensResult> getAllTokens() async {
  final request = SearchQuery(
    query: 'empty',
    page: 0,
    size: 10000,
    filter: 'empty',
    group_id: groupID,
  );
  final response = await postC('/token/getall/${groupID}', request);

  print(response.statusCode);
  if (response.statusCode == 200) {
    // debugPrint(response.body, wrapWidth: 1024);
    print(response.body);
    return ListTokensResult.fromJson(
      {"list_result": jsonDecode(utf8.decode(response.bodyBytes))},
    );
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}

Future<Token> createToken(String id) async {
  final request = IDContainer(id: id, groupId: groupID);

  final response = await postC('/token/create', request);

  print(response.statusCode);
  if (response.statusCode == 200) {
    // debugPrint(response.body, wrapWidth: 1024);
    print(response.body);
    return Token.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}
