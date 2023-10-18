import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_management/page/address/api/model/address_data.dart';
import 'package:sales_management/page/address/api/model/region.dart';
import 'package:sales_management/page/address/reciver_info.dart';
import 'package:sales_management/page/create_order/create_order_page.dart';
import 'package:sales_management/page/home/home_page.dart';
import 'package:sales_management/page/order_list/order_list_page.dart';
import 'package:sales_management/page/product_info/product_info.dart';
import 'package:sales_management/page/product_selector/product_selector_page.dart';
import 'package:sales_management/utils/storage_provider.dart';

import 'my_custom_scroll_behavior.dart';
import 'page/table/table_page.dart';
import 'utils/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
      home: ReciverInfo(
        addressData: AddressData(
            addressID: 'addressID',
            deviceID: deviceID,
            reciverFullName: 'reciverFullName',
            phoneNumber: '',
            houseNumber: 'houseNumber',
            region: Region(name: 'name', id: -1),
            district: Region(name: 'name', id: -1),
            ward: Region(name: 'name', id: -1),
            regionTextFormat: 'regionTextFormat'),
        done: (data) {},
        delete: () {},
        isEdit: false,
      ),
    );
  }
}
