import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/api/storage/token_storage.dart';
import 'package:sales_management/page/account/api/model/token.dart';
import 'package:sales_management/page/create_store/api/model/user.dart';
import 'package:sales_management/page/home/api/model/bootstrap.dart';
import 'package:sales_management/utils/utils.dart';

part 'local_storage.g.dart';

class LocalStorage {
  static const String hiveRequestDependBox = 'requestDepend';
  static const String hiveRequestBox = 'request';
  static const String hiveOrdersPackageBox = 'orderpackage';
  static const String hiveSettingBox = 'settings';

  static const String hiveConfigKey = 'config';
  static const String hiveTokenKey = 'token';
  static const String hiveUserInfoKey = 'userinfo';

  static Future<void> openBox() async {
    await Hive.openBox(hiveSettingBox);
    await Hive.openBox(hiveRequestDependBox);
    await Hive.openBox(hiveRequestBox);
    await Hive.openBox(hiveOrdersPackageBox);
  }

  static Future<void> cleanBox() async {
    await Hive.box(hiveRequestDependBox).clear();
    await Hive.box(hiveRequestBox).clear();
    await Hive.box(hiveSettingBox).clear();
    await Hive.box(hiveOrdersPackageBox).clear();
  }

  static void putUser(User user) {
    var box = Hive.box(hiveSettingBox);
    box.put(
      hiveUserInfoKey,
      user,
    );
  }

  static User? getUser() {
    var box = Hive.box(hiveSettingBox);
    return box.get(hiveUserInfoKey);
  }

  static void putOrderPakage(PackageDataResponse packageDataResponse) {
    var box = Hive.box(hiveOrdersPackageBox);
    box.put(
      packageDataResponse.packageSecondId,
      packageDataResponse,
    );
  }

  static List<PackageDataResponse> getOrderPakage() {
    var box = Hive.box(hiveOrdersPackageBox);
    List<PackageDataResponse> allOrders = List.from(box.values);
    print('order package length: ${allOrders.length}');
    return allOrders;
  }

  static void putToken(Token token) {
    var box = Hive.box(hiveSettingBox);
    box.put(
      hiveTokenKey,
      TokenStorage(token: token.token),
    );
  }

  static TokenStorage? getToken() {
    var box = Hive.box(hiveSettingBox);
    return box.get(hiveTokenKey);
  }

  static void setBootstrapData(BootStrapData? value) {
    var box = Hive.box(hiveSettingBox);
    box.put(hiveConfigKey, value);
  }

  static BootStrapData? getBootStrap([Box<dynamic>? box]) {
    if (box != null) {
      return box.get(hiveConfigKey);
    }
    var boxx = Hive.box(hiveSettingBox);
    return boxx.get(hiveConfigKey);
  }

  static ValueListenable<Box<dynamic>> getListenBootStrapKey() {
    return Hive.box(hiveSettingBox).listenable(keys: [hiveConfigKey]);
  }

  static void addDependRequest(
      RequestType type, String path, String id, String body) {
    var box = Hive.box(hiveRequestDependBox);
    box.put(
      '${path}_$id',
      RequestStorage(
        type: type,
        path: path,
        id: id,
        body: body,
        timeStamp: currentTimeStampLocal(),
      ),
    );
  }

  static void addRequest(
      RequestType type, String path, String id, String body) {
    var box = Hive.box(hiveRequestBox);
    box.put(
      '${path}_$id',
      RequestStorage(
        type: type,
        path: path,
        id: id,
        body: body,
        timeStamp: currentTimeStampLocal(),
      ),
    );
  }

  static void getDependRequest() {
    var box = Hive.box(hiveRequestDependBox);
    List<RequestStorage> alRequest = List.from(box.values);
    print('depend request length: ${alRequest.length}');
  }
}

@HiveType(typeId: 11)
enum RequestType {
  @HiveField(0)
  POST_C,

  @HiveField(1)
  POST_E,

  @HiveField(2)
  DELETE_C,

  @HiveField(3)
  DELETE_E
}

@HiveType(typeId: 10)
class RequestStorage {
  @HiveField(0)
  final RequestType type;

  @HiveField(1)
  final String path;

  @HiveField(2)
  final String id;

  @HiveField(3)
  final String body;

  @HiveField(4)
  final int timeStamp;

  RequestStorage({
    required this.type,
    required this.path,
    required this.id,
    required this.body,
    required this.timeStamp,
  });
}
