import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sales_management/api/http.dart';
import 'package:sales_management/api/model/package_data_response.dart';
import 'package:sales_management/api/model/user_info_query.dart';

Future<ListPackageDetailResult> getAllPackage(String groupID) async {
  final request = UserInfoQuery(
    page: 0,
    size: 1000,
    id: '',
    group_id: groupID,
  );

  final response = await postC('/package/getbygroup', request);

  print(response.statusCode);
  if (response.statusCode == 200) {
    debugPrint(response.body, wrapWidth: 1024);
    return ListPackageDetailResult.fromJson(
      {"list_result": jsonDecode(utf8.decode(response.bodyBytes))},
    );
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}
