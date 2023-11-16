import 'dart:collection';

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

  late List<ProductInPackageResponse> items;
  late BuyerData? buyer;

  final Map<String, ProductInPackageResponse> productMap = HashMap();

  PackageDataResponse.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    items = List.from(json['items'])
        .map((e) => ProductInPackageResponse.fromJson(e))
        .toList();
    buyer = json['buyer'] == null ? null : BuyerData.fromJson(json['buyer']);

    localTimeTxt = formatLocalDateTime(createat);
    updateProductMap();
  }

  Map<String, dynamic> toJson() {
    final _data = super.toJson();
    _data['items'] = items.map((e) => e.toJson()).toList();
    _data['buyer'] = buyer?.toJson();
    return _data;
  }

  void updateListProductItem(PackageDataResponse package) {
    items = package.items;
  }

  void addProduct(ProductInPackageResponse productInPackageResponse) {
    final productUnit =
        productInPackageResponse.beerSubmitData?.listUnit?.firstOrNull;
    if (productUnit == null) {
      return;
    }
    if (productInPackageResponse.numberUnit <= 0) {
      items.remove(productInPackageResponse);
      productMap.remove(productUnit.beerUnitSecondId);
      return;
    }
    if (productMap.containsKey(productUnit.beerUnitSecondId)) {
      return;
    }
    items.add(productInPackageResponse);
    productMap[productUnit.beerUnitSecondId] = productInPackageResponse;
  }

  void updateProductMap() {
    items.forEach((element) {
      final productUnit = element.beerSubmitData?.listUnit?.firstOrNull;
      if (productUnit == null) {
        return;
      }
      productMap[productUnit.beerUnitSecondId] = element;
    });
  }

  void updateBuyer(AddressData addressData) {
    if (buyer == null) {
      buyer =
          BuyerData.fromPackageDataResponseAndAddressData(this, addressData);
      return;
    }
    buyer!.updateData(addressData);
  }

  PackageDataResponse clone() {
    return PackageDataResponse.fromJson(toJson());
  }

  double get totalPrice {
    double total = 0;
    items.forEach((element) {
      total += element.realPrice;
    });
    return total;
  }

  int get numItem {
    int total = 0;
    items.forEach((element) {
      total += element.numberUnit;
    });
    return total;
  }
}

class ProductInPackageResponse extends UserPackage {
  ProductInPackageResponse({
    required this.beerSubmitData,
  }) : super(
            id: 0,
            groupId: 'set at backend',
            deviceId: 'set at backend',
            packageSecondId: 'set at backend',
            createat: null,
            productSecondId: beerSubmitData?.beerSecondID ?? '',
            productUnitSecondId:
                beerSubmitData?.listUnit?.firstOrNull?.beerUnitSecondId ?? '',
            numberUnit: 0,
            price: beerSubmitData?.listUnit?.firstOrNull?.realPrice ?? 0.0,
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

  double get realPrice =>
      numberUnit * (price * (1 - discountPercent / 100) - discountAmount);
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

  BuyerData.fromPackageDataResponseAndAddressData(
      PackageDataResponse p, AddressData a)
      : super(
            id: 0,
            groupId: p.groupId,
            createat: null,
            deviceId: '',
            regionId: 0,
            districtId: 0,
            wardId: 0,
            realPrice: 0.0,
            totalPrice: 0.0,
            shipPrice: 0.0,
            pointsDiscount: 0.0) {
    updateData(a);
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

  String? getAddressFormat() {
    if (region == null) {
      return null;
    }
    if (region!.isEmpty) {
      return null;
    }
    return '${reciverAddress ?? ''}, ${ward ?? ''}, ${district ?? ''}, ${region ?? ''}';
  }
}
