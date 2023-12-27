import 'dart:collection';

import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/api/model/package/buyer.dart';
import 'package:sales_management/api/model/package/package_detail.dart';
import 'package:sales_management/api/model/package/user_package.dart';
import 'package:sales_management/page/address/api/model/address_data.dart';
import 'package:sales_management/page/transaction/api/model/payment_transaction.dart';
import 'package:sales_management/page/transaction/api/transaction_api.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/utils.dart';

enum PaymentStatus {
  DONE,
  MAKE_SOME_PAY,
  NOT_PAY,
}

class WrapListFilter {
  final String filter;
  final ListPackageDetailResult listPackageDetailResult;

  WrapListFilter({
    required this.listPackageDetailResult,
    required this.filter,
  });

  List<PackageDataResponse> getListResult() {
    if (filter.isEmpty) return listPackageDetailResult.listResult;
    return listPackageDetailResult.listResult
        .where((e) =>
            e.tableName?.contains(filter) == true ||
            e.buyer?.reciverFullname?.contains(filter) == true)
        .toList();
  }
}

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

  void addNewOrder(PackageDataResponse newO) {
    listResult.add(newO);
  }
}

class PackageDataResponse extends PackageDetail {
  PackageDataResponse({
    required this.items,
    required this.buyer,
  })  : localTimeTxt = formatLocalDateTimeOfDateTime(DateTime.now().toUtc()),
        super(
          id: 0,
          groupId: groupID,
          createat: getCreateAtNow(),
          packageSecondId: generateUUID(),
          deviceId: deviceID,
          price: 0.0,
          cost: 0.0,
          profit: 0.0,
          payment: 0.0,
          discountAmount: 0.0,
          discountPercent: 0.0,
          shipPrice: 0.0,
          status: PackageStatusType.CREATE,
        );

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
    updatePrice();
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
    if (payment >= finalPrice && isDone) {
      return PaymentStatus.DONE; //'Đã thanh toán';
    }
    if (payment > 0) {
      return PaymentStatus.MAKE_SOME_PAY; //'Thanh toán một phần';
    }
    return PaymentStatus.NOT_PAY; //'Chưa thanh toán';
  }

  void addtransaction(
    double payment,
    String type,
    String detail,
  ) {
    createTransaction(PaymentTransaction(
            groupId: groupId,
            transaction_second_id: null,
            packageSecondId: packageSecondId,
            amount: payment,
            category: 'Bán hàng',
            money_source: 'Tiền mặt',
            device_id: deviceId,
            note: detail,
            transaction_type: TType.INCOME))
        .then((value) {
      print('make transaction success');
    });
    super.addtransaction(payment, type, detail);
  }

  void makeDone() {
    if (payment < finalPrice) {
      print('payment: $payment, finalPrice: $finalPrice');
      addtransaction(
          finalPrice - payment, 'Tiền mặt', 'Hoàn thành đơn: $id');
    }
    donePayment();
  }

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
