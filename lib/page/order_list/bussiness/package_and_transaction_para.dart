import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/page/transaction/api/model/payment_transaction.dart';

class PackageAndTransactionPara {
  late final PackageDataResponse packageDataResponse;
  late final PaymentTransaction? transation;
  PackageAndTransactionPara(
      {required this.packageDataResponse, required this.transation});
  PackageAndTransactionPara.fromJson(Map<String, dynamic> json) {
    packageDataResponse =
        PackageDataResponse.fromJson(json['packageDataResponse']);
    final tranJson = json['transation'];
    transation =
        tranJson == null ? null : PaymentTransaction.fromJson(tranJson);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['packageDataResponse'] = packageDataResponse.toJson();
    _data['transation'] = transation?.toJson();
    return _data;
  }
}
