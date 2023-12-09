import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/component/loading_overlay_alt.dart';
import 'package:sales_management/page/create_order/create_order_page.dart';
import 'package:sales_management/page/order_list/api/order_list_api.dart';
import 'package:sales_management/page/order_list/component/order_list_tab_all.dart';
import 'package:sales_management/page/order_list/provider/new_order_provider.dart';
import 'package:sales_management/page/order_list/provider/search_provider.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

import 'component/order_list_bar.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingOverlayAlt(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => SearchProvider(''),
          ),
          ChangeNotifierProvider(
            create: (_) => NewOrderProvider(),
          )
        ],
        child: Builder(builder: (context) {
          final addNewOrder = () async {
            PackageDataResponse? newO;
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateOrderPage(
                  data: PackageDataResponse(items: [], buyer: null),
                  onUpdated: (package) {
                    newO = package;
                  },
                  onDelete: (PackageDataResponse) {},
                ),
              ),
            );
            if (newO != null) {
              context.read<NewOrderProvider>().updateValue = newO!;
            }
          };
          return SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              appBar: OrderListBar(
                onBackPressed: () {
                  Navigator.pop(context);
                },
              ),
              floatingActionButton: Builder(builder: (context) {
                return FloatingActionButton.small(
                  elevation: 2,
                  backgroundColor: MainHighColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: floatBottomBorderRadius,
                  ),
                  onPressed: addNewOrder,
                  child: LoadSvg(
                    assetPath: 'svg/plus_large_width_2.svg',
                    color: White,
                  ),
                );
              }),
              body: FetchAPI<ListPackageDetailResult>(
                future: getAllPackage(groupID),
                successBuilder: (data) {
                  return Body(
                    data: data,
                    addNewOrder: addNewOrder,
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}

class Body extends StatelessWidget {
  final ListPackageDetailResult data;
  final VoidCallback addNewOrder;
  const Body({
    super.key,
    required this.data,
    required this.addNewOrder,
  });

  @override
  Widget build(BuildContext context) {
    final newO = context.watch<NewOrderProvider>().getData;
    if (newO != null) {
      data.addNewOrder(newO);
    }
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ColoredBox(
            color: White,
            child: TabBar(
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              isScrollable: true,
              indicatorColor: HighColor,
              labelColor: HighColor,
              labelStyle: headStyleMedium500,
              indicatorWeight: 1,
              // indicator: UnderlineTabIndicator(
              //   borderSide: BorderSide(
              //     width: 2,
              //     color: HighColor,
              //   ),
              // ),
              tabs: [
                Tab(
                  height: 35,
                  child: SizedBox(
                    width: 200,
                    child: Center(child: Text('Tất cả')),
                  ),
                ),
                Tab(
                  height: 35,
                  child: SizedBox(
                    width: 200,
                    child: Center(child: Text('Chờ xác nhận')),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                OrderListAllPackageTab(
                  data: data,
                  createNewOrder: addNewOrder,
                ),
                Center(
                  child: Text('Chưa có đơn nào!'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
