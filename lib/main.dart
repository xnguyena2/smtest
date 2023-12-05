import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/page/address/api/model/address_data.dart';
import 'package:sales_management/page/address/api/model/region.dart';
import 'package:sales_management/page/address/reciver_info.dart';
import 'package:sales_management/page/create_order/create_order_page.dart';
import 'package:sales_management/page/home/api/home_api.dart';
import 'package:sales_management/page/home/api/model/bootstrap.dart';
import 'package:sales_management/page/home/home_page.dart';
import 'package:sales_management/page/order_list/order_list_page.dart';
import 'package:sales_management/page/product_info/product_info.dart';
import 'package:sales_management/page/product_selector/product_selector_page.dart';
import 'package:sales_management/page/report/report_page.dart';
import 'package:sales_management/utils/storage_provider.dart';

import 'my_custom_scroll_behavior.dart';
import 'page/table/table_page.dart';
import 'utils/constants.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> setupHiveDB() async {
  await Hive.initFlutter();

  Hive.registerAdapter(ImagesAdapter());
  Hive.registerAdapter(BeerSubmitDataAdapter());
  Hive.registerAdapter(BeerUnitAdapter());
  Hive.registerAdapter(DateExpirAdapter());
  Hive.registerAdapter(BootStrapDataAdapter());
  Hive.registerAdapter(DeviceConfigAdapter());
  Hive.registerAdapter(BenifitByMonthAdapter());

  await Hive.openBox(hiveSettingBox);
  initData();
}

void initData() {
  loadBootstrap(groupID).then((value) {
    var box = Hive.box(hiveSettingBox);
    box.put(hiveConfigKey, value);
  });
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();

  await setupHiveDB();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => StorageProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(
          background: BackgroundColor,
          // primary: TableHighColor,
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
          headlineMedium: headStyleLargeWhite,
          titleLarge: TextStyle(fontSize: 36, fontStyle: FontStyle.italic),
          bodyMedium: headStyleLarge,
        ),
      ),
      home: ReportPage(),
    );
  }
}
