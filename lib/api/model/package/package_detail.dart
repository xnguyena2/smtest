import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sales_management/api/model/base_entity.dart';
import 'package:sales_management/api/model/package/transaction.dart';
import 'package:sales_management/page/table/api/model/area_table.dart';
import 'package:sales_management/page/table/api/table_api.dart';
import 'package:sales_management/utils/constants.dart';

enum DeliverType { deliver, takeaway, table }

enum PackageStatusType { CREATE, DONE }

class PackageDetail extends BaseEntity {
  late final String packageSecondId;
  late final String? deviceId;
  late String? areaId;
  late String? areaName;
  late String? tableId;
  late String? tableName;
  late DeliverType packageType;
  late final String? voucher;
  late double price;
  late double payment;
  late double discountAmount;
  late double discountPercent;
  late double shipPrice;
  late double cost;
  late double profit;
  late String? note;
  late final String? image;
  late Progress? progress;
  late PackageStatusType? status;

  PackageDetail({
    required int? id,
    required String groupId,
    String? createat,
    required this.packageSecondId,
    required this.deviceId,
    required this.price,
    required this.payment,
    required this.discountAmount,
    required this.discountPercent,
    required this.shipPrice,
    required this.cost,
    required this.profit,
    this.areaId,
    this.areaName,
    this.tableId,
    this.tableName,
    this.packageType = DeliverType.table,
    this.voucher,
    this.note,
    this.image,
    this.progress,
    this.status,
  }) : super(id: id, groupId: groupId, createat: createat);

  PackageDetail.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    packageSecondId = json['package_second_id'];
    deviceId = json['device_id'];
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
    note = json['note'];
    image = json['image'];
    progress = json['progress'] == null
        ? Progress(transaction: [])
        : Progress.fromJson(jsonDecode(json['progress']));
    status = PackageStatusType.values.firstWhere(
        (element) => element.name == json['status'],
        orElse: () => PackageStatusType.CREATE);
  }

  Map<String, dynamic> toJson() {
    final _data = super.toJson();
    _data['package_second_id'] = packageSecondId;
    _data['device_id'] = deviceId;
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
    _data['note'] = note;
    _data['image'] = image;
    _data['progress'] = progress == null ? null : jsonEncode(progress);
    _data['status'] = status?.name;
    return _data;
  }

  void setTable(TableDetailData table) {
    table.setPackageID = this.packageSecondId;
    areaId = table.areaId;
    areaName = table.detail;
    tableId = table.tableId;
    tableName = table.tableName;
    setAction(() => setPackageId(table));
  }

  bool get isDone => status == PackageStatusType.DONE;

  void donePayment() {
    status = PackageStatusType.DONE;
  }

  String get areAndTable => packageType != DeliverType.table
      ? 'NOT'
      : areaName == null || tableName == null
          ? 'Chưa có bàn được chọn'
          : '${areaName} - ${tableName}';

  String get priceFormat => MoneyFormater.format(price);

  double get finalPrice =>
      price * (1 - discountPercent / 100) - discountAmount + shipPrice;

  String get finalPriceFormat => MoneyFormater.format(finalPrice);

  VoidCallback? beforeUpdate;

  void setAction(VoidCallback beforeUpdate) {
    this.beforeUpdate = beforeUpdate;
  }

  void runPendingAction() {
    if (packageType != DeliverType.table) {
      tableId = null;
    }
    this.beforeUpdate?.call();
    this.beforeUpdate = null;
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
}

class Progress {
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
}
