import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sales_management/api/http.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/api/model/package/product_package.dart';
import 'package:sales_management/api/model/response_result.dart';
import 'package:sales_management/api/model/user_info_query.dart';
import 'package:sales_management/page/order_list/api/model/package_id.dart';

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
    // debugPrint(response.body, wrapWidth: 1024);
    return ListPackageDetailResult.fromJson(
      {"list_result": jsonDecode(utf8.decode(response.bodyBytes))},
    );
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}

Future<PackageDataResponse> getPackage(PackageID packageID) async {
  final request = packageID;

  final response = await postC('/package/getbyjustid', request);

  print(response.statusCode);
  if (response.statusCode == 200) {
    // debugPrint(response.body, wrapWidth: 1024);
    return PackageDataResponse.fromJson(
      jsonDecode(utf8.decode(response.bodyBytes)),
    );
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}

Future<ResponseResult> updatePackage(ProductPackage productPackage) async {
  final request = productPackage;
  // print(request.toJson());

  final response = await postC('/package/updatenotcheck', request);

  print(response.statusCode);
  if (response.statusCode == 200) {
    debugPrint(response.body, wrapWidth: 1024);
    return ResponseResult.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}

Future<ResponseResult> deletePackage(PackageID packageID) async {
  final request = packageID;
  // print(request.toJson());

  final response = await postC('/package/delete', request);

  print(response.statusCode);
  if (response.statusCode == 200) {
    debugPrint(response.body, wrapWidth: 1024);
    return ResponseResult.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}
