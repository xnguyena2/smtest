import 'dart:convert';

import 'package:http/http.dart';
import 'package:sales_management/api/token.dart';
import 'package:sales_management/utils/constants.dart';

const String CookiePrefix = 'hoduongvuong66666';

Future<Response> postC(String path, Object? body) {
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Cookie': '$CookiePrefix=$token',
  };
  return post(
    Uri.parse('$host$path'),
    body: jsonEncode(body),
    headers: requestHeaders,
  );
}

Future<Response> postE(String path, Object? body) {
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  return post(
    Uri.parse('$host$path'),
    body: jsonEncode(body),
    headers: requestHeaders,
  );
}

Future<Response> getC(String path) {
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Cookie': '$CookiePrefix=$token',
  };
  print(token);
  return get(
    Uri.parse('$host$path'),
    headers: requestHeaders,
  );
}
