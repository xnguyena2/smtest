import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:sales_management/api/http.dart';
import 'package:sales_management/page/create_store/api/model/store_init_data.dart';
import 'package:sales_management/page/create_store/api/model/update_password.dart';
import 'package:sales_management/page/create_store/api/model/user.dart';

Future<User> createAccount(UpdatePassword userInfo) async {
  String passEncoded =
      md5.convert(utf8.encode(userInfo.newpassword)).toString().toUpperCase();
  userInfo.newpassword = passEncoded;
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

Future<int> createAccountAndStore(StoreInitData storeInitData) async {
  String passEncoded = md5
      .convert(utf8.encode(storeInitData.newAccount.newpassword))
      .toString()
      .toUpperCase();
  storeInitData.newAccount.newpassword = passEncoded;
  final response = await postE('/store/initial', storeInitData);

  print(response.statusCode);
  if (response.statusCode == 200) {
    // debugPrint(response.body, wrapWidth: 1024);
    print(response.body);
    return response.statusCode;
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}
