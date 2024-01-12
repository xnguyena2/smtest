import 'package:sales_management/api/model/package/buyer.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/api/model/package/package_detail.dart';
import 'package:sales_management/api/model/package/user_package.dart';
import 'package:sales_management/utils/constants.dart';

class ProductPackage extends PackageDetail {
  ProductPackage({
    required int id,
    required String groupId,
    required this.buyer,
    required this.productUnits,
  }) : super(
          id: id,
          groupId: groupId,
          createat: '',
          packageSecondId: '',
          deviceId: '',
          staff_id: deviceID,
          price: 0.0,
          payment: 0.0,
          discountAmount: 0.0,
          discountPercent: 0.0,
          shipPrice: 0.0,
          cost: 0.0,
          profit: 0.0,
          packageType: haveTable ? DeliverType.table : DeliverType.takeaway,
        );

  ProductPackage.fromPackageDataResponse(
      PackageDataResponse packageDataResponse)
      : super(
          id: packageDataResponse.id,
          groupId: packageDataResponse.groupId,
          packageSecondId: packageDataResponse.packageSecondId,
          deviceId: packageDataResponse.deviceId,
          staff_id: packageDataResponse.staff_id,
          price: packageDataResponse.price,
          payment: packageDataResponse.payment,
          discountAmount: packageDataResponse.discountAmount,
          discountPercent: packageDataResponse.discountPercent,
          shipPrice: packageDataResponse.shipPrice,
          cost: packageDataResponse.cost,
          profit: packageDataResponse.profit,
          areaId: packageDataResponse.areaId,
          areaName: packageDataResponse.areaName,
          tableId: packageDataResponse.tableId,
          tableName: packageDataResponse.tableName,
          packageType: packageDataResponse.packageType,
          voucher: packageDataResponse.voucher,
          note: packageDataResponse.note,
          image: packageDataResponse.image,
          progress: packageDataResponse.progress,
          status: packageDataResponse.status,
        ) {
    buyer = packageDataResponse.buyer;
    productUnits = packageDataResponse.items;
  }

  late final Buyer? buyer;
  late final List<UserPackage> productUnits;

  ProductPackage.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    buyer = Buyer.fromJson(json['buyer']);
    productUnits = List.from(json['product_units'])
        .map((e) => UserPackage.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = super.toJson();

    _data['buyer'] = buyer?.toJson();
    _data['product_units'] = productUnits.map((e) => e.toJson()).toList();
    return _data;
  }
}
