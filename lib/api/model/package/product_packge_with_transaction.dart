import 'package:sales_management/api/model/package/product_package.dart';
import 'package:sales_management/page/transaction/api/model/payment_transaction.dart';

class ProductPackgeWithTransaction {
  late final ProductPackage productPackage;
  late final PaymentTransaction transation;
  ProductPackgeWithTransaction(
      {required this.productPackage, required this.transation});
  ProductPackgeWithTransaction.fromJson(Map<String, dynamic> json) {
    productPackage = ProductPackage.fromJson(json['productPackage']);
    transation = PaymentTransaction.fromJson(json['transation']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['productPackage'] = productPackage.toJson();
    _data['transation'] = transation.toJson();
    return _data;
  }
}
