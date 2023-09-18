class UserInfoQuery {
  late final String group_id;
  late final String id;
  late final int page;
  late final int size;

  UserInfoQuery(
      {required this.group_id,
      required this.page,
      required this.size,
      required this.id});

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['group_id'] = group_id;
    _data['id'] = id;
    _data['page'] = page;
    _data['size'] = size;
    return _data;
  }
}
