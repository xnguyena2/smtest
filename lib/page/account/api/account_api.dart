import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:sales_management/api/http.dart';
import 'package:sales_management/api/token.dart';
import 'package:sales_management/page/account/api/model/authentication_request.dart';
import 'package:sales_management/page/account/api/model/token.dart';

Future<Token> signin() async {
  String passEncoded =
      md5.convert(utf8.encode('binhdiepquin123')).toString().toUpperCase();
  print(passEncoded);
  final request =
      AuthenticationRequest(password: passEncoded, username: 'binhdiepquin');

  final response = await postE('/auth/signin', request);

  if (response.statusCode == 200) {
    Token token = Token.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    setToken(token.token);
    return token;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<dynamic> me() async {
  final response = await getC('/auth/me');

  if (response.statusCode == 200) {
    print(response.body);
    return response.body;
  } else {
    throw Exception('Failed to load data');
  }
}
