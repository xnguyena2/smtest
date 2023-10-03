import 'package:sales_management/api/model/base_id.dart';

class UserInfoQuery extends BaseID {
  late final String id;

  UserInfoQuery(
      {required String group_id,
      required int page,
      required int size,
      required this.id})
      : super(group_id: group_id, page: page, size: size);

  Map<String, dynamic> toJson() {
    final _data = super.toJson();
    _data['id'] = id;
    return _data;
  }
}
