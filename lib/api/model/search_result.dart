import 'package:sales_management/api/model/result_interface.dart';

class SearchResult<T extends ResultInterface> {
  SearchResult({
    required this.count,
    this.searchTxt,
    required this.result,
    required this.normalSearch,
  });
  late final int count;
  late final String? searchTxt;
  late final List<T> result;
  late final bool normalSearch;

  SearchResult.fromJson(Map<String, dynamic> json) {
    count = (json['count'] as double).toInt();
    searchTxt = json['searchTxt'];
    result = List.from(json['result'])
        .map((e) => ResultInterface.fromJson<T>(e))
        .toList();
    normalSearch = json['normalSearch'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['count'] = count;
    _data['searchTxt'] = searchTxt;
    _data['result'] = result.map((e) => e.toJson()).toList();
    _data['normalSearch'] = normalSearch;
    return _data;
  }
}
