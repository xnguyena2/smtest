import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/page/address/api/model/region.dart';

class ListAddressData {
  ListAddressData({
    required this.listAddress,
  });

  late final Map<String, AddressData> listAddress;

  ListAddressData.fromJson(Map<String, dynamic> json) {
    listAddress = Map.from(json['list_address']).map((key, value) =>
        MapEntry<String, AddressData>(key, AddressData.fromJson(value)));
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['list_address'] = listAddress;
    return _data;
  }
}

class AddressData {
  late final String addressID;
  late String deviceID;
  late String reciverFullName;
  late String phoneNumber;
  late String houseNumber;
  late Region region;
  late Region district;
  late Region ward;
  late String regionTextFormat;

  BuyerData? _buyerData;

  AddressData({
    required this.addressID,
    required this.deviceID,
    required this.reciverFullName,
    required this.phoneNumber,
    required this.houseNumber,
    required this.region,
    required this.district,
    required this.ward,
    required this.regionTextFormat,
  });

  AddressData.fromBuyerData(BuyerData? b) {
    _buyerData = b;
    addressID = '';
    deviceID = b?.deviceId ?? '';
    reciverFullName = b?.reciverFullname ?? 'Khách lẻ';
    phoneNumber = b?.phoneNumber ?? '';
    houseNumber = b?.reciverAddress ?? '';
    region = Region(name: b?.region ?? '', id: b?.regionId ?? -1);
    district = Region(name: b?.district ?? '', id: b?.districtId ?? -1);
    ward = Region(name: b?.ward ?? '', id: b?.wardId ?? -1);
    regionTextFormat =
        region.id > 0 ? '${ward.name}, ${district.name}, ${region.name}' : '';
  }

  AddressData.fromJson(Map<String, dynamic> json) {
    addressID = json['address_id'];
    deviceID = json['device_id'];
    reciverFullName = json['reciver_fullname'];
    phoneNumber = json['phone_number'];
    houseNumber = json['house_number'];
    region = Region.fromJson(json['region']);
    district = Region.fromJson(json['district']);
    ward = Region.fromJson(json['ward']);
    regionTextFormat = json['region_text_format'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['address_id'] = addressID;
    _data['device_id'] = deviceID;
    _data['reciver_fullname'] = reciverFullName;
    _data['phone_number'] = phoneNumber;
    _data['house_number'] = houseNumber;
    _data['region'] = region;
    _data['district'] = district;
    _data['ward'] = ward;
    _data['region_text_format'] = regionTextFormat;
    return _data;
  }

  BuyerData? get getBuyerData => _buyerData;

  bool isValidData() {
    return phoneNumber.isNotEmpty;
  }
}
