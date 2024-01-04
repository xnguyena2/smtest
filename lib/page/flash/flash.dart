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
import 'package:sales_management/page/home/home_page.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

Future<void> initData() async {
  await loadBootstrap(groupID).then((value) {
    setGlobalValue(
        store_ame: value.store?.name ?? '',
        groupId: groupID,
        phoneNumber: value.store?.phone ?? '',
        device_id: deviceID);
    LocalStorage.setBootstrapData(value);
  });
}

Future<User?> loadData(bool isForApple) async {
  TokenStorage? tokenStorage =
      isForApple ? TokenStorage(token: testToken) : LocalStorage.getToken();
  if (tokenStorage == null) {
    return null;
  }
  setToken(tokenStorage.token);
  User user = await getMyInfomation();
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
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => CreateStorePage()),
          (Route<dynamic> route) => false);
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
