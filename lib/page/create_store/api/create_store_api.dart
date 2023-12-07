import 'dart:convert';

import 'package:sales_management/api/http.dart';
import 'package:sales_management/page/create_store/api/model/update_password.dart';
import 'package:sales_management/page/create_store/api/model/user.dart';

Future<User> createAccount(UpdatePassword userInfo) async {
  final response = await postE('/auth/account/create', userInfo);

  print(response.statusCode);
  if (response.statusCode == 200) {
    // debugPrint(response.body, wrapWidth: 1024);
    print(response.body);
    return User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}
