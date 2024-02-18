import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/component/loading_overlay_alt.dart';
import 'package:sales_management/page/order_list/bussiness/order_bussiness.dart';
import 'package:sales_management/page/order_list/component/order_list_tab_all.dart';
import 'package:sales_management/page/order_list/provider/new_order_provider.dart';
import 'package:sales_management/page/order_list/provider/search_provider.dart';
import 'package:sales_management/page/product_selector/product_selector_page.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';

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
          updateOrderEvent(PackageDataResponse p) {
            context.read<NewOrderProvider>().updateValue = [p];
          }

          addNewOrder() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductSelectorPage(
                  firstSelectProductWhenCreateOrder: true,
                  onUpdatedPasstoCreateOrder: updateOrderEvent,
                  onDeletedPasstoCreateOrder: updateOrderEvent,
                  packageDataResponse: PackageDataResponse.empty(),
                  onUpdated: (PackageDataResponse) {},
                ),
              ),
            );
          }

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
              body: Body(
                addNewOrder: addNewOrder,
              ),
            ),
          );
        }),
      ),
    );
  }
}

class Body extends StatelessWidget {
  final VoidCallback addNewOrder;
  final _LoadMoreTrigger _loadMoreTrigger = _LoadMoreTrigger();
  Body({
    super.key,
    required this.addNewOrder,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ColoredBox(
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
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (_loadMoreTrigger.canLoadMore() &&
                    scrollInfo.metrics.axis == Axis.vertical &&
                    scrollInfo.metrics.pixels /
                            scrollInfo.metrics.maxScrollExtent >
                        0.8) {
                  _loadMoreTrigger.loadMore((result) {
                    context.read<NewOrderProvider>().updateValue =
                        result.getList;
                  });
                }
                return true;
              },
              child: TabBarView(
                children: [
                  FetchAPI<ListPackageDetailResult>(
                    future: _loadMoreTrigger.firstLoad(),
                    successBuilder: (data) {
                      context.read<NewOrderProvider>().setValue = data;
                      return OrderListAllPackageTab(
                        createNewOrder: addNewOrder,
                      );
                    },
                  ),
                  const Center(
                    child: Text('Chưa có đơn nào!'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadMoreTrigger {
  bool loading = false;
  bool _canLoadMore = true;
  int currentID = 0;

  void reset() {
    loading = false;
    _canLoadMore = true;
  }

  bool canLoadMore() {
    return _canLoadMore && loading == false;
  }

  Future<ListPackageDetailResult> firstLoad() {
    return getAllWorkingOrderPackge(groupID, id: currentID, size: 10)
        .then((value) {
      _canLoadMore = !value.isEmpty;
      currentID = value.currentID;
      final listPendingOrder = getAllPendingOrderPackage();
      value.insertLocalOrder(listPendingOrder);
      return value;
    });
  }

  void loadMore(VoidCallbackArg<ListPackageDetailResult> onDone) {
    loading = true;
    getAllWorkingOrderPackge(groupID, id: currentID, size: 10).then((value) {
      currentID = value.currentID;
      onDone(value);
      _canLoadMore = !value.isEmpty;
      loading = false;
    }).onError((error, stackTrace) {
      loading = false;
    });
  }
}
