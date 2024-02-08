import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sales_management/api/local_storage/local_storage.dart';
import 'package:sales_management/api/storage/token_storage.dart';
import 'package:sales_management/api/token.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/page/account/api/model/token.dart';
import 'package:sales_management/page/create_store/api/model/user.dart';
import 'package:sales_management/page/create_store/create_store_page.dart';
import 'package:sales_management/page/flash/api/flash_api.dart';
import 'package:sales_management/page/home/api/home_api.dart';
import 'package:sales_management/page/home/api/model/bootstrap.dart';
import 'package:sales_management/page/home/home_page.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/snack_bar.dart';
import 'package:sales_management/utils/svg_loader.dart';

Future<void> initData() async {
  BootStrapData? bootStrapData =
      haveInteret ? await loadBootstrap(groupID) : LocalStorage.getBootStrap();
  if (bootStrapData == null) {
    return;
  }
  haveTable = bootStrapData.store?.haveTable() ?? false;
  setGlobalValue(
      store_ame: bootStrapData.store?.name ?? '',
      groupId: groupID,
      phoneNumber: bootStrapData.store?.phone ?? '',
      device_id: deviceID);
  LocalStorage.setBootstrapData(bootStrapData);
}

Future<User?> loadData(bool isForApple) async {
  TokenStorage? tokenStorage =
      isForApple ? TokenStorage(token: testToken) : LocalStorage.getToken();
  if (tokenStorage == null) {
    return null;
  }
  setToken(tokenStorage.token);
  User? user =
      haveInteret == false ? LocalStorage.getUser() : await getMyInfomation();
  if (user == null) {
    return Future.error('User is null!!');
  }
  setGlobalValue(
      store_ame: '',
      groupId: user.groupId,
      phoneNumber: user.phone_number ?? '',
      device_id: user.username);
  if (haveInteret) {
    LocalStorage.putUser(user);
  }
  await initData();
  return user;
}

Future<User?> loadLocalData() async {
  TokenStorage? tokenStorage = LocalStorage.getToken();
  if (tokenStorage == null) {
    return null;
  }
  setToken(tokenStorage.token);
  User? user = LocalStorage.getUser();
  if (user == null) {
    return Future.error('User is null!!');
  }
  setGlobalValue(
      store_ame: '',
      groupId: user.groupId,
      phoneNumber: user.phone_number ?? '',
      device_id: user.username);
  await initData();
  return user;
}

class FlashPage extends StatelessWidget {
  const FlashPage({super.key});

  @override
  Widget build(BuildContext context) {
    loadData(false).then(
      (value) {
        if (value == null) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => CreateStorePage()),
              (Route<dynamic> route) => false);
          return;
        }
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false);
      },
    ).onError((error, stackTrace) {
      showAlert(context,
          'Đường truyền có vấn đề không thể kết nối với máy chủ!');
      changeInterNetStatus(false);
      loadLocalData().then((value) => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false));
    });
    return FlashScreen();
  }
}

class FlashScreen extends StatelessWidget {
  const FlashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: Container(
          color: White,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      LoadSvg(assetPath: 'svg/logo.svg'),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Version: ${appVersion}'),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Đang tải..'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
