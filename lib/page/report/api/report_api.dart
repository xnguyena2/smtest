import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sales_management/api/http.dart';
import 'package:sales_management/page/order_list/api/model/package_id.dart';
import 'package:sales_management/page/report/api/list_date_benefit.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/utils.dart';

Future<ListDateBenifitDataResult> getReportOfCurrentMonthByDate() async {
  String from = getFirstDateTimeOfCurrentMonth();
  String to = getCurrentDateTimeNow();
  final request =
      PackageID.currentMonth(groupID, from: from, to: to, status: 'DONE');

  print(request.toJson());

  final response =
      await postC('/packageorderstatistic/admin/getbyproductid', request);

  print(response.statusCode);
  if (response.statusCode == 200) {
    debugPrint(response.body, wrapWidth: 1024);
    final result = ListDateBenifitDataResult.fromJson(
      {"list_result": jsonDecode(utf8.decode(response.bodyBytes))},
    );
    result.fillAllEmpty(from, to);
    return result;
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}
