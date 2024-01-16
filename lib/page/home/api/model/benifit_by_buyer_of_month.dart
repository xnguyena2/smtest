class BenifitByBuyerOfMonth {
  BenifitByBuyerOfMonth({
    required this.id,
    required this.name,
    required this.revenue,
    required this.count,
  });

  late final String? id;
  late final String? name;
  late final double revenue;
  late final int count;

  BenifitByBuyerOfMonth.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    revenue = json['revenue'] as double;
    count = json['count'] as int;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['revenue'] = revenue;
    _data['count'] = count;
    return _data;
  }
}
