import 'package:sales_management/api/model/base_entity.dart';
import 'package:sales_management/utils/utils.dart';

class TransactionHistory extends BaseEntity {
  late final String packageSecondId;
  late final double payment;
  late final String type;
  late final String detail;

  late final String localDateTxt;
  late final String localTimeTxt;

  TransactionHistory({
    required super.id,
    required super.groupId,
    required super.createat,
    required this.packageSecondId,
    required this.payment,
    required this.type,
    required this.detail,
  })  : localDateTxt = formatLocalDateTimeOnlyDate(createat),
        localTimeTxt = formatLocalDateTimeOnlyTime(createat);

  TransactionHistory.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    packageSecondId = json['package_second_id'];
    payment = json['payment'];
    type = json['type'];
    detail = json['detail'];
    localDateTxt = formatLocalDateTimeOnlyDate(createat);
    localTimeTxt = formatLocalDateTimeOnlyTime(createat);
  }

  Map<String, dynamic> toJson() {
    final _data = super.toJson();
    _data['package_second_id'] = packageSecondId;
    _data['payment'] = payment;
    _data['type'] = type;
    _data['detail'] = detail;
    return _data;
  }
}
