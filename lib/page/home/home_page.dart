import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:sales_management/api/local_storage/local_storage.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/page/create_order/create_order_page.dart';
import 'package:sales_management/page/flash/flash.dart';
import 'package:sales_management/page/home/api/model/bootstrap.dart';
import 'package:sales_management/page/home/compoment/bottom_bar.dart';
import 'package:sales_management/page/product_info/product_info.dart';
import 'package:sales_management/page/transaction/income_outcome.dart';
import 'package:sales_management/page/home/child/management.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/snack_bar.dart';
import 'package:sales_management/utils/utils.dart';

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
  bool isShowPluss = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isShowPluss = false;
    page = homePage;
    bool ignore = true;
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      final status = listenConnection(connectivityResult);
      changeInterNetStatus(status);
      if (ignore) {
        ignore = false;
        return;
      }
      if (status) {
        showNotification(context, 'Có kết nối internet!');
        return;
      }
      showAlert(context, 'Mất kết nối!');
    });
  }

// Be sure to cancel subscription after you are done
  @override
  dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  void togglePlus() {
    isShowPluss = !isShowPluss;
    setState(() {});
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
          bottomNavigationBar: HomePageBottomBar(
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
            onPlustClicked: togglePlus,
          ),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: (MediaQuery.of(context).size.height),
                  ),
                  child: page),
              if (isShowPluss)
                _AddingPopup(
                  togglePlus: togglePlus,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddingPopup extends StatelessWidget {
  final VoidCallback togglePlus;
  const _AddingPopup({
    super.key,
    required this.togglePlus,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: togglePlus,
        child: ColoredBox(
          color: Black70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      togglePlus();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateOrderPage(
                            data: PackageDataResponse.empty(),
                            onUpdated: (package) {},
                            onDelete: (PackageDataResponse) {},
                            isTempOrder: true,
                          ),
                        ),
                      );
                    },
                    child: _CreateItem(
                      txt: 'Thêm đơn hàng',
                      icon: LoadSvg(assetPath: 'svg/create_order.svg'),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      togglePlus();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IncomeOutComme(),
                        ),
                      );
                    },
                    child: _CreateItem(
                      txt: 'Tạo thu chi',
                      icon: LoadSvg(assetPath: 'svg/edit_3.svg'),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      togglePlus();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductInfo(
                            product: BeerSubmitData.createEmpty(groupID),
                            onAdded: (product) {
                              BootStrapData? config =
                                  LocalStorage.getBootStrap();
                              if (config == null) {
                                return null;
                              }

                              config.addOrReplaceProduct(product);

                              LocalStorage.setBootstrapData(config);
                            },
                            onDeleted: (product) {},
                          ),
                        ),
                      );
                    },
                    child: _CreateItem(
                      txt: 'Tạo sản phẩm',
                      icon: LoadSvg(
                          assetPath: 'svg/product.svg', color: TableHighColor),
                    ),
                  ),
                  SizedBox(
                    height: 15,
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

class _CreateItem extends StatelessWidget {
  final String txt;
  final Widget icon;
  const _CreateItem({
    super.key,
    required this.txt,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          txt,
          style: headStyleMedium600White,
        ),
        SizedBox(
          width: 15,
        ),
        CircleAvatar(
          backgroundColor: White,
          radius: 15,
          child: icon,
        )
      ],
    );
  }
}
