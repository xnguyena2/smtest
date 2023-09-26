import 'package:sales_management/api/model/base_entity.dart';

class Buyer extends BaseEntity {
  Buyer({
    required int id,
    required String groupId,
    required String createat,
    required this.deviceId,
    required this.regionId,
    required this.districtId,
    required this.wardId,
    required this.realPrice,
    required this.totalPrice,
    required this.shipPrice,
    required this.pointsDiscount,
    this.reciverFullname,
    this.phoneNumberClean,
    this.phoneNumber,
    this.reciverAddress,
    this.status,
  }) : super(id: id, groupId: groupId, createat: createat);

  late final String deviceId;
  late final String? reciverFullname;
  late final String? phoneNumberClean;
  late final String? phoneNumber;
  late final String? reciverAddress;
  late final int regionId;
  late final int districtId;
  late final int wardId;
  late final double realPrice;
  late final double totalPrice;
  late final double shipPrice;
  late final double pointsDiscount;
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
    pointsDiscount = json['points_discount'];
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
    _data['points_discount'] = pointsDiscount;
    _data['status'] = status;
    return _data;
  }
}
