import 'package:sales_management/page/home/api/model/benifit_of_order.dart';

class BenifitByDateHour extends BenifitOfOrder {
  BenifitByDateHour({
    required super.localTime,
    required super.price,
    required super.ship_price,
    required super.discount,
    required super.revenue,
    required super.profit,
    required super.cost,
    required super.count,
    required super.buyer,
    required super.discount_promotional,
    required super.discount_by_point,
    required super.return_price,
    required super.additional_fee,
  });

  BenifitByDateHour.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {}

  Map<String, dynamic> toJson() {
    final _data = super.toJson();
    return _data;
  }
}
