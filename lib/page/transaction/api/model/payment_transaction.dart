import 'package:sales_management/api/model/base_entity.dart';

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
  late final String? category;
  late final String? money_source;
  late final TType? transaction_type;
  late final String? status;

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

  // TableDetailData clone() {
  //   return TableDetailData.fromJson(toJson());
  // }
}
