import 'dart:collection';

import 'package:hive/hive.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/api/model/package/buyer.dart';
import 'package:sales_management/api/model/package/package_detail.dart';
import 'package:sales_management/api/model/package/user_package.dart';
import 'package:sales_management/page/address/api/model/address_data.dart';
import 'package:sales_management/page/transaction/api/model/payment_transaction.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/utils.dart';

part 'package_data_response.g.dart';

enum PaymentStatus {
  DONE,
  MAKE_SOME_PAY,
  NOT_PAY,
  CANCEL,
  RETURN,
}

class WrapListFilter {
  final ListPackageDetailResult listPackageDetailResult;

  WrapListFilter({
    required this.listPackageDetailResult,
  });

  List<PackageDataResponse> getListResult({required String filter}) {
    if (filter.isEmpty) return listPackageDetailResult.getList;
    return listPackageDetailResult.getList
        .where((e) =>
            e.tableName?.contains(filter) == true ||
            e.buyer?.reciverFullname?.contains(filter) == true)
        .toList();
  }
}

class ListPackageDetailResult {
  ListPackageDetailResult({
    required List<PackageDataResponse> listResult,
  }) {
    _listResult = listResult;
    _init();
  }
  late final List<PackageDataResponse> _listResult;
  late final Map<String, PackageDataResponse> mapExist;

  int currentID = 0;

  ListPackageDetailResult.fromJson(Map<String, dynamic> json) {
    _listResult = List.from(json['list_result'])
        .map((e) => PackageDataResponse.fromJson(e))
        .toList();
    _init();
  }

  void _init() {
    mapExist = Map.fromEntries(_listResult.map(
        (e) => MapEntry<String, PackageDataResponse>(e.packageSecondId, e)));
    _listResult.forEach((element) {
      if (currentID == 0 || currentID > (element.id ?? 0)) {
        currentID = element.id ?? 0;
      }
    });
  }

  void addNewOrder(PackageDataResponse newO) {
    if (mapExist.containsKey(newO.packageSecondId)) return;
    mapExist[newO.packageSecondId] = newO;
    _listResult.add(newO);
  }

  void deleteNewOrder(PackageDataResponse newO) {
    final obj = mapExist.remove(newO.packageSecondId);
    if (obj != null) {
      _listResult.remove(obj);
    }
  }

  void updateListOrder(List<PackageDataResponse> newO) {
    newO.forEach((element) {
      if (element.isDeleted()) {
        deleteNewOrder(element);
      } else {
        addNewOrder(element);
      }
    });
  }

  void updateOrder(PackageDataResponse newO) {
    final foundObj = mapExist[newO.packageSecondId];
    if (foundObj == null) return;
    final index = _listResult.indexOf(foundObj);
    if (index < 0) return;
    _listResult[index] = newO;
    mapExist[newO.packageSecondId] = newO;
  }

  void insertLocalOrder(List<PackageDataResponse> listPendingOrder) {
    _listResult.insertAll(0, listPendingOrder);
    for (final element in listPendingOrder) {
      if (mapExist.containsKey(element.packageSecondId)) {
        _listResult.remove(element);
        continue;
      }
      mapExist[element.packageSecondId] = element;
    }
  }

  void removeAllLocalOrder() {
    _listResult.forEach((element) {
      if (element.isLocal) {
        mapExist.remove(element);
      }
    });
    _listResult.removeWhere((element) => element.isLocal);
  }

  List<PackageDataResponse> getLocalPackage() {
    return _listResult.where((element) => element.isLocal).toList();
  }

  bool get isEmpty => _listResult.isEmpty;

  bool get isHaveLocalOrder =>
      _listResult.indexWhere((element) => element.isLocal) >= 0;

  List<PackageDataResponse> get getList => _listResult;
}

