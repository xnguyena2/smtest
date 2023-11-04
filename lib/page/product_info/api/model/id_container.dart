class IDContainer {
  late final String id;

  late final String groupId;

  IDContainer({
    required this.id,
    required this.groupId,
  });

  IDContainer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['group_id'] = groupId;
    return _data;
  }
}
