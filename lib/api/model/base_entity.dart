import 'package:hive/hive.dart';

class BaseEntity {
  @HiveField(0)
  late final int? id;

  @HiveField(2)
  late final String groupId;

  @HiveField(3)
  late String? createat;

  BaseEntity({
    required this.id,
    required this.groupId,
    required this.createat,
  });

  BaseEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    createat = json['createat'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['group_id'] = groupId;
    _data['createat'] = createat;
    return _data;
  }
}
