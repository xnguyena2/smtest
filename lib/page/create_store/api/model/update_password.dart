class UpdatePassword {
  UpdatePassword({
    required this.username,
    required this.oldpassword,
    required this.newpassword,
    required this.group_id,
    required this.phone_number,
    required this.roles,
  });

  late final String username;
  late String oldpassword;
  late String newpassword;
  late final String group_id;
  late final String phone_number;
  late final List<String> roles;

  UpdatePassword.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    oldpassword = json['oldpassword'];
    newpassword = json['newpassword'];
    group_id = json['group_id'];
    roles = json['roles'];
    phone_number = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['oldpassword'] = oldpassword;
    _data['newpassword'] = newpassword;
    _data['group_id'] = group_id;
    _data['roles'] = roles;
    _data['phone_number'] = phone_number;
    return _data;
  }
}