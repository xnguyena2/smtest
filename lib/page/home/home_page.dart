import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/page/create_order/create_order_page.dart';
import 'package:sales_management/page/flash/flash.dart';
import 'package:sales_management/page/home/api/model/bootstrap.dart';
import 'package:sales_management/page/transaction/income_outcome.dart';
import 'package:sales_management/page/home/child/management.dart';
import 'package:sales_management/page/report/report_page.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/snack_bar.dart';
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
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  int currentPage = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page = homePage;
    bool ignore = true;
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile) {
        changeInterNetStatus(true);
        if (ignore) {
          ignore = false;
          return;
        }
        showNotification(context, 'Đang sử dụng mạng điện thoại!');
      } else if (connectivityResult == ConnectivityResult.wifi) {
        changeInterNetStatus(true);
        if (ignore) {
          ignore = false;
          return;
        }
        showNotification(context, 'Đang sử dụng mạng wifi!');
      } else if (connectivityResult == ConnectivityResult.ethernet) {
        changeInterNetStatus(true);
        if (ignore) {
          ignore = false;
          return;
        }
        showNotification(context, 'Đang sử dụng mạng có dây!');
      } else if (connectivityResult == ConnectivityResult.vpn) {
        changeInterNetStatus(true);
        if (ignore) {
          ignore = false;
          return;
        }
        showNotification(context, 'Đang sử dụng mạng vpn!');
      } else if (connectivityResult == ConnectivityResult.bluetooth) {
        changeInterNetStatus(false);
        if (ignore) {
          ignore = false;
          return;
        }
        showAlert(context, 'Mất kết nối!');
      } else if (connectivityResult == ConnectivityResult.other) {
        changeInterNetStatus(false);
        if (ignore) {
          ignore = false;
          return;
        }
        showAlert(context, 'Mất kết nối!');
      } else if (connectivityResult == ConnectivityResult.none) {
        changeInterNetStatus(false);
        if (ignore) {
          ignore = false;
          return;
        }
        showAlert(context, 'Mất kết nối!');
      }
    });
  }

// Be sure to cancel subscription after you are done
  @override
  dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
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
              if (page == 1) {
                // this.page = homePage;
                // if (currentPage != page) {
                //   setState(() {});
                // }
              }
              if (page == 2) {
                // this.page = inoutPage;
                // if (currentPage != page) {
                //   setState(() {});
                // }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IncomeOutComme(),
                  ),
                );
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
