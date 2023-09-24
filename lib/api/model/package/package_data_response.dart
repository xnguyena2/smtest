import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/api/model/package/package_detail.dart';
import 'package:sales_management/api/model/package/user_package.dart';

class ListPackageDetailResult {
  ListPackageDetailResult({
    required this.listResult,
  });
  late final List<PackageDataResponse> listResult;
  ListPackageDetailResult.fromJson(Map<String, dynamic> json) {
    listResult = List.from(json['list_result'])
        .map((e) => PackageDataResponse.fromJson(e))
        .toList();
  }
}

class PackageDataResponse extends PackageDetail {
  PackageDataResponse({
    required this.items,
    required this.buyer,
  }) : super(
            groupId: '',
            createat: '',
            packageSecondId: '',
            deviceId: '',
            price: 0.0,
            payment: 0.0,
            discountAmount: 0.0,
            discountPercent: 0.0,
            shipPrice: 0.0);

  late final List<ProductInPackageResponse> items;
  late final BuyerData? buyer;

  PackageDataResponse.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    items = List.from(json['items'])
        .map((e) => ProductInPackageResponse.fromJson(e))
        .toList();
    buyer = json['buyer'] == null ? null : BuyerData.fromJson(json['buyer']);
  }

  Map<String, dynamic> toJson() {
    final _data = super.toJson();
    _data['items'] = items.map((e) => e.toJson()).toList();
    _data['buyer'] = buyer?.toJson();
    return _data;
  }
}

class ProductInPackageResponse extends UserPackage {
  ProductInPackageResponse({
    required this.beerSubmitData,
  }) : super(
            groupId: '',
            createat: '',
            packageSecondId: '',
            deviceId: '',
            productSecondId: '',
            productUnitSecondId: '',
            numberUnit: 0,
            price: 0.0,
            discountAmount: 0.0,
            discountPercent: 0.0);
  late final BeerSubmitData beerSubmitData;

  ProductInPackageResponse.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    beerSubmitData = BeerSubmitData.fromJson(json['beerSubmitData']);
  }

  Map<String, dynamic> toJson() {
    final _data = super.toJson();
    _data['beerSubmitData'] = beerSubmitData.toJson();
    return _data;
  }
}

class BuyerData {
  BuyerData({
    required this.groupId,
    required this.deviceId,
    required this.reciverFullname,
    required this.phoneNumberClean,
    required this.phoneNumber,
    required this.reciverAddress,
    required this.region,
    required this.district,
    this.ward,
    required this.totalPrice,
    required this.pointsDiscount,
  });
  late final String groupId;
  late final String deviceId;
  late final String? reciverFullname;
  late final String? phoneNumberClean;
  late final String? phoneNumber;
  late final String? reciverAddress;
  late final String? region;
  late final String? district;
  late final String? ward;
  late final double totalPrice;
  late final double pointsDiscount;

  BuyerData.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    deviceId = json['device_id'];
    reciverFullname = json['reciver_fullname'];
    phoneNumberClean = json['phone_number_clean'];
    phoneNumber = json['phone_number'];
    reciverAddress = json['reciver_address'];
    region = json['region'];
    district = json['district'];
    ward = json['ward'];
    totalPrice = json['total_price'] as double;
    pointsDiscount = json['points_discount'] as double;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['group_id'] = groupId;
    _data['device_id'] = deviceId;
    _data['reciver_fullname'] = reciverFullname;
    _data['phone_number_clean'] = phoneNumberClean;
    _data['phone_number'] = phoneNumber;
    _data['reciver_address'] = reciverAddress;
    _data['region'] = region;
    _data['district'] = district;
    _data['ward'] = ward;
    _data['total_price'] = totalPrice;
    _data['points_discount'] = pointsDiscount;
    return _data;
  }
}
