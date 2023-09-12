class SearchQuery {
  SearchQuery({
    required this.query,
    required this.page,
    required this.size,
    required this.filter,
    required this.group_id,
  });
  late final String group_id;
  late final String query;
  late final int page;
  late final int size;
  late final String filter;

  SearchQuery.fromJson(Map<String, dynamic> json) {
    group_id = json['group_id'];
    query = json['query'];
    page = json['page'];
    size = json['size'];
    filter = json['filter'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['group_id'] = group_id;
    _data['query'] = query;
    _data['page'] = page;
    _data['size'] = size;
    _data['filter'] = filter;
    return _data;
  }
}
