import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/page/create_order/create_order_page.dart';
import 'package:sales_management/page/order_list/order_list_page.dart';
import 'package:sales_management/page/product_selector/product_selector_page.dart';
import 'package:sales_management/page/report/report_page.dart';
import 'package:sales_management/page/table/table_page.dart';

import '../../../utils/constants.dart';
import '../../../utils/svg_loader.dart';

const List<Map<String, String>> listMainFunction = [
  {'icon': 'svg/order_food.svg', 'name': 'Tạo đơn', 'page': 'Create_Order'},
  {'icon': 'svg/table_order.svg', 'name': 'Quản lý bàn', 'page': 'Table'},
  {'icon': 'svg/order_manage.svg', 'name': 'Đơn hàng', 'page': 'List_Order'},
  {'icon': 'svg/goods.svg', 'name': 'Sản phẩm', 'page': 'Product'},
  {'icon': 'svg/report.svg', 'name': 'Báo cáo', 'page': 'Report'},
];

class MainFunction extends StatelessWidget {
  const MainFunction({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 80,
          childAspectRatio: 1 / 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: listMainFunction.length,
        itemBuilder: (context, index) {
          var item = listMainFunction[index];
          return GestureDetector(
            onTap: () {
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TablePage(
                        done: (table) {},
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
    );
  }
}
