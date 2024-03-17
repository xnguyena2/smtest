import 'dart:convert';

import 'package:sales_management/api/local_storage/local_storage.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/api/model/package/product_package.dart';
import 'package:sales_management/api/model/package/product_packge_with_transaction.dart';
import 'package:sales_management/api/model/response_result.dart';
import 'package:sales_management/page/order_list/api/model/package_id.dart';
import 'package:sales_management/page/order_list/api/order_list_api.dart';
import 'package:sales_management/page/order_list/bussiness/package_and_transaction_para.dart';
import 'package:sales_management/page/transaction/api/model/payment_transaction.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/helper.dart';

const funcName = '_updatePackageWithTransactions';

Future<ResponseResult> _invokeFunc(RequestStorage request) {
  PackageAndTransactionPara productPackgeWithTransaction =
      PackageAndTransactionPara.fromJson(jsonDecode(request.body));
  return _updatePackageWithTransactions(
      productPackgeWithTransaction.packageDataResponse);
}

Future<void> _storage_updatePackageWithTransactions(
    PackageDataResponse packageDataResponse) {
  final body = bodyEncode(PackageAndTransactionPara(
      packageDataResponse: packageDataResponse, transation: null));
  return LocalStorage.addRequest(
      RequestType.POST_C, funcName, packageDataResponse.packageSecondId, body);
}

Future<ResponseResult> _updatePackageWithTransactions(
    PackageDataResponse packageDataResponse) {
  packageDataResponse.runPendingAction();
  final productWithPackge =
      ProductPackage.fromPackageDataResponse(packageDataResponse);
  return updatePackage(productWithPackge);
}

Future<PackageDataResponse> _sendOrStoreOrderWithTransaction(
    PackageDataResponse packageDataResponse) {
  if (haveInteret) {
    return _updatePackageWithTransactions(packageDataResponse).then((value) {
      return packageDataResponse;
    });
  }
  return _storage_updatePackageWithTransactions(packageDataResponse).then(
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
  packageDataResponse.addtransaction(value, 'Tiền mặt',
      'Thanh toán trước đơn: ${packageDataResponse.getID}');
  return _sendOrStoreOrderWithTransaction(packageDataResponse)
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
  packageDataResponse.makeDone();
  return _sendOrStoreOrderWithTransaction(packageDataResponse).then(
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
  return _sendOrStoreOrderWithTransaction(packageDataResponse).then((valuex) {
    refreshBootStrap();
    return Future.delayed(Duration(seconds: 1)).then((value) => valuex);
  });
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
    packageDataResponse.markDeletedOrder();
    refreshBootStrap();
    return value;
  });
}

Future<void> syncOrderPackage(PackageDataResponse packageDataResponse,
    {Duration delay = Duration.zero}) {
  final request = LocalStorage.getRequest(packageDataResponse);
  if (request == null) {
    return Future(() => null);
  }
  final path = request.path;
  if (path != funcName) {
    return Future(() => null);
  }
  return Future.delayed(delay).then(
    (value) => _invokeFunc(request)
        .then(
          (value) =>
              LocalStorage.removeOrderPakageAndRequest(packageDataResponse),
        )
        .then(
          (value) => packageDataResponse.swithLocalStatus(false),
        ),
  );
}

Future<void> syncAllOrderPackage(
    List<PackageDataResponse> packageDataResponses) {
  List<Future<void>> listF = [];
  int index = 0;
  for (final packageDataResponse in packageDataResponses) {
    final clusterDelay = (index / 10).floor();
    listF.add(syncOrderPackage(packageDataResponse,
        delay: Duration(seconds: clusterDelay)));
    index++;
  }
  return Future.wait(listF);
}

Future<void> removeLocalOrder(PackageDataResponse packageDataResponse) {
  packageDataResponse.markDeletedOrder();
  return LocalStorage.removeOrderPakageAndRequest(packageDataResponse);
}

Future<void> removeAllLocalOrder() {
  return LocalStorage.removeAllOrderPakageAndRequest();
}

List<PackageDataResponse> getAllPendingOrderPackage() {
  final listOrder = LocalStorage.getOrderPakage();
  listOrder.forEach((element) {
    element.fillData(isLocal: true);
  });
  return listOrder;
}

Map<String, RequestStorage> getAllPendingOrderPackageRequest() {
  final listOrder = LocalStorage.getAllRequest();
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

Future<ListPackageDetailResult> getAllOrderPackgeStatus(
    {required String groupID,
    required String status,
    int id = 0,
    int page = 0,
    int size = 1000}) {
  if (haveInteret) {
    return getAllByStatusPackage(
        id: id, size: 10, groupID: groupID, status: status);
  }
  return Future.value(ListPackageDetailResult(listResult: []));
}
