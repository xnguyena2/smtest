import 'package:sales_management/api/model/package/product_package.dart';
import 'package:sales_management/api/model/response_result.dart';
import 'package:sales_management/page/order_list/api/order_list_api.dart';
import 'package:sales_management/page/transaction/api/model/payment_transaction.dart';
import 'package:sales_management/utils/helper.dart';

Future<ResponseResult> doneOrder(ProductPackage productPackage,
    {PaymentTransaction? paymentTransaction}) {
  return updatePackageWithTransactions(productPackage,
          paymentTransaction: paymentTransaction)
      .then((value) {
    refreshBootStrap();
    return value;
  });
}
