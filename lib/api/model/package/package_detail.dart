import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:sales_management/api/model/base_entity.dart';
import 'package:sales_management/api/model/package/transaction.dart';
import 'package:sales_management/page/table/api/model/area_table.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/utils.dart';

part 'package_detail.g.dart';

@HiveType(typeId: 15)
enum DeliverType {
  @HiveField(0)
  deliver,

  @HiveField(1)
  takeaway,

  @HiveField(2)
  table
}

@HiveType(typeId: 13)
enum PackageStatusType {
  @HiveField(0)
  CREATE,

  @HiveField(1)
  DONE,

  @HiveField(2)
  DELETE,

  @HiveField(3)
  CANCEL,

  @HiveField(4)
  RETURN
}

@HiveType(typeId: 14)
class PackageDetail extends BaseEntity {
  @HiveField(4)
  late final String packageSecondId;

  @HiveField(5)
  late final String? deviceId;

  @HiveField(6)
  late final String? staff_id;

  @HiveField(7)
  late String? areaId;

  @HiveField(8)
  late String? areaName;

  @HiveField(9)
  late String? tableId;

  @HiveField(10)
  late String? tableName;

  @HiveField(11)
  late DeliverType packageType;

  @HiveField(12)
  late final String? voucher;

  @HiveField(13)
  late double price;

  @HiveField(14)
  late double payment;

  @HiveField(15)
  late double discountAmount;

  @HiveField(16)
  late double discountPercent;

  @HiveField(17)
  late double shipPrice;

  @HiveField(18)
  late double cost;

  @HiveField(19)
  late double profit;

  @HiveField(20)
  late int point;

  @HiveField(21)
  late String? note;

  @HiveField(22)
  late final String? image;

  @HiveField(23)
  late Progress? progress;

  @HiveField(24)
  late PackageStatusType? status;

  @HiveField(28)
  late double? discountPromotional;

  @HiveField(29)
  late double? discountByPoint;

  @HiveField(30)
  late double? additionalFee;

  @HiveField(31)
  late AdditionalFeeConfig? additionalConfig;

  PackageDetail({
    required int? id,
    required String groupId,
    String? createat,
    required this.packageSecondId,
    required this.deviceId,
    required this.staff_id,
    required this.price,
    required this.payment,
    required this.discountAmount,
    required this.discountPercent,
    required this.discountPromotional,
    required this.discountByPoint,
    required this.shipPrice,
    required this.cost,
    required this.profit,
    required this.point,
    required this.packageType,
    required this.additionalFee,
    required this.additionalConfig,
    this.areaId,
    this.areaName,
    this.tableId,
    this.tableName,
    this.voucher,
    this.note,
    this.image,
    this.progress,
    this.status,
  }) : super(id: id, groupId: groupId, createat: createat);