@HiveType(typeId: 20)
class PackageDataResponse extends PackageDetail {
  PackageDataResponse({
    required super.id,
    required super.groupId,
    required super.createat,
    required super.packageSecondId,
    required super.deviceId,
    required super.staff_id,
    required super.price,
    required super.cost,
    required super.profit,
    required super.point,
    required super.payment,
    required super.discountAmount,
    required super.discountPercent,
    required super.shipPrice,
    required super.status,
    required super.packageType,
    required super.areaId,
    required super.areaName,
    required super.tableId,
    required super.tableName,
    required super.voucher,
    required super.note,
    required super.image,
    required super.progress,
    required this.items,
    required this.buyer,
  }) : localTimeTxt = formatLocalDateTimeOfDateTime(DateTime.now().toUtc());

  @HiveField(26)
  late List<ProductInPackageResponse> items;

  @HiveField(27)
  late BuyerData? buyer;

  PackageDataResponse.empty()
      : localTimeTxt = formatLocalDateTimeOfDateTime(DateTime.now().toUtc()),
        super(
          id: 0,
          groupId: groupID,
          createat: getCreateAtNow(),
          packageSecondId: generateUUID(),
          deviceId: '',
          staff_id: deviceID,
          price: 0.0,
          cost: 0.0,
          profit: 0.0,
          point: 0,
          payment: 0.0,
          discountAmount: 0.0,
          discountPercent: 0.0,
          shipPrice: 0.0,
          status: PackageStatusType.CREATE,
          packageType: haveTable ? DeliverType.table : DeliverType.takeaway,
        ) {
    items = [];
    buyer = null;
  }

  PackageDataResponse.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    items = List.from(json['items'])
        .map((e) => ProductInPackageResponse.fromJson(e))
        .toList();
    buyer = json['buyer'] == null ? null : BuyerData.fromJson(json['buyer']);

    localTimeTxt = formatLocalDateTime(createat);

