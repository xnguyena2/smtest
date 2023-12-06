import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/page/create_order/create_order_page.dart';
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
  Future<BenifitByMonth?> getBenifitOfMonth(Box<dynamic> box) async {
    BootStrapData? config = box.get(hiveConfigKey);
    if (config == null) {
      return null;
    }

    return config.benifit;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable:
          Hive.box(hiveSettingBox).listenable(keys: [hiveConfigKey]),
      builder: (BuildContext context, Box<dynamic> value, Widget? child) {
        return FetchAPI<BenifitByMonth?>(
          future: getBenifitOfMonth(value),
          successBuilder: (benifitByMonth) {
            Widget page = Management(
              benifitByMonth: benifitByMonth,
            );
            return SafeArea(
              child: Scaffold(
                appBar: HomeAppBar(),
                bottomNavigationBar: BottomBar(),
                body: page,
              ),
            );
          },
        );
      },
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
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
