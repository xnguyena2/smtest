import 'package:hive/hive.dart';
import 'package:sales_management/api/model/base_entity.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';

part 'bootstrap.g.dart';

@HiveType(typeId: 1)
class BootStrapData {
  BootStrapData({
    required this.products,
    required this.carousel,
    required this.deviceConfig,
  });
  @HiveField(0)
  late final List<BeerSubmitData> products;

  @HiveField(1)
  late final List<String> carousel;

  @HiveField(3)
  late final DeviceConfig? deviceConfig;

  @HiveField(4)
  late final BenifitByMonth benifit;

  BootStrapData.fromJson(Map<String, dynamic> json) {
    carousel = List.from(json['carousel']).map((e) => e.toString()).toList();
    products = List.from(json['products'])
        .map((e) => BeerSubmitData.fromJson(e))
        .toList();
    deviceConfig = DeviceConfig.fromJson(json['deviceConfig']);
    benifit = BenifitByMonth.fromJson(json['benifit']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['products'] = products.map((e) => e.toJson()).toList();
    _data['carousel'] = carousel;
    _data['deviceConfig'] = deviceConfig?.toJson();
    _data['benifit'] = benifit.toJson();
    return _data;
  }

  void addOrReplaceProduct(BeerSubmitData p) {
    int index = products
        .indexWhere((element) => element.beerSecondID == p.beerSecondID);
    if (index < 0) {
      products.add(p);
      return;
    }
    products[index] = p;
  }
}

@HiveType(typeId: 3)
class DeviceConfig extends BaseEntity {
  DeviceConfig({
    required super.groupId,
    this.color,
    super.id,
    super.createat,
    this.categorys,
    this.config,
  });
  @HiveField(4)
  late final String? color;

  @HiveField(5)
  late String? categorys;

  @HiveField(6)
  late final String? config;

  DeviceConfig.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    color = json['color'];
    categorys = json['categorys'];
    config = json['config'];
  }

  Map<String, dynamic> toJson() {
    final _data = super.toJson();
    _data.remove('id');
    _data['color'] = color;
    _data['categorys'] = categorys;
    _data['config'] = config;
    return _data;
  }
}

@HiveType(typeId: 7)
class BenifitByMonth {
  BenifitByMonth({
    required this.count,
    required this.revenue,
    required this.profit,
    required this.cost,
  });
  @HiveField(1)
  late final int count;

  @HiveField(2)
  late double revenue;

  @HiveField(3)
  late final double profit;

  @HiveField(4)
  late final double cost;

  BenifitByMonth.fromJson(Map<String, dynamic> json) {
    count = json['count'] as int;
    revenue = json['revenue'] as double;
    profit = json['profit'] as double;
    cost = json['cost'] as double;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['count'] = count;
    _data['revenue'] = revenue;
    _data['profit'] = profit;
    _data['cost'] = cost;
    return _data;
  }
}
