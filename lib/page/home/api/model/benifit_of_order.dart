import 'package:sales_management/component/interface/report_interface.dart';
import 'package:sales_management/utils/utils.dart';

class BenifitOfOrder implements ReportInterface {
  BenifitOfOrder({
    required this.localTime,
    required this.price,
    required this.ship_price,
    required this.discount,
    required this.revenue,
    required this.profit,
    required this.cost,
    required this.count,
    required this.buyer,
    required this.discount_promotional,
    required this.discount_by_point,
    required this.return_price,
    required this.additional_fee,
  });

  late final String localTime;

  late double price;

  late final double ship_price;

  late final double discount;

  late double revenue;

  late double profit;

  late double cost;

  late final int count;

  late final int buyer;

  late final double discount_promotional;

  late final double discount_by_point;

  late final double return_price;

  late final double additional_fee;

  BenifitOfOrder.fromJson(Map<String, dynamic> json) {
    localTime = json['local_time'];
    price = json['price'] as double;
    ship_price = json['ship_price'] as double;
    discount = json['discount'] as double;
    revenue = json['revenue'] as double;
    profit = json['profit'] as double;
    cost = json['cost'] as double;
    count = json['count'] as int;
    buyer = json['buyer'] as int;
    discount_promotional = castToDouble(json['discount_promotional']);
    discount_by_point = castToDouble(json['discount_by_point']);
    return_price = castToDouble(json['return_price']);
    additional_fee = castToDouble(json['additional_fee']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['local_time'] = localTime;
    _data['ship_price'] = ship_price;
    _data['discount'] = discount;
    _data['price'] = price;
    _data['revenue'] = revenue;
    _data['profit'] = profit;
    _data['cost'] = cost;
    _data['count'] = count;
    _data['buyer'] = buyer;
    _data['discount_promotional'] = discount_promotional;
    _data['discount_by_point'] = discount_by_point;
    _data['return_price'] = return_price;
    _data['additional_fee'] = additional_fee;
    return _data;
  }
}
