import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/api/model/package/package_detail.dart';
import 'package:sales_management/page/create_order/create_order_page.dart';
import 'package:sales_management/page/list_buyer/list_buyer_page.dart';
import 'package:sales_management/page/login_by_qr/login_by_qr.dart';
import 'package:sales_management/page/order_list/order_list_page.dart';
import 'package:sales_management/page/product_selector/product_selector_page.dart';
import 'package:sales_management/page/report/report_page.dart';
import 'package:sales_management/page/table/api/model/area_table.dart';
import 'package:sales_management/page/table/table_page.dart';

import '../../../utils/constants.dart';
import '../../../utils/svg_loader.dart';

const List<Map<String, String>> listFullMainFunction = [
  {'icon': 'svg/order_food.svg', 'name': 'Tạo đơn', 'page': 'Create_Order'},
  {'icon': 'svg/table_order.svg', 'name': 'Quản lý bàn', 'page': 'Table'},
  {'icon': 'svg/order_manage.svg', 'name': 'Đơn hàng', 'page': 'List_Order'},
  {'icon': 'svg/goods.svg', 'name': 'Sản phẩm', 'page': 'Product'},
  {'icon': 'svg/report.svg', 'name': 'Báo cáo', 'page': 'Report'},
  {'icon': 'svg/staff.svg', 'name': 'Đăng nhập', 'page': 'Tokens'},
  {'icon': 'svg/buyer.svg', 'name': 'Khách hàng', 'page': 'Buyers'},
];

const List<Map<String, String>> listNoTableMainFunction = [
  {'icon': 'svg/order_food.svg', 'name': 'Tạo đơn', 'page': 'Create_Order'},
  {'icon': 'svg/order_manage.svg', 'name': 'Đơn hàng', 'page': 'List_Order'},
  {'icon': 'svg/goods.svg', 'name': 'Sản phẩm', 'page': 'Product'},
  {'icon': 'svg/report.svg', 'name': 'Báo cáo', 'page': 'Report'},
  {'icon': 'svg/staff.svg', 'name': 'Đăng nhập', 'page': 'Tokens'},
  {'icon': 'svg/buyer.svg', 'name': 'Khách hàng', 'page': 'Buyers'},
];

class MainFunction extends StatelessWidget {
  const MainFunction({super.key});

  @override
  Widget build(BuildContext context) {
    final listFunction =
        haveTable ? listFullMainFunction : listNoTableMainFunction;
    return ColoredBox(
      color: BackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100,
            childAspectRatio: 1 / 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: listFunction.length,
          itemBuilder: (context, index) {
            var item = listFunction[index];
            return GestureDetector(
              onTap: () async {
                switch (item['page']) {
                  case 'Create_Order':
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
                  case 'Table':
                    TableDetailData? tableDetailData = null;
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TablePage(
                          done: (table) {
                            tableDetailData = table;
                          },
                        ),
                      ),
                    );
                    if (tableDetailData == null) {
                      return;
                    }
                    if (tableDetailData!.isUsed) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateOrderPage(
                            packageID: tableDetailData!.packageSecondId,
                            data: PackageDataResponse(items: [], buyer: null),
                            onUpdated: (package) {},
                            onDelete: (PackageDataResponse) {},
                          ),
                        ),
                      );
                      return;
                    }
                    final newOrder =
                        PackageDataResponse(items: [], buyer: null);
                    newOrder.packageType = DeliverType.table;
                    newOrder.setTable(tableDetailData!);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateOrderPage(
                          data: newOrder,
                          onUpdated: (package) {},
                          onDelete: (PackageDataResponse) {},
                        ),
                      ),
                    );
                  case 'List_Order':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderListPage(),
                      ),
                    );
                  case 'Product':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductSelectorPage(
                          packageDataResponse: null,
                          onUpdated: (packageDataResponse) {},
                        ),
                      ),
                    );
                  case 'Report':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportPage(),
                      ),
                    );
                  case 'Tokens':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginByQR(),
                      ),
                    );
                  case 'Buyers':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListBuyerPage(),
                      ),
                    );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: White,
                    borderRadius: defaultBorderRadius,
                    boxShadow: const [defaultShadow]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LoadSvg(
                      assetPath: item['icon'].toString(),
                      width: 40,
                    ),
                    Text(
                      item['name'].toString(),
                      style: subInfoStyLarge400,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
