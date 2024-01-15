import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sales_management/api/http.dart';
import 'package:sales_management/page/order_list/api/model/package_id.dart';
import 'package:sales_management/page/report/api/list_buyer_benefit.dart';
import 'package:sales_management/page/report/api/list_date_benefit.dart';
import 'package:sales_management/page/report/api/list_hour_benefit.dart';
import 'package:sales_management/page/report/api/list_order_benefit.dart';
import 'package:sales_management/page/report/api/list_product_benefit.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/utils.dart';

Future<ListDateBenifitDataResult> getReportOfCurrentMonthByDate(
    {String? start, String? end, bool fillAll = true}) async {
  String from = start ?? getFirstDateTimeOfCurrentMonth();
  String to = end ?? getCurrentDateTimeNow();
  final request =
      PackageID.currentMonth(groupID, from: from, to: to, status: 'DONE');

  // print(request.toJson());

  final response =
      await postC('/packageorderstatistic/admin/getbyproductid', request);

  print(response.statusCode);
  if (response.statusCode == 200) {
    // debugPrint(response.body, wrapWidth: 1024);
    final result = ListDateBenifitDataResult.fromJson(
      {"list_result": jsonDecode(utf8.decode(response.bodyBytes))},
    );
    if (fillAll) {
      result.fillAllEmpty(from, to, false);
    }
    return result;
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}

Future<ListHourBenifitDataResult> getReportOfToDay(
    {String? start, String? end, bool fillAll = true}) async {
  String from = start ?? getFirstDateTimeOfCurrentMonth();
  String to = end ?? getCurrentDateTimeNow();
  final request =
      PackageID.currentMonth(groupID, from: from, to: to, status: 'DONE');

  // print(request.toJson());

  final response =
      await postC('/packageorderstatistic/admin/getbyhour', request);

  print(response.statusCode);
  if (response.statusCode == 200) {
    debugPrint(response.body, wrapWidth: 1024);
    final result = ListHourBenifitDataResult.fromJson(
      {"list_result": jsonDecode(utf8.decode(response.bodyBytes))},
    );
    if (fillAll) {
      result.fillAllEmpty(from, to, false);
    }
    return result;
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}

Future<ListProductBenifitDataResult> getReportOfProduct(
    {String? start, String? end}) async {
  String from = start ?? getFirstDateTimeOfCurrentMonth();
  String to = end ?? getCurrentDateTimeNow();
  final request =
      PackageID.currentMonth(groupID, from: from, to: to, status: 'CREATE');

  // print(request.toJson());

  final response = await postC('/packageorderstatistic/admin/product', request);

  print(response.statusCode);
  if (response.statusCode == 200) {
    // debugPrint(response.body, wrapWidth: 1024);
    final result = ListProductBenifitDataResult.fromJson(
      {"list_result": jsonDecode(utf8.decode(response.bodyBytes))},
    );
    return result;
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}

Future<ListBuyerBenifitDataResult> getReportOfBuyer(
    {String? start, String? end}) async {
  String from = start ?? getFirstDateTimeOfCurrentMonth();
  String to = end ?? getCurrentDateTimeNow();
  final request =
      PackageID.currentMonth(groupID, from: from, to: to, status: 'DONE');

  // print(request.toJson());

  final response = await postC('/packageorderstatistic/admin/buyer', request);

  print(response.statusCode);
  if (response.statusCode == 200) {
    debugPrint(response.body, wrapWidth: 1024);
    final result = ListBuyerBenifitDataResult.fromJson(
      {"list_result": jsonDecode(utf8.decode(response.bodyBytes))},
    );
    return result;
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}

Future<ListBuyerBenifitDataResult> getReportOfStaff(
    {String? start, String? end}) async {
  String from = start ?? getFirstDateTimeOfCurrentMonth();
  String to = end ?? getCurrentDateTimeNow();
  final request =
      PackageID.currentMonth(groupID, from: from, to: to, status: 'DONE');

  // print(request.toJson());

  final response = await postC('/packageorderstatistic/admin/staff', request);

  print(response.statusCode);
  if (response.statusCode == 200) {
    debugPrint(response.body, wrapWidth: 1024);
    final result = ListBuyerBenifitDataResult.fromJson(
      {"list_result": jsonDecode(utf8.decode(response.bodyBytes))},
    );
    return result;
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}

Future<ListOrderBenifitDataResult> getReportOfOrder(
    {String? start, String? end}) async {
  String from = start ?? getFirstDateTimeOfCurrentMonth();
  String to = end ?? getCurrentDateTimeNow();
  final request =
      PackageID.currentMonth(groupID, from: from, to: to, status: 'DONE');

  // print(request.toJson());

  final response = await postC('/packageorderstatistic/admin/order', request);

  print(response.statusCode);
  if (response.statusCode == 200) {
    debugPrint(response.body, wrapWidth: 1024);
    final result = ListOrderBenifitDataResult.fromJson(
      {"list_result": jsonDecode(utf8.decode(response.bodyBytes))},
    );
    return result;
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}
