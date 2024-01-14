class BenifitByOrderOfMonth {
  BenifitByOrderOfMonth({
    required this.createat,
    required this.package_second_id,
    required this.price,
    required this.revenue,
    required this.ship_price,
  });

  late final String createat;
  late final String package_second_id;
  late final double revenue;
  late final double price;
  late final double ship_price;

  BenifitByOrderOfMonth.fromJson(Map<String, dynamic> json) {
    createat = json['createat'];
    package_second_id = json['package_second_id'];
    revenue = json['revenue'] as double;
    price = json['price'] as double;
    ship_price = json['ship_price'] as double;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['createat'] = createat;
    _data['package_second_id'] = package_second_id;
    _data['revenue'] = revenue;
    _data['price'] = price;
    _data['ship_price'] = ship_price;
    return _data;
  }
}
