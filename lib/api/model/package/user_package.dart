import 'package:hive/hive.dart';
import 'package:sales_management/api/model/base_entity.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/utils/utils.dart';

part 'user_package.g.dart';

@HiveType(typeId: 18)
class UserPackage extends BaseEntity {
  @HiveField(4)
  late final String packageSecondId;

  @HiveField(5)
  late final String deviceId;

  @HiveField(6)
  late final String productSecondId;

  @HiveField(7)
  late final String productUnitSecondId;

  @HiveField(8)
  late int numberUnit;

  @HiveField(9)
  late double price;

  @HiveField(10)
  late double buyPrice;

  @HiveField(11)
  late double discountAmount;

  @HiveField(12)
  late double discountPercent;

  @HiveField(13)
  late String? note;

  @HiveField(14)
  late String? status;

  @HiveField(16)
  late double? discountPromotional;

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
    required this.buyPrice,
    required this.discountAmount,
    required this.discountPercent,
    required this.discountPromotional,
    required this.note,
    required this.status,
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
    buyPrice = productInPackageResponse.buyPrice;
    discountAmount = productInPackageResponse.discountAmount;
    discountPercent = productInPackageResponse.discountPercent;
    note = productInPackageResponse.note;
    status = productInPackageResponse.status;
    discountPromotional = productInPackageResponse.discountPromotional;
  }

  UserPackage.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    packageSecondId = json['package_second_id'];
    deviceId = json['device_id'];
    productSecondId = json['product_second_id'];
    productUnitSecondId = json['product_unit_second_id'];
    numberUnit = json['number_unit'];
    price = json['price'] as double;
    buyPrice = json['buy_price'] as double;
    discountAmount = json['discount_amount'] as double;
    discountPercent = json['discount_percent'] as double;
    discountPromotional = castToDouble(json['discount_promotional']);
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
    _data['buy_price'] = buyPrice;
    _data['discount_amount'] = discountAmount;
    _data['discount_percent'] = discountPercent;
    _data['discount_promotional'] = discountPromotional;
    _data['note'] = note;
    _data['status'] = status;
    return _data;
  }
}
