class BaseEntity {
  late final int? id;
  late final String groupId;
  late final String? createat;
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
