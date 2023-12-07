import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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

class FlashPage extends StatelessWidget {
  const FlashPage({super.key});

  Future<void> initData() async {
    await loadBootstrap(groupID).then((value) {
      var box = Hive.box(hiveSettingBox);
      box.put(hiveConfigKey, value);
    });
  }

  Future<int> loadData() async {
    var box = Hive.box(hiveSettingBox);
    TokenStorage? tokenStorage =
        TokenStorage(token: token); // box.get(hiveTokenKey);
    if (tokenStorage != null) {
      setToken(tokenStorage.token);
      User user = await getMyInfomation();
      print(user.toJson());
      await initData();
      return 1;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return FetchAPI<int>(
      future: loadData(),
      successBuilder: (int) {
        if (int == 0) {
          return CreateStorePage();
        }
        return HomePage();
      },
      loading: FlashScreen(),
    );
  }
}

class FlashScreen extends StatelessWidget {
  const FlashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: White,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadSvg(assetPath: 'svg/logo.svg'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
