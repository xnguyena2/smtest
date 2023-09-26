import 'package:sales_management/api/model/base_entity.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';

class UserPackage extends BaseEntity {
  late final String packageSecondId;
  late final String deviceId;
  late final String productSecondId;
  late final String productUnitSecondId;
  late final int numberUnit;
  late final double price;
  late final double discountAmount;
  late final double discountPercent;
  late final String? note;
  late final String? status;

  UserPackage({
    required int id,
    required String groupId,
    required String? createat,
    required this.packageSecondId,
    required this.deviceId,
    required this.productSecondId,
    required this.productUnitSecondId,
    required this.numberUnit,
    required this.price,
    required this.discountAmount,
    required this.discountPercent,
    this.note,
    this.status,
  }) : super(id: id, groupId: groupId, createat: createat);

  UserPackage.fromProductInPackageResponse(
      ProductInPackageResponse productInPackageResponse)
      : super(
            id: productInPackageResponse.id,
            groupId: productInPackageResponse.groupId,
            createat: null) {
    packageSecondId = productInPackageResponse.packageSecondId;
    deviceId = productInPackageResponse.deviceId;
    productSecondId = productInPackageResponse.productSecondId;
    productUnitSecondId = productInPackageResponse.productUnitSecondId;
    numberUnit = productInPackageResponse.numberUnit;
    price = productInPackageResponse.price;
    discountAmount = productInPackageResponse.discountAmount;
    discountPercent = productInPackageResponse.discountPercent;
    note = productInPackageResponse.note;
    status = productInPackageResponse.status;
  }

  UserPackage.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    packageSecondId = json['package_second_id'];
    deviceId = json['device_id'];
    productSecondId = json['product_second_id'];
    productUnitSecondId = json['product_unit_second_id'];
    numberUnit = json['number_unit'];
    price = json['price'] as double;
    discountAmount = json['discount_amount'] as double;
    discountPercent = json['discount_percent'] as double;
    note = json['note'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = super.toJson();
    _data['package_second_id'] = packageSecondId;
    _data['device_id'] = deviceId;
    _data['product_second_id'] = productSecondId;
    _data['product_unit_second_id'] = productUnitSecondId;
    _data['number_unit'] = numberUnit;
    _data['price'] = price;
    _data['discount_amount'] = discountAmount;
    _data['discount_percent'] = discountPercent;
    _data['note'] = note;
    _data['status'] = status;
    return _data;
  }
}
