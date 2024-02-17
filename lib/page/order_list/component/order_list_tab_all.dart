import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/high_border_container.dart';
import 'package:sales_management/page/order_list/bussiness/order_bussiness.dart';
import 'package:sales_management/page/order_list/component/order_list_package_item.dart';
import 'package:sales_management/page/order_list/provider/new_order_provider.dart';
import 'package:sales_management/page/order_list/provider/search_provider.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class OrderListAllPackageTab extends StatefulWidget {
  final VoidCallback createNewOrder;
  const OrderListAllPackageTab({
    super.key,
    required this.createNewOrder,
  });

  @override
  State<OrderListAllPackageTab> createState() => _OrderListAllPackageTabState();
}

class _OrderListAllPackageTabState extends State<OrderListAllPackageTab> {
  late final listPendingRequestOrder = getAllPendingOrderPackageRequest();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<NewOrderProvider>().getData;
    late final WrapListFilter wrapListFilter = WrapListFilter(
      listPackageDetailResult: data,
    );

    final filter = context.watch<SearchProvider>().getTxt ?? '';
    List<PackageDataResponse> listPackage =
        wrapListFilter.getListResult(filter: filter);
    listPackage.sort(
      (a, b) => b.createat?.compareTo(a.createat ?? '') ?? 0,
    );
    print('Length: ${listPackage.length}');
    if (listPackage.isEmpty) {
      return Center(
        child: GestureDetector(
          onTap: widget.createNewOrder,
          child: HighBorderContainer(
            isHight: true,
            padding: EdgeInsets.symmetric(vertical: 11, horizontal: 18),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                LoadSvg(assetPath: 'svg/plus_large.svg'),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Tạo đơn hàng',
                  style: headStyleSemiLargeHigh500,
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: BackgroundColor,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 10),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        // physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return PackageItemDetail(
            data: listPackage[index],
            onUpdated: (PackageDataResponse) {
              data.updateOrder(PackageDataResponse);
              setState(() {});
            },
            onDelete: (PackageDataResponse) {
              data.updateListOrder([PackageDataResponse]);
              setState(() {});
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(height: 10),
        itemCount: listPackage.length,
      ),
    );
  }
}
