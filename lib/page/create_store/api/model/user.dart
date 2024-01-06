import 'package:hive/hive.dart';
import 'package:sales_management/api/model/base_entity.dart';

part 'user.g.dart';

@HiveType(typeId: 12)
class User extends BaseEntity {
  User({
    required this.username,
    required super.id,
    required super.groupId,
    required super.createat,
    this.password,
    this.createby,
    this.phone_number,
    this.phone_number_clean,
  });

  @HiveField(4)
  late final String username;

  @HiveField(5)
  late final String? password;

  @HiveField(6)
  late final String? createby;

  @HiveField(7)
  late final String? phone_number;

  @HiveField(8)
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
