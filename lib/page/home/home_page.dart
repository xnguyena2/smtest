import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/page/create_order/create_order_page.dart';
import 'package:sales_management/page/flash/flash.dart';
import 'package:sales_management/page/home/api/model/bootstrap.dart';
import 'package:sales_management/page/home/child/income_outcome.dart';
import 'package:sales_management/page/home/child/management.dart';
import 'package:sales_management/page/report/report_page.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/typedef.dart';

import '../../utils/svg_loader.dart';
import 'compoment/home_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Widget page;
  final Widget homePage = Management();
  final Widget inoutPage = IncomeOutComme();
  int currentPage = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page = homePage;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        return initData();
      },
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          appBar: HomeAppBar(),
          bottomNavigationBar: BottomBar(
            onPageSelected: (page) {
              print(page);
              if (page == 1) {
                this.page = homePage;
                if (currentPage != page) {
                  setState(() {});
                }
              }
              if (page == 2) {
                this.page = inoutPage;
                if (currentPage != page) {
                  setState(() {});
                }
              }
              currentPage = page;
            },
          ),
          body: page,
        ),
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  final VoidCallbackArg<int> onPageSelected;
  const BottomBar({
    super.key,
    required this.onPageSelected,
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
            onTap: () {
              onPageSelected(1);
            },
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
              onPageSelected(2);
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
