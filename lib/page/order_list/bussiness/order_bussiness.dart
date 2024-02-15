import 'package:sales_management/api/local_storage/local_storage.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/api/model/package/product_package.dart';
import 'package:sales_management/api/model/response_result.dart';
import 'package:sales_management/page/order_list/api/model/package_id.dart';
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

Future<ResponseResult> returnOrder(PackageID packageID) {
  return returnPackage(
    packageID,
  ).then((value) {
    refreshBootStrap();
    return value;
  });
}

List<PackageDataResponse> getAllPendingOrderPackage() {
  final listOrder = LocalStorage.getOrderPakage();
  listOrder.forEach((element) {
    element.fillData(isLocal: true);
  });
  return listOrder;
}
