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
    this.packageType,
    this.voucher,
    required this.price,
    required this.payment,
    required this.discountAmount,
    required this.discountPercent,
    required this.shipPrice,
    this.note,
    this.image,
    this.progress,
    this.status,
    required this.items,
    required this.buyer,
  });
  late final String groupId;
  late final String? createat;
  late final String packageSecondId;
  late final String? deviceId;
  late final String? areaId;
  late final String? areaName;
  late final String? tableId;
  late final String? tableName;
  late final String? packageType;
  late final String? voucher;
  late final double price;
  late final double payment;
  late final double discountAmount;
  late final double discountPercent;
  late final double shipPrice;
  late final String? note;
  late final String? image;
  late final String? progress;
  late final String? status;
  late final List<Items> items;
  late final Buyer? buyer;

  PackageDataResponse.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    createat = json['createat'];
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
    items = List.from(json['items']).map((e) => Items.fromJson(e)).toList();
    buyer = json['buyer'] == null ? null : Buyer.fromJson(json['buyer']);
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
    _data['payment'] = payment;
    _data['discount_amount'] = discountAmount;
    _data['discount_percent'] = discountPercent;
    _data['ship_price'] = shipPrice;
    _data['note'] = note;
    _data['image'] = image;
    _data['progress'] = progress;
    _data['status'] = status;
    _data['items'] = items.map((e) => e.toJson()).toList();
    _data['buyer'] = buyer?.toJson();
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
    this.note,
    this.status,
    required this.beerSubmitData,
  });
  late final String groupId;
  late final String? createat;
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
    price = json['price'] as double;
    discountAmount = json['discount_amount'] as double;
    discountPercent = json['discount_percent'] as double;
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

class Buyer {
  Buyer({
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

  Buyer.fromJson(Map<String, dynamic> json) {
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
