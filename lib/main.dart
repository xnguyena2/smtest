import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:sales_management/api/local_storage/local_storage.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/api/storage/token_storage.dart';
import 'package:sales_management/page/address/api/model/address_data.dart';
import 'package:sales_management/page/address/api/model/region.dart';
import 'package:sales_management/page/address/reciver_info.dart';
import 'package:sales_management/page/create_order/create_order_page.dart';
import 'package:sales_management/page/create_store/api/model/store.dart';
import 'package:sales_management/page/create_store/api/model/user.dart';
import 'package:sales_management/page/create_store/create_store_page.dart';
import 'package:sales_management/page/flash/flash.dart';
import 'package:sales_management/page/home/api/home_api.dart';
import 'package:sales_management/page/home/api/model/bootstrap.dart';
import 'package:sales_management/page/home/home_page.dart';
import 'package:sales_management/page/login_by_qr/login_by_qr.dart';
import 'package:sales_management/page/order_list/order_list_page.dart';
import 'package:sales_management/page/product_info/product_info.dart';
import 'package:sales_management/page/product_selector/product_selector_page.dart';
import 'package:sales_management/page/report/report_page.dart';
import 'package:sales_management/page/store_info/store_info_page.dart';
import 'package:sales_management/utils/storage_provider.dart';
import 'package:sales_management/utils/utils.dart';

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
  Hive.registerAdapter(TokenStorageAdapter());
  Hive.registerAdapter(StoreAdapter());
  Hive.registerAdapter(RequestStorageAdapter());
  Hive.registerAdapter(RequestTypeAdapter());
  Hive.registerAdapter(UserAdapter());

  await LocalStorage.openBox();
  LocalStorage.getDependRequest();
}

Future<void> checkInternetConnection() async {
  final connectivityResult = await (Connectivity().checkConnectivity());
  changeInterNetStatus(listenConnection(connectivityResult));
}

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: White,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();

  await checkInternetConnection();
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
      title: 'Sổ Điện Tử',
      debugShowCheckedModeBanner: false,
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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('vi', 'VN'), // Thai
      ],
      home: FlashPage(),
    );
  }
}
