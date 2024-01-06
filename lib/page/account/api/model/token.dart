import 'package:sales_management/api/model/base_entity.dart';

class Token extends BaseEntity {
  late final String? tokenSecondId;
  late final String token;
  late final String? status;

  Token(
      {required this.token,
      required super.id,
      required super.groupId,
      required super.createat});

  Token.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    tokenSecondId = json['token_second_id'];
    token = json['token'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = super.toJson();
    _data['token_second_id'] = tokenSecondId;
    _data['token'] = token;
    _data['status'] = status;
    return _data;
  }
}
