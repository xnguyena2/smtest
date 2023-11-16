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

  BootStrapData.fromJson(Map<String, dynamic> json) {
    carousel = List.from(json['carousel']).map((e) => e.toString()).toList();
    products = List.from(json['products'])
        .map((e) => BeerSubmitData.fromJson(e))
        .toList();
    deviceConfig = DeviceConfig.fromJson(json['deviceConfig']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['products'] = products.map((e) => e.toJson()).toList();
    _data['carousel'] = carousel;
    _data['deviceConfig'] = deviceConfig?.toJson();
    return _data;
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
