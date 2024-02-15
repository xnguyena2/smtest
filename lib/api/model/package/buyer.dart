import 'package:hive/hive.dart';
import 'package:sales_management/api/model/base_entity.dart';

part 'buyer.g.dart';

@HiveType(typeId: 21)
class Buyer extends BaseEntity {
  Buyer({
    required int id,
    required String groupId,
    required String? createat,
    required this.deviceId,
    required this.regionId,
    required this.districtId,
    required this.wardId,
    required this.realPrice,
    required this.totalPrice,
    required this.shipPrice,
    required this.discount,
    required this.point,
    this.reciverFullname,
    this.phoneNumberClean,
    this.phoneNumber,
    this.reciverAddress,
    this.status,
  }) : super(id: id, groupId: groupId, createat: createat);

  @HiveField(4)
  late String deviceId;

  @HiveField(5)
  late String? reciverFullname;

  @HiveField(6)
  late String? phoneNumberClean;

  @HiveField(7)
  late String? phoneNumber;

  @HiveField(8)
  late String? reciverAddress;

  @HiveField(9)
  late int regionId;

  @HiveField(10)
  late int districtId;

  @HiveField(11)
  late int wardId;

  @HiveField(12)
  late double realPrice;

  @HiveField(13)
  late double totalPrice;

  @HiveField(14)
  late double shipPrice;

  @HiveField(15)
  late double discount;

  @HiveField(16)
  late int point;

  @HiveField(17)
  late final String? status;

  Buyer.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    deviceId = json['device_id'];
    reciverFullname = json['reciver_fullname'];
    phoneNumberClean = json['phone_number_clean'];
    phoneNumber = json['phone_number'];
    reciverAddress = json['reciver_address'];
    regionId = json['region_id'];
    districtId = json['district_id'];
    wardId = json['ward_id'];
    realPrice = json['real_price'];
    totalPrice = json['total_price'];
    shipPrice = json['ship_price'];
    discount = json['discount'];
    point = json['point'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = super.toJson();
    _data['device_id'] = deviceId;
    _data['reciver_fullname'] = reciverFullname;
    _data['phone_number_clean'] = phoneNumberClean;
    _data['phone_number'] = phoneNumber;
    _data['reciver_address'] = reciverAddress;
    _data['region_id'] = regionId;
    _data['district_id'] = districtId;
    _data['ward_id'] = wardId;
    _data['real_price'] = realPrice;
    _data['total_price'] = totalPrice;
    _data['ship_price'] = shipPrice;
    _data['discount'] = discount;
    _data['point'] = point;
    _data['status'] = status;
    return _data;
  }

  int get getTotalPoint => ((realPrice - discount) / 100000).toInt() + point;
}
