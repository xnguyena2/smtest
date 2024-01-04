import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sales_management/api/storage/token_storage.dart';
import 'package:sales_management/page/account/api/model/token.dart';
import 'package:sales_management/page/home/api/model/bootstrap.dart';
import 'package:sales_management/utils/utils.dart';

part 'local_storage.g.dart';

class LocalStorage {
  static const String hiveRequestDepend = 'requestDepend';
  static const String hiveRequest = 'request';

  static const String hiveSettingBox = 'settings';
  static const String hiveConfigKey = 'config';
  static const String hiveTokenKey = 'token';

  static Future<void> openBox() async {
    await Hive.openBox(hiveSettingBox);
    await Hive.openBox(hiveRequestDepend);
    await Hive.openBox(hiveRequest);
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

  static void cleanBox() {
    var box1 = Hive.box(hiveRequestDepend);
    var box2 = Hive.box(hiveRequest);
    var box3 = Hive.box(hiveSettingBox);
    box1.clear();
    box2.clear();
    box3.clear();
  }

  static void addDependRequest(
      RequestType type, String path, String id, String body) {
    var box = Hive.box(hiveRequestDepend);
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
    var box = Hive.box(hiveRequest);
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
    var box = Hive.box(hiveRequestDepend);
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
