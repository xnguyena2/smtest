import 'dart:convert';

import 'package:sales_management/api/http.dart';
import 'package:sales_management/page/create_store/api/model/store.dart';

Future<String> deleteStore() async {
  final response = await postC('/auth/account/markdelete', {});

  print(response.statusCode);
  if (response.statusCode == 200) {
    // debugPrint(response.body, wrapWidth: 1024);
    // return ResponseResult.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    // print(response.body);
    return utf8.decode(response.bodyBytes);
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}

Future<String> updateStore(Store store) async {
  final request = store;
  final response = await postC('/store/update', request);

  print(response.statusCode);
  if (response.statusCode == 200) {
    // debugPrint(response.body, wrapWidth: 1024);
    // return ResponseResult.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    print(response.body);
    return utf8.decode(response.bodyBytes);
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}
