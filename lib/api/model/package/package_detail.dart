import 'package:sales_management/api/model/base_entity.dart';
import 'package:sales_management/utils/constants.dart';

class PackageDetail extends BaseEntity {
  late final String packageSecondId;
  late final String? deviceId;
  late String? areaId;
  late String? areaName;
  late String? tableId;
  late String? tableName;
  late String? packageType;
  late final String? voucher;
  late final double price;
  late final double payment;
  late final double discountAmount;
  late final double discountPercent;
  late final double shipPrice;
  late final String? note;
  late final String? image;
  late final String? progress;
  late String? status;

  PackageDetail({
    required int? id,
    required String groupId,
    String? createat,
    required this.packageSecondId,
    required this.deviceId,
    required this.price,
    required this.payment,
    required this.discountAmount,
    required this.discountPercent,
    required this.shipPrice,
    this.areaId,
    this.areaName,
    this.tableId,
    this.tableName,
    this.packageType,
    this.voucher,
    this.note,
    this.image,
    this.progress,
    this.status,
  }) : super(id: id, groupId: groupId, createat: createat);

  PackageDetail.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    packageSecondId = json['package_second_id'];
    deviceId = json['device_id'];
    packageType = json['package_type'];
    areaId = json['area_id'];
    areaName = json['area_name'];
    tableId = json['table_id'];
    tableName = json['table_name'];
    voucher = json['voucher'];
    price = json['price'] as double;
    payment = json['payment'] as double;
    discountAmount = json['discount_amount'] as double;
    discountPercent = json['discount_percent'] as double;
    shipPrice = json['ship_price'] as double;
    note = json['note'];
    image = json['image'];
    progress = json['progress'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = super.toJson();
    _data['package_second_id'] = packageSecondId;
    _data['device_id'] = deviceId;
    _data['area_id'] = areaId;
    _data['area_name'] = areaName;
    _data['table_id'] = tableId;
    _data['table_name'] = tableName;
    _data['package_type'] = packageType;
    _data['voucher'] = voucher;
    _data['price'] = price;
    _data['payment'] = payment;
    _data['discount_amount'] = discountAmount;
    _data['discount_percent'] = discountPercent;
    _data['ship_price'] = shipPrice;
    _data['note'] = note;
    _data['image'] = image;
    _data['progress'] = progress;
    _data['status'] = status;
    return _data;
  }

  bool get isDone => status == 'DONE';

  String get areAndTable => areaName == null || tableName == null
      ? 'Chưa có bàn được chọn'
      : '${areaName} - ${tableName}';

  String get priceFormat => MoneyFormater.format(price);
}
