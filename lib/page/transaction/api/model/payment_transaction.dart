import 'package:sales_management/api/model/base_entity.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/utils.dart';

enum TType { INCOME, OUTCOME }

class PaymentTransaction extends BaseEntity {
  PaymentTransaction({
    required String groupId,
    required this.transaction_second_id,
    required this.amount,
    required this.category,
    required this.money_source,
    required this.transaction_type,
    this.note,
    this.status,
    this.packageSecondId,
    this.device_id,
  }) : super(id: null, groupId: groupId, createat: null);
  late String? transaction_second_id;
  late double amount;
  late String? device_id;
  late String? packageSecondId;
  late String? note;
  late String? category;
  late String? money_source;
  late final TType? transaction_type;
  late String? status;

  late final String onlyTime;

  PaymentTransaction.empty(TType type)
      : super(id: null, groupId: groupID, createat: getCreateAtNow()) {
    transaction_second_id = generateUUID();
    amount = 0;
    device_id = deviceID;
    packageSecondId = null;
    note = null;
    category = null;
    money_source = null;
    transaction_type = type;
    status = null;

    onlyTime = formatLocalDateTimeOnlyTime(createat);
  }

  PaymentTransaction.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    transaction_second_id = json['transaction_second_id'];
    device_id = json['device_id'];
    packageSecondId = json['package_second_id'];
    amount = json['amount'] as double;
    note = json['note'];
    category = json['category'];
    money_source = json['money_source'];
    transaction_type = TType.values.firstWhere(
        (element) => element.name == json['transaction_type'],
        orElse: () => TType.INCOME);
    status = json['status'];

    onlyTime = formatLocalDateTimeOnlyTime(createat);
  }

  Map<String, dynamic> toJson() {
    final _data = super.toJson();
    _data['transaction_second_id'] = transaction_second_id;
    _data['device_id'] = device_id;
    _data['package_second_id'] = packageSecondId;
    _data['amount'] = amount;
    _data['note'] = note;
    _data['category'] = category;
    _data['money_source'] = money_source;
    _data['transaction_type'] = transaction_type?.name;
    _data['status'] = status;
    return _data;
  }

  String get getCategoryName =>
      category?.replaceAll('SELLING', 'Bán hàng') ?? 'unknow';

  String get getNote {
    if (note?.startsWith('DONE-') == true ||
        note?.startsWith('PAYMENT-') == true) {
      final orderID = note
              ?.toUpperCase()
              .replaceAll('DONE-', 'Hoàn thành đơn: ')
              .replaceAll('PAYMENT-', 'Thanh toán đơn: ') ??
          'unknow';
      return orderID.split('-')[0];
    }
    return note ?? 'unknow';
  }

  String get getSourceMoney {
    if (note?.startsWith('DONE-') == true ||
        note?.startsWith('PAYMENT-') == true) {
      return money_source ?? 'Tiền mặt';
    }
    return money_source ?? 'unknow';
  }

  PaymentTransaction clone() {
    return PaymentTransaction.fromJson(toJson());
  }
}
