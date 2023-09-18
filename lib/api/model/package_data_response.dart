import 'package:sales_management/api/model/beer_submit_data.dart';

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

class PackageDataResponse {
  PackageDataResponse({
    required this.groupId,
    required this.createat,
    required this.packageSecondId,
    required this.deviceId,
    required this.packageType,
    required this.voucher,
    required this.price,
    required this.discountAmount,
    required this.discountPercent,
    required this.shipPrice,
    required this.note,
    required this.image,
    required this.progress,
    required this.status,
    required this.items,
  });
  late final String groupId;
  late final String? createat;
  late final String packageSecondId;
  late final String deviceId;
  late final String? packageType;
  late final String? voucher;
  late final double price;
  late final double discountAmount;
  late final double discountPercent;
  late final double shipPrice;
  late final String? note;
  late final String? image;
  late final String? progress;
  late final String? status;
  late final List<Items> items;

  PackageDataResponse.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    createat = json['createat'];
    packageSecondId = json['package_second_id'];
    deviceId = json['device_id'];
    packageType = json['package_type'];
    voucher = json['voucher'];
    price = json['price'];
    discountAmount = json['discount_amount'];
    discountPercent = json['discount_percent'];
    shipPrice = json['ship_price'];
    note = json['note'];
    image = json['image'];
    progress = json['progress'];
    status = json['status'];
    items = List.from(json['items']).map((e) => Items.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['group_id'] = groupId;
    _data['createat'] = createat;
    _data['package_second_id'] = packageSecondId;
    _data['device_id'] = deviceId;
    _data['package_type'] = packageType;
    _data['voucher'] = voucher;
    _data['price'] = price;
    _data['discount_amount'] = discountAmount;
    _data['discount_percent'] = discountPercent;
    _data['ship_price'] = shipPrice;
    _data['note'] = note;
    _data['image'] = image;
    _data['progress'] = progress;
    _data['status'] = status;
    _data['items'] = items.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Items {
  Items({
    required this.groupId,
    required this.createat,
    required this.packageSecondId,
    required this.deviceId,
    required this.productSecondId,
    required this.productUnitSecondId,
    required this.numberUnit,
    required this.price,
    required this.discountAmount,
    required this.discountPercent,
    required this.note,
    required this.status,
    required this.beerSubmitData,
  });
  late final String groupId;
  late final String createat;
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
  late final BeerSubmitData beerSubmitData;

  Items.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    createat = json['createat'];
    packageSecondId = json['package_second_id'];
    deviceId = json['device_id'];
    productSecondId = json['product_second_id'];
    productUnitSecondId = json['product_unit_second_id'];
    numberUnit = json['number_unit'];
    price = json['price'];
    discountAmount = json['discount_amount'];
    discountPercent = json['discount_percent'];
    note = json['note'];
    status = json['status'];
    beerSubmitData = BeerSubmitData.fromJson(json['beerSubmitData']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['group_id'] = groupId;
    _data['createat'] = createat;
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
    _data['beerSubmitData'] = beerSubmitData.toJson();
    return _data;
  }
}
