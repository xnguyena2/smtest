import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sales_management/api/http.dart';
import 'package:sales_management/page/order_list/api/model/package_id.dart';
import 'package:sales_management/page/transaction/api/model/list_payment_transaction.dart';
import 'package:sales_management/page/transaction/api/model/payment_transaction.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/utils.dart';

Future<String> createTransaction(PaymentTransaction transaction) async {
  print(transaction.toJson());
  final request = transaction;

  final response = await postC(
    '/transaction/create',
    request,
  );

  print(response.statusCode);
  if (response.statusCode == 200) {
    // print(response.body);
    return response.body;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<ListPaymentTransactionDataResult>
    getTransactionsReportOfCurrentMonthByDate() async {
  String from = getFirstDateTimeOfCurrentMonth();
  String to = getCurrentDateTimeNow();
  final request = PackageID.currentMonth(groupID, from: from, to: to);

  print(request.toJson());

  final response = await postC('/transaction/getbytime', request);

  print(response.statusCode);
  if (response.statusCode == 200) {
    debugPrint(response.body, wrapWidth: 1024);
    final result = ListPaymentTransactionDataResult.fromJson(
      {"list_result": jsonDecode(utf8.decode(response.bodyBytes))},
    );
    result.fillAllEmpty(from, to);
    return result;
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}
