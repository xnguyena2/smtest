import 'package:sales_management/api/model/base_entity.dart';
import 'package:sales_management/api/model/package/buyer.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/api/model/package/package_detail.dart';
import 'package:sales_management/api/model/package/user_package.dart';

class ProductPackage extends PackageDetail {
  ProductPackage({
    required String groupId,
    required this.buyer,
    required this.productUnits,
  }) : super(
            groupId: groupId,
            createat: '',
            packageSecondId: '',
            deviceId: '',
            price: 0.0,
            payment: 0.0,
            discountAmount: 0.0,
            discountPercent: 0.0,
            shipPrice: 0.0);

  ProductPackage.fromPackageDataResponse(
      PackageDataResponse packageDataResponse)
      : super(
            groupId: packageDataResponse.groupId,
            packageSecondId: packageDataResponse.packageSecondId,
            deviceId: packageDataResponse.deviceId,
            price: packageDataResponse.price,
            payment: packageDataResponse.payment,
            discountAmount: packageDataResponse.discountAmount,
            discountPercent: packageDataResponse.discountPercent,
            shipPrice: packageDataResponse.shipPrice) {
    // buyer = packageDataResponse.buyer;
    productUnits = packageDataResponse.items;
  }

  late final Buyer buyer;
  late final List<UserPackage> productUnits;

  ProductPackage.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    buyer = Buyer.fromJson(json['buyer']);
    productUnits = List.from(json['product_units'])
        .map((e) => UserPackage.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = super.toJson();

    _data['buyer'] = buyer.toJson();
    _data['product_units'] = productUnits.map((e) => e.toJson()).toList();
    return _data;
  }
}
