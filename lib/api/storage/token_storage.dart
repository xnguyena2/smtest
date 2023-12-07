import 'package:hive/hive.dart';

part 'token_storage.g.dart';

@HiveType(typeId: 8)
class TokenStorage {
  TokenStorage({
    required this.token,
  });

  @HiveField(0)
  late final String token;

  TokenStorage.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['token'] = token;
    return _data;
  }
}
