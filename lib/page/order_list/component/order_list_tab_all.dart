import 'package:flutter/material.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/page/order_list/component/order_list_package_item.dart';
import 'package:sales_management/utils/constants.dart';

class OrderListAllPackageTab extends StatefulWidget {
  final ListPackageDetailResult data;
  const OrderListAllPackageTab({
    super.key,
    required this.data,
  });

  @override
  State<OrderListAllPackageTab> createState() => _OrderListAllPackageTabState();
}

class _OrderListAllPackageTabState extends State<OrderListAllPackageTab> {
  @override
  Widget build(BuildContext context) {
    List<PackageDataResponse> listPackage = widget.data.listResult;
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
              listPackage[index] = PackageDataResponse;
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