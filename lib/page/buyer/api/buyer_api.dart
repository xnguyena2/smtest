import 'dart:convert';

import 'package:sales_management/api/http.dart';
import 'package:sales_management/api/model/package/buyer.dart';
import 'package:sales_management/page/buyer/api/model/buyer_statictis_data.dart';
import 'package:sales_management/page/order_list/api/model/package_id.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/utils.dart';

Future<BuyerStatictisData> getBuyerDetail(
    {required String buyerID, String? start, String? end}) async {
  String from = start ?? getFirstDateTimeOfCurrentMonth();
  String to = end ?? getCurrentDateTimeNow();
  final request = PackageID(
      group_id: groupID,
      page: 0,
      size: 3,
      packageSecondId: '',
      deviceId: buyerID,
      from: from,
      to: to,
      status: 'DONE');
  final response = await postC('/buyer/admin/getdetail', request);

  print(response.statusCode);
  if (response.statusCode == 200) {
    // debugPrint(response.body, wrapWidth: 1024);
    // print(response.body);
    return BuyerStatictisData.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}

Future<int> createBuyer(Buyer buyer) async {
  final request = buyer;
  final response = await postC('/buyer/create', request);

  print(response.statusCode);
  if (response.statusCode == 200) {
    // debugPrint(response.body, wrapWidth: 1024);
    // print(response.body);
    return response.statusCode;
  } else {
    // throw Exception('Failed to load data');
    return Future.error('Failed to load data!!');
  }
}
