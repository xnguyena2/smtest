class BaseID {
  late final String group_id;
  late final int page;
  late final int size;

  BaseID({
    required this.group_id,
    required this.page,
    required this.size,
  });

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['group_id'] = group_id;
    _data['page'] = page;
    _data['size'] = size;
    return _data;
  }
}
