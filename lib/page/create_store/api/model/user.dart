import 'package:sales_management/api/model/base_entity.dart';

class User extends BaseEntity {
  User({
    required this.username,
    required super.id,
    required super.groupId,
    required super.createat,
  });

  late final String username;
  late final String? password;
  late final String? createby;
  late final String? phone_number;
  late final String? phone_number_clean;

  User.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    username = json['username'];
    password = json['password'];
    createby = json['createby'];
    phone_number = json['phone_number'];
    phone_number_clean = json['phone_number_clean'];
  }

  Map<String, dynamic> toJson() {
    final _data = super.toJson();
    _data['username'] = username;
    _data['password'] = password;
    _data['createby'] = createby;
    _data['phone_number'] = phone_number;
    _data['phone_number_clean'] = phone_number_clean;
    return _data;
  }
}
