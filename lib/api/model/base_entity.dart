class BaseEntity {
  late final String groupId;
  late final String? createat;
  BaseEntity({
    required this.groupId,
    required this.createat,
  });

  BaseEntity.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    createat = json['createat'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['group_id'] = groupId;
    _data['createat'] = createat;
    return _data;
  }
}
