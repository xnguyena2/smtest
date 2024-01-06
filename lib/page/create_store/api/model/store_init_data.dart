import 'package:sales_management/page/create_store/api/model/store.dart';
import 'package:sales_management/page/create_store/api/model/update_password.dart';
import 'package:sales_management/utils/vntone.dart';

class StoreInitData {
  StoreInitData({
    required this.store,
    required this.newAccount,
  });

  late Store store;
  late UpdatePassword newAccount;

  StoreInitData.fromStoreNameAndPhone({
    required String storeName,
    required String password,
    required String phone,
    required bool haveTable,
  }) {
    String storeNameClean = removeVNTones(storeName).replaceAll(' ', '_');
    String groupID = '${storeNameClean}_$phone';
    store = Store(
      id: null,
      groupId: groupID,
      createat: null,
      name: storeName,
      time_open: null,
      address: null,
      phone: phone,
      status: null,
      store_type: haveTable ? 'HAVETABLE' : 'DONTHAVETABLE',
    );
    newAccount = UpdatePassword(
        username: phone,
        oldpassword: '',
        newpassword: password,
        group_id: groupID,
        roles: [],
        phone_number: phone);
  }

  StoreInitData.fromJson(Map<String, dynamic> json) {
    store = Store.fromJson(json['store']);
    newAccount = UpdatePassword.fromJson(json['newAccount']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['store'] = store.toJson();
    _data['newAccount'] = newAccount.toJson();
    return _data;
  }
}
