class BenifitByDateOfMonth {
  BenifitByDateOfMonth({
    required this.localTime,
    required this.revenue,
    required this.profit,
    required this.cost,
  });

  late final String localTime;

  late double revenue;

  late final double profit;

  late final double cost;

  BenifitByDateOfMonth.fromJson(Map<String, dynamic> json) {
    localTime = json['local_time'];
    revenue = json['revenue'] as double;
    profit = json['profit'] as double;
    cost = json['cost'] as double;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['local_time'] = localTime;
    _data['revenue'] = revenue;
    _data['profit'] = profit;
    _data['cost'] = cost;
    return _data;
  }
}
