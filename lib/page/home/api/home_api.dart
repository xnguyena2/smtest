import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sales_management/api/http.dart';
import 'package:sales_management/page/home/api/model/bootstrap.dart';

Future<BootStrapData> loadBootstrap(String groupID) async {
  final response = await getC('/clientdevice/bootstrapfull/${groupID}');

  print(response.statusCode);
  if (response.statusCode == 200) {
    debugPrint(response.body, wrapWidth: 1024);
    // print(response.body);
    return BootStrapData.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}

Future<int> udpateConfig(DeviceConfig deviceConfig) async {
  final request = deviceConfig;
  print(jsonEncode(request));
  final response = await postC('/deviceconfig/admin/changecolor', request);

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
