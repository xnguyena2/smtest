class BenifitByDateOfMonth {
  BenifitByDateOfMonth({
    required this.localTime,
    required this.price,
    required this.ship_price,
    required this.discount,
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

  BenifitByDateOfMonth.fromJson(Map<String, dynamic> json) {
    localTime = json['local_time'];
    price = json['price'] as double;
    ship_price = json['ship_price'] as double;
    discount = json['discount'] as double;
    revenue = json['revenue'] as double;
    profit = json['profit'] as double;
    cost = json['cost'] as double;
    count = json['count'] as int;
    buyer = json['buyer'] as int;
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
    return _data;
  }
}
