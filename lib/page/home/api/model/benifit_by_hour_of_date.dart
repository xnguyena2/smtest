import 'package:sales_management/component/interface/report_interface.dart';

class BenifitByHoursOfDate implements ReportInterface {
  BenifitByHoursOfDate({
    required this.localTime,
    required this.revenue,
    required this.profit,
    required this.cost,
    required this.count,
    required this.buyer,
  });

  late final String localTime;

  late double price;

  late final double ship_price;

  late final double discount;

  late double revenue;

  late final double profit;

  late final double cost;

  late final int count;

  late final int buyer;

  BenifitByHoursOfDate.fromJson(Map<String, dynamic> json) {
    localTime = json['local_time'];
    revenue = json['revenue'] as double;
    profit = json['profit'] as double;
    cost = json['cost'] as double;
    count = json['count'] as int;
    buyer = json['buyer'] as int;
    price = json['price'] as double;
    ship_price = json['ship_price'] as double;
    discount = json['discount'] as double;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['local_time'] = localTime;
    _data['revenue'] = revenue;
    _data['profit'] = profit;
    _data['cost'] = cost;
    _data['count'] = count;
    _data['buyer'] = buyer;
    _data['price'] = price;
    _data['ship_price'] = ship_price;
    _data['discount'] = discount;
    return _data;
  }
}
