import 'package:hive/hive.dart';
import 'package:sales_management/api/model/base_entity.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';

part 'bootstrap.g.dart';

@HiveType(typeId: 1)
class BootStrapData {
  BootStrapData({
    required this.products,
    required this.carousel,
  });
  @HiveField(0)
  late final List<BeerSubmitData> products;

  @HiveField(1)
  late final List<String> carousel;

  BootStrapData.fromJson(Map<String, dynamic> json) {
    carousel = List.from(json['carousel']).map((e) => e.toString()).toList();
    products = List.from(json['products'])
        .map((e) => BeerSubmitData.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['products'] = products.map((e) => e.toJson()).toList();
    _data['carousel'] = carousel;
    return _data;
  }
}

class DeviceConfig extends BaseEntity {
  DeviceConfig({
    required String groupId,
    required this.color,
  }) : super(id: null, groupId: groupId, createat: null);
  late final String? color;
  late final String? categorys;
  late final String? config;

  DeviceConfig.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    color = json['color'];
    categorys = json['categorys'];
    config = json['config'];
  }

  Map<String, dynamic> toJson() {
    final _data = super.toJson();
    _data['color'] = color;
    _data['categorys'] = categorys;
    _data['config'] = config;
    return _data;
  }
}
