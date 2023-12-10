import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/page/create_order/create_order_page.dart';
import 'package:sales_management/page/flash/flash.dart';
import 'package:sales_management/page/home/api/model/bootstrap.dart';
import 'package:sales_management/page/home/child/management.dart';
import 'package:sales_management/page/report/report_page.dart';
import 'package:sales_management/utils/constants.dart';

import '../../utils/svg_loader.dart';
import 'compoment/home_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget page = Management();
    return RefreshIndicator(
      onRefresh: () async {
        return initData();
      },
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: Color(0xFF1F6C98),
          appBar: HomeAppBar(),
          bottomNavigationBar: BottomBar(),
          body: page,
        ),
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      height: 46 + bottomPadding,
      padding: EdgeInsets.only(bottom: bottomPadding),
      decoration: const BoxDecoration(color: White, boxShadow: [wholeShadow]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadSvg(assetPath: 'svg/home_bar.svg'),
                const Text(
                  'Quản lý',
                  style: subInfoStySmall,
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateOrderPage(
                    data: PackageDataResponse(items: [], buyer: null),
                    onUpdated: (package) {},
                    onDelete: (PackageDataResponse) {},
                  ),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadSvg(assetPath: 'svg/plus_bar.svg'),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReportPage(),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadSvg(assetPath: 'svg/in_out_bar.svg'),
                const Text(
                  'Thu chi',
                  style: subInfoStySmall,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
