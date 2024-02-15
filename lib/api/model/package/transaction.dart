import 'package:hive/hive.dart';
import 'package:sales_management/api/model/base_entity.dart';
import 'package:sales_management/utils/utils.dart';

part 'transaction.g.dart';

@HiveType(typeId: 16)
class TransactionHistory extends BaseEntity {
  @HiveField(4)
  late final String packageSecondId;

  @HiveField(5)
  late final double payment;

  @HiveField(6)
  late final String type;

  @HiveField(7)
  late final String detail;

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

  late final String localDateTxt;

  late final String localTimeTxt;
}
