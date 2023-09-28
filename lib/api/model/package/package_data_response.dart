import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/api/model/package/buyer.dart';
import 'package:sales_management/api/model/package/package_detail.dart';
import 'package:sales_management/api/model/package/user_package.dart';
import 'package:sales_management/page/address/api/model/address_data.dart';
import 'package:sales_management/utils/utils.dart';

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
            id: 0,
            groupId: '',
            createat: '',
            packageSecondId: '',
            deviceId: '',
            price: 0.0,
            payment: 0.0,
            discountAmount: 0.0,
            discountPercent: 0.0,
            shipPrice: 0.0);

  late final String localTimeTxt;

  late final List<ProductInPackageResponse> items;
  late final BuyerData? buyer;

  PackageDataResponse.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    items = List.from(json['items'])
        .map((e) => ProductInPackageResponse.fromJson(e))
        .toList();
    buyer = json['buyer'] == null ? null : BuyerData.fromJson(json['buyer']);

    localTimeTxt = formatLocalDateTime(createat);
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
            id: 0,
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
  late final BeerSubmitData? beerSubmitData;

  ProductInPackageResponse.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    beerSubmitData = BeerSubmitData.fromJson(json['beerSubmitData']);
  }

  Map<String, dynamic> toJson() {
    final _data = super.toJson();
    _data['beerSubmitData'] = beerSubmitData?.toJson();
    return _data;
  }
}

class BuyerData extends Buyer {
  BuyerData({
    required this.region,
    required this.district,
    required this.ward,
  }) : super(
            id: 0,
            groupId: '',
            createat: '',
            deviceId: '',
            regionId: 0,
            districtId: 0,
            wardId: 0,
            realPrice: 0.0,
            totalPrice: 0.0,
            shipPrice: 0.0,
            pointsDiscount: 0.0);
  late String? region;
  late String? district;
  late String? ward;

  void updateData(AddressData data) {
    phoneNumber = data.phoneNumber;
    reciverFullname = data.reciverFullName;
    reciverAddress = data.houseNumber;
    region = data.region.name;
    regionId = data.region.id;
    district = data.district.name;
    districtId = data.district.id;
    ward = data.ward.name;
    wardId = data.ward.id;
  }

  BuyerData.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    region = json['region'];
    district = json['district'];
    ward = json['ward'];
  }

  Map<String, dynamic> toJson() {
    final _data = super.toJson();
    _data['region'] = region;
    _data['district'] = district;
    _data['ward'] = ward;
    return _data;
  }
}