    fillData();
  }

  Map<String, dynamic> toJson() {
    final _data = super.toJson();
    _data['items'] = items.map((e) => e.toJson()).toList();
    _data['buyer'] = buyer?.toJson();
    return _data;
  }

  late final String localTimeTxt;

  final Map<String, ProductInPackageResponse> productMap = HashMap();
  bool isLocal = false;

  PackageDataResponse clone() {
    final cl = PackageDataResponse.fromJson(toJson());
    cl.swithLocalStatus(isLocal);
    return cl;
  }

  void swithLocalStatus(bool isLocal) {
    this.isLocal = isLocal;
  }

  void fillData({bool isLocal = false}) {
    this.isLocal = isLocal;
    updateProductMap();
  }

  void updateListProductItem(PackageDataResponse package) {
    items = package.items;
    updateProductMap();
    updatePrice();
  }

  void addOrUpdateProduct(ProductInPackageResponse productInPackageResponse) {
    _addProduct(productInPackageResponse);
    updatePrice();
  }

  void _addProduct(ProductInPackageResponse productInPackageResponse) {
    final productUnit =
        productInPackageResponse.beerSubmitData?.listUnit?.firstOrNull;
    if (productUnit == null) {
      return;
    }
    if (productInPackageResponse.numberUnit <= 0) {
      var itemRemoved = productMap.remove(productUnit.beerUnitSecondId);
      items.remove(itemRemoved);
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

  void cleanBuyer() {
    buyer = null;
    point = 0;
  }

  void updateBuyer(AddressData addressData) {
    if (!addressData.isValidData()) {
      buyer = null;
      return;
    }
    if (buyer == null) {
      buyer =
          BuyerData.fromPackageDataResponseAndAddressData(this, addressData);
      return;
    }
    buyer!.updateData(addressData);
  }

  void applyPoint(int point, double discount) {
    discountPercent = 0;
    discountAmount += discount;
    this.point = -point;
  }

  void updatePrice() {
    price = items.fold(0,
        (previousValue, element) => previousValue + element.totalPriceDiscount);
    cost = items.fold(
        0, (previousValue, element) => previousValue + element.totalCost);
  }

  int get totalNumIems {
    return items.fold(
        0, (previousValue, element) => previousValue + element.numberUnit);
  }

  String get totalPriceFormat => MoneyFormater.format(price);

  int get numItem {
    int total = 0;
    items.forEach((element) {
      total += element.numberUnit;
    });
    return total;
  }

  double get profitExpect => finalPrice - cost;

  PaymentStatus paymentStatus() {
    if (status == PackageStatusType.CANCEL) {
      return PaymentStatus.CANCEL;
    }
    if (status == PackageStatusType.RETURN) {
      return PaymentStatus.RETURN;
    }

    if (payment >= finalPrice && isDone) {
      return PaymentStatus.DONE; //'Đã thanh toán';
    }
    if (payment > 0) {
      return PaymentStatus.MAKE_SOME_PAY; //'Thanh toán một phần';
    }
    return PaymentStatus.NOT_PAY; //'Chưa thanh toán';
  }

  String getStatusTxt() {
    final payment = paymentStatus();
    switch (payment) {
      case PaymentStatus.CANCEL:
        return 'Đã hủy';
      case PaymentStatus.DONE:
        return 'Đã giao';
      case PaymentStatus.MAKE_SOME_PAY:
        return 'Đang giao dịch';
      case PaymentStatus.NOT_PAY:
        return 'Chưa thanh toán';
      case PaymentStatus.RETURN:
        return 'Trả lại';
    }
  }

  PaymentTransaction addtransaction(
    double payment,
    String type,
    String detail,
  ) {
    super.addtransaction(payment, type, detail);
    return PaymentTransaction(
        groupId: groupId,
        transaction_second_id: null,
        packageSecondId: packageSecondId,
        amount: payment,
        category: 'Bán hàng',
        money_source: 'Tiền mặt',
        device_id: deviceId,
        note: detail,
        transaction_type: TType.INCOME);
  }

  PaymentTransaction? makeDone() {
    donePayment();
    if (payment < finalPrice) {
      print('payment: $payment, finalPrice: $finalPrice');
      return addtransaction(
          finalPrice - payment, 'Tiền mặt', 'Hoàn thành đơn: ${getID}');
    }
    return null;
  }

  String get getID => packageSecondId.substring(0, 8).toUpperCase();

  String? getDoneTime() {
    if (status != PackageStatusType.DONE) {
      return null;
    }
    final length = progress?.transaction?.length;
    if (length == null || length == 0) {
      return null;
    }
    return progress!.transaction!.last.createat!;
  }
}

@HiveType(typeId: 19)
class ProductInPackageResponse extends UserPackage {
  @HiveField(15)
  late final BeerSubmitData? beerSubmitData;

  ProductInPackageResponse({
    required super.id,
    required super.groupId,
    required super.deviceId,
    required super.packageSecondId,
    required super.createat,
    required super.productSecondId,
    required super.productUnitSecondId,
    required super.numberUnit,
    required super.price,
    required super.buyPrice,
    required super.discountAmount,
    required super.discountPercent,
    required super.note,
    required super.status,
    required this.beerSubmitData,
  });

  ProductInPackageResponse.fromProductData({
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
            buyPrice: beerSubmitData?.listUnit?.firstOrNull?.buyPrice ?? 0.0,
            discountAmount: 0.0,
            discountPercent: 0.0);

  ProductInPackageResponse.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    final productJson = json['beerSubmitData'];
    beerSubmitData =
        productJson == null ? null : BeerSubmitData.fromJson(productJson);
  }

  Map<String, dynamic> toJson() {
    final _data = super.toJson();
    _data['beerSubmitData'] = beerSubmitData?.toJson();
    return _data;
  }

  String get get_show_name => beerSubmitData?.get_show_name ?? 'Removed';

  double get priceDiscount =>
      (price * (1 - discountPercent / 100) - discountAmount);

  double get totalPriceDiscount => numberUnit * priceDiscount;

  double get totalCost =>
      numberUnit * (beerSubmitData?.listUnit?.firstOrNull?.buyPrice ?? 0);

  String get priceDiscountFormat => MoneyFormater.format(priceDiscount);

  int get getWholesaleNumber => beerSubmitData?.getWholesaleNumber ?? 0;

  double get getWholesalePrice => beerSubmitData?.getWholesalePrice ?? 0;

  double get getPrice => beerSubmitData?.getPrice ?? 0;

  bool get isWholesaleMode =>
      getWholesaleNumber > 0 && numberUnit > getWholesaleNumber;

  bool get isApplyWholesaleMode => price == getWholesalePrice;
}

@HiveType(typeId: 22)
class BuyerData extends Buyer {
  BuyerData({
    required super.id,
    required super.groupId,
    required super.createat,
    required super.deviceId,
    required super.regionId,
    required super.districtId,
    required super.wardId,
    required super.realPrice,
    required super.totalPrice,
    required super.shipPrice,
    required super.discount,
    required super.point,
    required this.region,
    required this.district,
    required this.ward,
    required super.reciverFullname,
    required super.phoneNumberClean,
    required super.phoneNumber,
    required super.reciverAddress,
    required super.status,
  });
  BuyerData.simpleData({
    required this.region,
    required this.district,
    required this.ward,
  }) : super(
          id: 0,
          groupId: groupID,
          createat: '',
          deviceId: '',
          regionId: 0,
          districtId: 0,
          wardId: 0,
          realPrice: 0.0,
          totalPrice: 0.0,
          shipPrice: 0.0,
          discount: 0.0,
          point: 0,
        );

  @HiveField(18)
  late String? region;

  @HiveField(19)
  late String? district;

  @HiveField(20)
  late String? ward;

  BuyerData.uknowBuyer()
      : super(
          id: 0,
          groupId: groupID,
          createat: null,
          deviceId: '',
          regionId: 0,
          districtId: 0,
          wardId: 0,
          realPrice: 0,
          totalPrice: 0,
          shipPrice: 0,
          discount: 0,
          point: 0,
        ) {
    reciverFullname = 'Khách lẻ';
    phoneNumber = phoneNumberClean = 'Khách ngẫu nhiên';
  }

  bool get isUnknowUser => deviceId == '';

  void updateData(AddressData data) {
    deviceId = data.deviceID;
    phoneNumber = data.phoneNumber;
    reciverFullname = data.reciverFullName;
    reciverAddress = data.houseNumber;
    region = data.region.name;
    regionId = data.region.id;
    district = data.district.name;
    districtId = data.district.id;
    ward = data.ward.name;
    wardId = data.ward.id;
    totalPrice = data.getBuyerData?.totalPrice ?? 0;
    realPrice = data.getBuyerData?.realPrice ?? 0;
    shipPrice = data.getBuyerData?.shipPrice ?? 0;
    discount = data.getBuyerData?.discount ?? 0;
    point = data.getBuyerData?.point ?? 0;
  }

  void updateDeviceID(AddressData data) {
    if (deviceId.isEmpty) {
      deviceId = data.deviceID = generateUUID();
    }
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
          realPrice: 0,
          totalPrice: 0,
          shipPrice: 0,
          discount: 0,
          point: 0,
        ) {
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

  String? getAddressFormatNullable() {
    if (region == null) {
      return null;
    }
    if (region!.isEmpty) {
      return null;
    }
    return '${reciverAddress ?? ''}, ${ward ?? ''}, ${district ?? ''}, ${region ?? ''}';
  }

  String getAddressFormat() {
    if (region == null) {
      return 'Chọn địa chỉ';
    }
    if (region!.isEmpty) {
      return 'Chọn địa chỉ';
    }
    return '${reciverAddress ?? ''}, ${ward ?? ''}, ${district ?? ''}, ${region ?? ''}';
  }
}
