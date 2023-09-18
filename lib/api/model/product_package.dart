class ProductPackage {
  ProductPackage({
    required this.group_id,
    required this.deviceID,
    required this.beerID,
    required this.beerUnits,
  });
  late final String group_id;
  late final String deviceID;
  late final String beerID;
  late final List<BeerUnits> beerUnits;

  ProductPackage.fromJson(Map<String, dynamic> json) {
    group_id = json['group_id'];
    deviceID = json['deviceID'];
    beerID = json['beerID'];
    beerUnits =
        List.from(json['beerUnits']).map((e) => BeerUnits.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['group_id'] = group_id;
    _data['deviceID'] = deviceID;
    _data['beerID'] = beerID;
    _data['beerUnits'] = beerUnits.map((e) => e.toJson()).toList();
    return _data;
  }
}

class BeerUnits {
  BeerUnits({
    required this.beerUnitID,
    required this.numberUnit,
  });
  late final String beerUnitID;
  late final int numberUnit;

  BeerUnits.fromJson(Map<String, dynamic> json) {
    beerUnitID = json['beerUnitID'];
    numberUnit = json['numberUnit'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['beerUnitID'] = beerUnitID;
    _data['numberUnit'] = numberUnit;
    return _data;
  }
}
