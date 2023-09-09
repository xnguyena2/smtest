import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart';
import 'package:sales_management/page/account/api/model/authentication_request.dart';
import 'package:sales_management/utils/constants.dart';

Future<dynamic> signin() async {
  final Client client = Client();
  if (client is BrowserClient) (client as BrowserClient).withCredentials = true;
  String passEncoded =
      md5.convert(utf8.encode('binhdiepquin123')).toString().toUpperCase();
  print(passEncoded);
  final request =
      AuthenticationRequest(password: passEncoded, username: 'binhdiepquin');
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final response = await post(
    Uri.parse('${host}/auth/signin'),
    body: jsonEncode(request),
    headers: headers,
  );
  print(response.body);
  String token =
      'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJiaW5oZGllcHF1aW4iLCJyb2xlcyI6IlJPTEVfUk9PVCIsImdyb3VwIjoidHJ1bWJpZW5fc3RvcmUiLCJpYXQiOjE2OTQyMzQ2MjgsImV4cCI6MTY5NDIzODIyOH0.FV5HVAg8WqSzCprLAUTvwpKIwztMSAQ-nFuIuMGyKx8';
  var cookies = [
    'Authorization:Bearer $token',
  ];

  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
    'Cookie': 'hoduongvuong66666=$token',
    'Authorization': 'Bearer $token',
  };
  get(Uri.parse('${host}/auth/me'), headers: {
    HttpHeaders.authorizationHeader: 'Bearer $token',
    HttpHeaders.hostHeader: 'product-sell.onrender.com',
  }).catchError((error) {
    print('error : $error');
  });

  if (response.statusCode == 200) {
    // print(response2.body);
    return response.body;
  } else {
    throw Exception('Failed to load data');
  }
}

final dio = Dio();
Future<dynamic> signinDio() async {
  // final cookieJar = CookieJar();
  String passEncoded =
      md5.convert(utf8.encode('binhdiepquin123')).toString().toUpperCase();
  print(passEncoded);
  final request =
      AuthenticationRequest(password: passEncoded, username: 'binhdiepquin');
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final response = await dio.post(
    '${host}/auth/signin',
    data: jsonEncode(request),
  );
  final _client = Dio()
    ..options = BaseOptions(
      headers: {
        'Content-type': 'application/json',
        'Cookie':
            'hoduongvuong66666=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJiaW5oZGllcHF1aW4iLCJyb2xlcyI6IlJPTEVfUk9PVCIsImdyb3VwIjoidHJ1bWJpZW5fc3RvcmUiLCJpYXQiOjE2OTQyMjYyOTAsImV4cCI6MTY5NDIyOTg5MH0.D4xH5tmxAGQ8MM6c3llrDBplAwznMxRICI8Izc64loM',
        HttpHeaders.authorizationHeader:
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJiaW5oZGllcHF1aW4iLCJyb2xlcyI6IlJPTEVfUk9PVCIsImdyb3VwIjoidHJ1bWJpZW5fc3RvcmUiLCJpYXQiOjE2OTQyMzQ2MjgsImV4cCI6MTY5NDIzODIyOH0.FV5HVAg8WqSzCprLAUTvwpKIwztMSAQ-nFuIuMGyKx8',
      },
    );
  // _client.interceptors.add(InterceptorsWrapper(
  //   onRequest: (options, handler) {
  //     // _client.interceptors.request.lock();
  //     options.headers["Cookie"] =
  //         'hoduongvuong66666=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJiaW5oZGllcHF1aW4iLCJyb2xlcyI6IlJPTEVfUk9PVCIsImdyb3VwIjoidHJ1bWJpZW5fc3RvcmUiLCJpYXQiOjE2OTQyMjYyOTAsImV4cCI6MTY5NDIyOTg5MH0.D4xH5tmxAGQ8MM6c3llrDBplAwznMxRICI8Izc64loM';
  //     // _client.interceptors.requestLock.unlock();
  //     print('finish set cookie');

  //     handler.next(options);
  //   },
  // ));
  // _client.interceptors.add(InterceptorsWrapper(
  //     onRequest:(Options options) async {
  //       // to prevent other request enter this interceptor.
  //       _client.interceptors.requestLock.lock();
  //       // We use a new Dio(to avoid dead lock) instance to request token.
  //       //Set the cookie to headers
  //       options.headers["cookie"] = aToken;

  //       _client.interceptors.requestLock.unlock();
  //       return options; //continue
  //     }
  // ));
  print('begin me');
  final response2 = await _client.get('${host}/auth/me',
      options: Options(
        headers: {
          'Content-type': 'application/json',
          HttpHeaders.authorizationHeader:
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJiaW5oZGllcHF1aW4iLCJyb2xlcyI6IlJPTEVfUk9PVCIsImdyb3VwIjoidHJ1bWJpZW5fc3RvcmUiLCJpYXQiOjE2OTQyMzQ2MjgsImV4cCI6MTY5NDIzODIyOH0.FV5HVAg8WqSzCprLAUTvwpKIwztMSAQ-nFuIuMGyKx8',
        },
      ));
  print('done me');

  if (response.statusCode == 200) {
    print(response.headers);
    return response.data;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<dynamic> me() async {
  var cookies = [
    'hoduongvuong66666=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJiaW5oZGllcHF1aW4iLCJyb2xlcyI6IlJPTEVfUk9PVCIsImdyb3VwIjoidHJ1bWJpZW5fc3RvcmUiLCJpYXQiOjE2OTQxNzI0ODUsImV4cCI6MTY5NDE3NjA4NX0.MZrK_XXsp7uV4GvwJ4ehkQ8jSjGI5rWFlvkzuyjCZfY',
  ];

  Map<String, String> headersMap = {
    'Cookie': cookies.join('; '),
  };
  final response = await get(
    Uri.parse('${host}/auth/me'),
    // headers: headersMap,
  );

  print('resopnsessssssssssss');
  print(response.statusCode);
  if (response.statusCode == 200) {
    print(response.body);
    return response.body;
  } else {
    throw Exception('Failed to load data');
  }
}
