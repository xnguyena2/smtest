class BenifitByProduct {
  BenifitByProduct({
    required this.product_name,
    required this.product_unit_name,
    required this.product_second_id,
    required this.product_unit_second_id,
    required this.revenue,
    required this.profit,
    required this.number_unit,
    required this.createat,
  });

  late final String? product_name;
  late final String? product_unit_name;
  late final String product_second_id;
  late final String product_unit_second_id;
  late final double revenue;
  late final double profit;
  late final int number_unit;
  late final String? createat;

  BenifitByProduct.fromJson(Map<String, dynamic> json) {
    product_name = json['product_name'];
    product_unit_name = json['product_unit_name'];
    product_second_id = json['product_second_id'];
    product_unit_second_id = json['product_unit_second_id'];
    revenue = json['revenue'] as double;
    profit = json['profit'] as double;
    number_unit = json['number_unit'] as int;
    createat = json['createat'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_name'] = product_name;
    _data['product_unit_name'] = product_unit_name;
    _data['product_second_id'] = product_second_id;
    _data['product_unit_second_id'] = product_unit_second_id;
    _data['revenue'] = revenue;
    _data['profit'] = profit;
    _data['number_unit'] = number_unit;
    _data['createat'] = createat;
    return _data;
  }
}
