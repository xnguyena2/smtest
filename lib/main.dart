import 'package:flutter/material.dart';
import 'package:sales_management/page/home/home_page.dart';
import 'package:sales_management/page/product_selector/product_selector_page.dart';

import 'my_custom_scroll_behavior.dart';
import 'page/table/table_page.dart';
import 'utils/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
            .copyWith(background: BackgroundColor),
        useMaterial3: true,
        textTheme: const TextTheme(
          headlineMedium: headStyleLargeWhite,
          titleLarge: TextStyle(fontSize: 36, fontStyle: FontStyle.italic),
          bodyMedium: headStyleLarge,
        ),
      ),
      home: const TablePage(),
    );
  }
}
