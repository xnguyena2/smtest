import 'package:flutter/material.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/api/model/package/product_package.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/component/btn/approve_btn.dart';
import 'package:sales_management/component/btn/cancel_btn.dart';
import 'package:sales_management/page/create_order/component/order_select_area_deliver.dart';
import 'package:sales_management/page/create_order/create_order_page.dart';
import 'package:sales_management/page/order_list/api/order_list_api.dart';
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
                AllPackageTab(
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

class AllPackageTab extends StatefulWidget {
  final ListPackageDetailResult data;
  const AllPackageTab({
    super.key,
    required this.data,
  });

  @override
  State<AllPackageTab> createState() => _AllPackageTabState();
}

class _AllPackageTabState extends State<AllPackageTab> {
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

class PackageItemDetail extends StatelessWidget {
  final PackageDataResponse data;
  final VoidCallbackArg<PackageDataResponse> onUpdated;
  const PackageItemDetail({
    super.key,
    required this.data,
    required this.onUpdated,
  });

  @override
  Widget build(BuildContext context) {
    BuyerData? buyer = data.buyer;
    bool isTable = data.deliverType == DeliverType.table;

    String headerTxt = '';
    if (isTable) {
      if (data.areaName == null && data.tableName == null) {
        headerTxt = 'Chưa chọn bàn';
      } else {
        headerTxt = ('${data.areaName ?? ''} - ') + (data.tableName ?? '');
      }
    } else {
      headerTxt = buyer?.reciverFullname ?? 'Khách lẻ';
    }

    bool isDone = data.isDone;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateOrderPage(
              data: data.clone(),
              onUpdated: onUpdated,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: White,
          borderRadius: defaultBorderRadius,
          boxShadow: const [defaultShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      headerTxt,
                      style: headStyleMedium500,
                    ),
                    if (isTable) ...[
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        buyer?.reciverFullname ?? 'Khách lẻ',
                        style: subInfoStyLargeLigh400,
                      ),
                    ],
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      '${data.localTimeTxt} - ${data.id}' ??
                          '16:08 14/08/2023 TZJZDB',
                      style: subInfoStyLargeLigh400,
                    ),
                  ],
                ),
                TextRound(
                  txt: isDone ? 'Đã giao' : 'Đang xử lý',
                  isHigh: isDone,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 9,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tổng cộng',
                  style: subInfoStyLarge400,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      data.priceFormat ?? '75.000',
                      style: headStyleMedium500,
                    ),
                    Text(
                      isDone ? 'Đã thanh toán' : 'Chưa thanh toán',
                      style: isDone
                          ? subInfoStyMediumHigh400
                          : subInfoStyMediumAlert400,
                    )
                  ],
                )
              ],
            ),
            if (!isDone) ...[
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CancelBtn(
                      txt: 'Hủy bỏ',
                      padding: EdgeInsets.symmetric(vertical: 10),
                      isSmallTxt: true,
                      onPressed: () {
                        data.status = 'CANCEL';
                        updatePackage(
                            ProductPackage.fromPackageDataResponse(data));
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ApproveBtn(
                      txt: 'Đã giao',
                      padding: EdgeInsets.symmetric(vertical: 10),
                      isSmallTxt: true,
                      onPressed: () {
                        print('update package: ${data.packageSecondId}');
                        data.status = 'DONE';
                        updatePackage(
                            ProductPackage.fromPackageDataResponse(data));
                      },
                    ),
                  ),
                ],
              )
            ],
          ],
        ),
      ),
    );
  }
}
