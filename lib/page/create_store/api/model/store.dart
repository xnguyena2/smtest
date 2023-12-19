import 'package:hive/hive.dart';
import 'package:sales_management/api/model/base_entity.dart';

part 'store.g.dart';

@HiveType(typeId: 9)
class Store extends BaseEntity {
  Store({
    required super.id,
    required super.groupId,
    required super.createat,
    required this.name,
    required this.time_open,
    required this.address,
    required this.phone,
    required this.status,
  });

  @HiveField(4)
  late String name;

  @HiveField(5)
  late String? time_open;

  @HiveField(6)
  late String? address;

  @HiveField(7)
  late String? phone;

  @HiveField(8)
  late final String? status;

  Store.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    name = json['name'];
    time_open = json['time_open'];
    address = json['address'];
    phone = json['phone'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = super.toJson();
    _data['name'] = name;
    _data['time_open'] = time_open;
    _data['address'] = address;
    _data['phone'] = phone;
    _data['status'] = status;
    return _data;
  }
}
