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
  static const String _hiveRequestDependBox = 'requestDepend';
  static const String _hiveRequestBox = 'request';
  static const String _hiveOrdersPackageBox = 'orderpackage';
  static const String _hiveSettingBox = 'settings';

  static const String _hiveConfigKey = 'config';
  static const String _hiveTokenKey = 'token';
  static const String _hiveUserInfoKey = 'userinfo';

  static Future<void> openBox() async {
    await Hive.openBox(_hiveSettingBox);
    await Hive.openBox(_hiveRequestDependBox);
    await Hive.openBox(_hiveRequestBox);
    await Hive.openBox(_hiveOrdersPackageBox);
  }

  static Future<void> cleanBox() async {
    await Hive.box(_hiveRequestDependBox).clear();
    await Hive.box(_hiveRequestBox).clear();
    await Hive.box(_hiveSettingBox).clear();
    await Hive.box(_hiveOrdersPackageBox).clear();
  }

  static void putUser(User user) {
    var box = Hive.box(_hiveSettingBox);
    box.put(
      _hiveUserInfoKey,
      user,
    );
  }

  static User? getUser() {
    var box = Hive.box(_hiveSettingBox);
    return box.get(_hiveUserInfoKey);
  }

  static Future<void> putOrderPakage(PackageDataResponse packageDataResponse) {
    var box = Hive.box(_hiveOrdersPackageBox);
    return box.put(
      packageDataResponse.packageSecondId,
      packageDataResponse,
    );
  }

  static Future<void> removeOrderPakageAndRequest(
      PackageDataResponse packageDataResponse) {
    var box = Hive.box(_hiveOrdersPackageBox);
    var boxRequest = Hive.box(_hiveRequestBox);
    final id = packageDataResponse.packageSecondId;

    return box.delete(id).then((value) => boxRequest.delete(id));
  }

  static Future<void> removeAllOrderPakageAndRequest() {
    var box = Hive.box(_hiveOrdersPackageBox);
    var boxRequest = Hive.box(_hiveRequestBox);

    return box.clear().then((value) => boxRequest.clear());
  }

  static List<PackageDataResponse> getOrderPakage() {
    var box = Hive.box(_hiveOrdersPackageBox);
    List<PackageDataResponse> allOrders = List.from(box.values);
    print('order package length: ${allOrders.length}');
    return allOrders;
  }

  static void putToken(Token token) {
    var box = Hive.box(_hiveSettingBox);
    box.put(
      _hiveTokenKey,
      TokenStorage(token: token.token),
    );
  }

  static TokenStorage? getToken() {
    var box = Hive.box(_hiveSettingBox);
    return box.get(_hiveTokenKey);
  }

  static void setBootstrapData(BootStrapData? value) {
    var box = Hive.box(_hiveSettingBox);
    box.put(_hiveConfigKey, value);
  }

  static BootStrapData? getBootStrap([Box<dynamic>? box]) {
    if (box != null) {
      return box.get(_hiveConfigKey);
    }
    var boxx = Hive.box(_hiveSettingBox);
    return boxx.get(_hiveConfigKey);
  }

  static ValueListenable<Box<dynamic>> getListenBootStrapKey() {
    return Hive.box(_hiveSettingBox).listenable(keys: [_hiveConfigKey]);
  }

  static void addDependRequest(
      RequestType type, String path, String id, String body) {
    var box = Hive.box(_hiveRequestDependBox);
    box.put(
      id,
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
    var box = Hive.box(_hiveRequestDependBox);
    List<RequestStorage> alRequest = List.from(box.values);
    print('depend request length: ${alRequest.length}');
  }

  static Future<void> addRequest(
      RequestType type, String path, String id, String body) {
    var box = Hive.box(_hiveRequestBox);
    return box.put(
      id,
      RequestStorage(
        type: type,
        path: path,
        id: id,
        body: body,
        timeStamp: currentTimeStampLocal(),
      ),
    );
  }

  static RequestStorage? getRequest(PackageDataResponse packageDataResponse) {
    var box = Hive.box(_hiveRequestBox);
    final id = packageDataResponse.packageSecondId;
    return box.get(id);
  }

  static List<RequestStorage> getAllRequest() {
    var box = Hive.box(_hiveRequestBox);
    List<RequestStorage> allRequests = List.from(box.values);
    print('request length: ${allRequests.length}');
    return allRequests;
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