  PackageDetail.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    packageSecondId = json['package_second_id'];
    deviceId = json['device_id'];
    staff_id = json['staff_id'];
    packageType = DeliverType.values.firstWhere(
        (element) => element.name == json['package_type'],
        orElse: () => DeliverType.table);
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
    cost = json['cost'] as double;
    profit = json['profit'] as double;
    point = castToInt(json['point']);
    note = json['note'];
    image = json['image'];
    progress = json['progress'] == null
        ? Progress(transaction: [])
        : Progress.fromJson(jsonDecode(json['progress']));
    status = PackageStatusType.values.firstWhere(
        (element) => element.name == json['status'],
        orElse: () => PackageStatusType.CREATE);
    discountPromotional = castToDouble(json['discount_promotional']);
    discountByPoint = castToDouble(json['discount_by_point']);
    additionalFee = castToDouble(json['additional_fee']);
    additionalConfig = json['additional_config'] == null
        ? AdditionalFeeConfig(items: [])
        : AdditionalFeeConfig.fromJson(jsonDecode(json['additional_config']));
  }

  Map<String, dynamic> toJson() {
    final _data = super.toJson();
    _data['package_second_id'] = packageSecondId;
    _data['device_id'] = deviceId;
    _data['staff_id'] = staff_id;
    _data['area_id'] = areaId;
    _data['area_name'] = areaName;
    _data['table_id'] = tableId;
    _data['table_name'] = tableName;
    _data['package_type'] = packageType.name;
    _data['voucher'] = voucher;
    _data['price'] = price;
    _data['payment'] = payment;
    _data['discount_amount'] = discountAmount;
    _data['discount_percent'] = discountPercent;
    _data['ship_price'] = shipPrice;
    _data['cost'] = cost;
    _data['profit'] = profit;
    _data['point'] = point;
    _data['note'] = note;
    _data['image'] = image;
    _data['progress'] = progress?.toJsonString();
    _data['status'] = status?.name;
    _data['discount_promotional'] = discountPromotional;
    _data['discount_by_point'] = discountByPoint;
    _data['additional_fee'] = additionalFee;
    _data['additional_config'] = additionalConfig?.toJsonString();
    return _data;
  }

  void setTable(TableDetailData table) {
    table.setPackageID = packageSecondId;
    areaId = table.areaId;
    areaName = table.detail;
    tableId = table.tableId;
    tableName = table.tableName;
    // setAction(() => setPackageId(table));
  }

  bool get isDone => status == PackageStatusType.DONE;

  bool get haveTransaction => progress?.transaction?.isNotEmpty == true;

  void donePayment() {
    status = PackageStatusType.DONE;
  }

  String get areAndTable => packageType != DeliverType.table
      ? 'NOT'
      : areaName == null || tableName == null
          ? 'Chưa có bàn được chọn'
          : '${areaName} - ${tableName}';

  String get priceFormat => MoneyFormater.format(price);

  double get finalPrice {
    final firstfinalPrice =
        price * (1 - discountPercent / 100) - discountAmount + shipPrice;
    if (isAdditionalFeePercent) {
      additionalFee = firstfinalPrice * getAdditionalFeeValue / 100;
    }
    return firstfinalPrice + (additionalFee ?? 0);
  }

  String get finalPriceFormat => MoneyFormater.format(finalPrice);

  double get orderDiscount => price * (discountPercent / 100) + discountAmount;

  String get orderDiscountFormat => MoneyFormater.format(orderDiscount);

  bool get isAdditionalFeePercent {
    final firstDiscount = additionalConfig?.items.firstOrNull;
    if (firstDiscount == null) {
      return false;
    }
    return firstDiscount.isDiscountPercent;
  }

  double get getAdditionalFeeValue {
    final firstDiscount = additionalConfig?.items.firstOrNull;
    if (firstDiscount == null) {
      return 0;
    }
    return firstDiscount.amount;
  }

  void setAdditionalFee(double amount, bool isPercent) {
    additionalFee = 0;
    if (isPercent) {
      additionalFee = finalPrice * (amount / 100);
    } else {
      additionalFee = amount;
    }
    additionalConfig ??= AdditionalFeeConfig(items: []);
    if (additionalConfig!.items.isEmpty) {
      additionalConfig?.items
          .add(AdditionalFeeItem(amount: amount, isDiscountPercent: isPercent));
      return;
    }
    additionalConfig?.items.first.amount = amount;
    additionalConfig?.items.first.isDiscountPercent = isPercent;
  }

  VoidCallback? beforeUpdate;

  void setAction(VoidCallback beforeUpdate) {
    this.beforeUpdate = beforeUpdate;
  }

  void runPendingAction() {
    if (packageType != DeliverType.table) {
      tableId = null;
    }
    beforeUpdate?.call();
    beforeUpdate = null;
  }

  void addtransaction(
    double payment,
    String type,
    String detail,
  ) {
    progress ??= Progress(transaction: []);
    progress!.addTransaction(groupId, packageSecondId, payment, type, detail);
    this.payment += payment;
    this.profit = this.payment - cost;
  }

  void removeLastestTransaction() {
    double undoPrice = progress?.removeLastestTransaction()?.payment ?? 0;
    this.payment -= undoPrice;
    this.profit = payment - cost;
  }

  void markDeletedOrder() {
    status = PackageStatusType.DELETE;
  }

  bool isDeleted() => status == PackageStatusType.DELETE;
}

@HiveType(typeId: 17)
class Progress {
  @HiveField(0)
  late List<TransactionHistory>? transaction;

  Progress({
    required this.transaction,
  });

  void addTransaction(
    String groupID,
    String packageSecondId,
    double payment,
    String type,
    String detail,
  ) {
    transaction ??= [];
    transaction!.add(
      TransactionHistory(
          id: 0,
          groupId: groupID,
          createat:
              DateFormat("y-MM-ddThh:mm:ss.S").format(DateTime.now().toUtc()),
          packageSecondId: packageSecondId,
          payment: payment,
          type: type,
          detail: detail),
    );
  }

  TransactionHistory? removeLastestTransaction() {
    return transaction?.removeLast();
  }

  Progress.fromJson(Map<String, dynamic> json) {
    final listP = json['transaction'];
    transaction = listP == null
        ? null
        : List.from(listP).map((e) => TransactionHistory.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['transaction'] = transaction?.map((e) => e.toJson()).toList();
    return _data;
  }

  String toJsonString() {
    return jsonEncode(this);
  }
}

@HiveType(typeId: 23)
class AdditionalFeeConfig {
  @HiveField(0)
  late List<AdditionalFeeItem> items;

  AdditionalFeeConfig({
    required this.items,
  });

  void addFee(double amount, bool is_discount_percent) {
    items.add(
      AdditionalFeeItem(amount: amount, isDiscountPercent: is_discount_percent),
    );
  }

  void clean() {
    return items.clear();
  }

  AdditionalFeeConfig.fromJson(Map<String, dynamic> json) {
    final listP = json['items'];
    items = listP == null
        ? []
        : List.from(listP).map((e) => AdditionalFeeItem.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['items'] = items.map((e) => e.toJson()).toList();
    return _data;
  }

  String toJsonString() {
    return jsonEncode(this);
  }
}

@HiveType(typeId: 24)
class AdditionalFeeItem {
  @HiveField(0)
  late double amount;

  @HiveField(1)
  late bool isDiscountPercent;

  AdditionalFeeItem({
    required this.amount,
    required this.isDiscountPercent,
  });

  AdditionalFeeItem.fromJson(Map<String, dynamic> json) {
    amount = castToDouble(json['amount']);
    isDiscountPercent = json['is_discount_percent'] as bool;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['amount'] = amount;
    _data['is_discount_percent'] = isDiscountPercent;
    return _data;
  }

  String toJsonString() {
    return jsonEncode(this);
  }
}
