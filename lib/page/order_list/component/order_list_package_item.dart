import 'package:flutter/material.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/api/model/package/package_detail.dart';
import 'package:sales_management/api/model/package/product_package.dart';
import 'package:sales_management/component/btn/approve_btn.dart';
import 'package:sales_management/component/btn/cancel_btn.dart';
import 'package:sales_management/component/text_round.dart';
import 'package:sales_management/page/create_order/component/order_select_area_deliver.dart';
import 'package:sales_management/page/create_order/create_order_page.dart';
import 'package:sales_management/page/order_list/api/order_list_api.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/typedef.dart';

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
    bool isTable = data.packageType == DeliverType.table;

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
                      '${data.localTimeTxt} - ${data.id}',
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
                      data.priceFormat,
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
                      isActiveOk: true,
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
