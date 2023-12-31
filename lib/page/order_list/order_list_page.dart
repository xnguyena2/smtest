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
          newOrderEvent(PackageDataResponse p) {
            context.read<NewOrderProvider>().updateValue = [p];
          }

          addNewOrder() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductSelectorPage(
                  firstSelectProductWhenCreateOrder: true,
                  onUpdatedPasstoCreateOrder: newOrderEvent,
                  packageDataResponse:
                      PackageDataResponse(items: [], buyer: null),
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
                        result.listResult;
                  });
                }
                return true;
              },
              child: TabBarView(
                children: [
                  FetchAPI<ListPackageDetailResult>(
                    future: getAllPackage(groupID, page: 0, size: 10),
                    successBuilder: (data) {
                      return OrderListAllPackageTab(
                        data: data,
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
  int currentPage = 0;

  void reset() {
    loading = false;
    _canLoadMore = true;
    currentPage = 0;
  }

  bool canLoadMore() {
    return _canLoadMore && loading == false;
  }

  void loadMore(VoidCallbackArg<ListPackageDetailResult> onDone) {
    loading = true;
    currentPage++;
    getAllPackage(groupID, page: currentPage, size: 10).then((value) {
      onDone(value);
      _canLoadMore = value.listResult.isNotEmpty;
      loading = false;
    }).onError((error, stackTrace) {
      loading = false;
    });
  }
}
