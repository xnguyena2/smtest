import 'package:flutter/material.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/api/model/package/product_package.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/component/btn/approve_btn.dart';
import 'package:sales_management/component/btn/cancel_btn.dart';
import 'package:sales_management/page/create_order/component/order_select_area_deliver.dart';
import 'package:sales_management/page/create_order/create_order_page.dart';
import 'package:sales_management/page/order_list/api/order_list_api.dart';
import 'package:sales_management/page/order_list/component/order_list_tab_all.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/typedef.dart';

import '../../component/text_round.dart';
import 'component/order_list_bar.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: OrderListBar(),
        body: FetchAPI<ListPackageDetailResult>(
          future: getAllPackage(groupID),
          successBuilder: (data) {
            return Body(
              data: data,
            );
          },
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  final ListPackageDetailResult data;
  const Body({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          ColoredBox(
            color: White,
            child: Row(
              children: [
                TabBar(
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
                      child: SizedBox(
                        width: 200,
                        child: Center(child: Text('Tất cả')),
                      ),
                    ),
                    Tab(
                      child: SizedBox(
                        width: 200,
                        child: Center(child: Text('Chờ xác nhận')),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                OrderListAllPackageTab(
                  data: data,
                ),
                Placeholder(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
