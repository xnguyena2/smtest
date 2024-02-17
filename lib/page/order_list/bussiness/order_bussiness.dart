import 'package:sales_management/api/local_storage/local_storage.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/api/model/package/product_package.dart';
import 'package:sales_management/api/model/package/product_packge_with_transaction.dart';
import 'package:sales_management/api/model/response_result.dart';
import 'package:sales_management/page/order_list/api/model/package_id.dart';
import 'package:sales_management/page/order_list/api/order_list_api.dart';
import 'package:sales_management/page/transaction/api/model/payment_transaction.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/helper.dart';

Future<void> _storage_updatePackageWithTransactions(
    PackageDataResponse packageDataResponse,
    {PaymentTransaction? paymentTransaction}) {
  final productWithPackge =
      ProductPackage.fromPackageDataResponse(packageDataResponse);
  if (paymentTransaction == null) {
    final body = bodyEncode(productWithPackge);
    return LocalStorage.addRequest(RequestType.POST_C, 'updatePackage',
        packageDataResponse.packageSecondId, body);
  }
  final body = bodyEncode(ProductPackgeWithTransaction(
      productPackage: productWithPackge, transation: paymentTransaction));
  return LocalStorage.addRequest(
      RequestType.POST_C,
      'updatePackageWithTransaction',
      packageDataResponse.packageSecondId,
      body);
}

Future<ResponseResult> _updatePackageWithTransactions(
    PackageDataResponse packageDataResponse,
    {PaymentTransaction? paymentTransaction}) {
  packageDataResponse.runPendingAction();
  final productWithPackge =
      ProductPackage.fromPackageDataResponse(packageDataResponse);
  if (paymentTransaction == null) {
    return updatePackage(productWithPackge);
  }
  return updatePackageWithTransaction(ProductPackgeWithTransaction(
      productPackage: productWithPackge, transation: paymentTransaction));
}

Future<PackageDataResponse> _sendOrStoreOrderWithTransaction(
    PackageDataResponse packageDataResponse,
    {PaymentTransaction? paymentTransaction}) {
  if (haveInteret) {
    return _updatePackageWithTransactions(packageDataResponse,
            paymentTransaction: paymentTransaction)
        .then((value) {
      return packageDataResponse;
    });
  }
  return _storage_updatePackageWithTransactions(packageDataResponse,
          paymentTransaction: paymentTransaction)
      .then(
    (value) => LocalStorage.putOrderPakage(packageDataResponse).then(
      (value) {
        packageDataResponse.swithLocalStatus(true);
        return packageDataResponse;
      },
    ),
  );
}

Future<PackageDataResponse> prePayOrder(
    PackageDataResponse packageDataResponse, double value, bool isTempOrder) {
  if (!haveInteret && !isTempOrder) {
    return Future.error('Yêu cầu internet mới thực hiện được!');
  }
  final paymentTransaction = packageDataResponse.addtransaction(value,
      'Tiền mặt', 'Thanh toán trước đơn: ${packageDataResponse.getID}');
  return _sendOrStoreOrderWithTransaction(packageDataResponse,
          paymentTransaction: paymentTransaction)
      .onError((error, stackTrace) {
    packageDataResponse.removeLastestTransaction();
    return packageDataResponse;
  });
}

Future<PackageDataResponse> doneOrder(
    PackageDataResponse packageDataResponse, bool isTempOrder) {
  if (!haveInteret && !isTempOrder) {
    return Future.error('Yêu cầu internet mới thực hiện được!');
  }
  final transaction = packageDataResponse.makeDone();
  return _sendOrStoreOrderWithTransaction(packageDataResponse,
          paymentTransaction: transaction)
      .then(
    (value) {
      refreshBootStrap();
      return value;
    },
  );
}

Future<PackageDataResponse> cancelOrderPackage(
    PackageDataResponse packageDataResponse, bool isTempOrder) {
  if (isTempOrder) {
    packageDataResponse.markDeletedOrder();
    return Future.value(packageDataResponse);
  }
  if (!haveInteret) {
    return Future.error('Yêu cầu internet mới thực hiện được!');
  }
  PackageID packageID = PackageID.fromPackageDataResponse(packageDataResponse);
  return cancelPackage(packageID).then((value) {
    packageDataResponse.markDeletedOrder();
    return packageDataResponse;
  });
}

Future<PackageDataResponse> updateOrderPackage(
    PackageDataResponse packageDataResponse, bool isTempOrder) {
  if (!haveInteret && !isTempOrder) {
    return Future.error('Yêu cầu internet mới thực hiện được!');
  }
  return _sendOrStoreOrderWithTransaction(packageDataResponse);
}

Future<ResponseResult> returnOrder(
    PackageDataResponse packageDataResponse, bool isTempOrder) {
  if (!haveInteret && !isTempOrder) {
    return Future.error('Yêu cầu internet mới thực hiện được!');
  }
  PackageID packageID = PackageID.fromPackageDataResponse(packageDataResponse);
  return returnPackage(
    packageID,
  ).then((value) {
    refreshBootStrap();
    return value;
  });
}

Future<bool> removeLocalOrder(PackageDataResponse packageDataResponse) {
  return LocalStorage.removeOrderPakage(packageDataResponse);
}

List<PackageDataResponse> getAllPendingOrderPackage() {
  final listOrder = LocalStorage.getOrderPakage();
  listOrder.forEach((element) {
    element.fillData(isLocal: true);
  });
  return listOrder;
}

Map<String, RequestStorage> getAllPendingOrderPackageRequest() {
  final listOrder = LocalStorage.getRequest();
  return Map.fromEntries(listOrder.map(
    (e) => MapEntry(e.id, e),
  ));
}

Future<ListPackageDetailResult> getAllWorkingOrderPackge(String groupID,
    {int id = 0, int page = 0, int size = 1000}) {
  if (haveInteret) {
    return getAllWorkingPackage(groupID, id: id, size: 10);
  }
  return Future.value(ListPackageDetailResult(listResult: []));
}
