import 'package:flutter/material.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/page/buyer/api/buyer_api.dart';
import 'package:sales_management/page/buyer/api/model/buyer_statictis_data.dart';
import 'package:sales_management/page/buyer/component/buyer_bar.dart';
import 'package:sales_management/page/buyer/component/buyer_main_info.dart';
import 'package:sales_management/page/buyer/component/lastest_order_of_buyer.dart';
import 'package:sales_management/page/buyer/component/report_by_product.dart';
import 'package:sales_management/page/buyer/component/total_item_report.dart';
import 'package:sales_management/page/report/component/report_time_selector.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/utils.dart';

class BuyerDetail extends StatelessWidget {
  const BuyerDetail({super.key, required this.buyer});

  final BuyerData buyer;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: BackgroundColor,
        appBar: BuyerDetailBar(
          buyer: buyer,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              BuyerMainInfo(
                buyerData: buyer,
              ),
              SizedBox(
                height: 10,
              ),
              BuyerStatictis(buyer: buyer)
            ],
          ),
        ),
      ),
    );
  }
}

class BuyerStatictis extends StatefulWidget {
  const BuyerStatictis({
    super.key,
    required this.buyer,
  });

  final BuyerData buyer;

  @override
  State<BuyerStatictis> createState() => _BuyerStatictisState();
}

class _BuyerStatictisState extends State<BuyerStatictis> {
  String? start;
  String? end;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 6,
            left: 16,
            right: 16,
          ),
          color: White,
          child: Column(
            children: [
              TimeSelector(
                onChagneDateTime: (DateTimeRange) {
                  start = localDateTime2ServerFormat(DateTimeRange.start);
                  end = localDateTime2ServerFormat(
                      DateTimeRange.end.add(Duration(days: 1)));
                  setState(() {});
                },
                onChangeTime: (listTime) {
                  start = listTime[0];
                  end = listTime[1];
                  if (listTime[0].isEmpty) {
                    start = end = null;
                  }
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        FetchAPI<BuyerStatictisData>(
          future: getBuyerDetail(
            buyerID: widget.buyer.deviceId,
            start: start,
            end: end,
          ),
          successBuilder: (buyerDetail) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    bottom: 6,
                    left: 16,
                    right: 16,
                  ),
                  color: White,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TotalReportItem(
                                bgColor: White,
                                contentTxt: MoneyFormater.format(
                                    buyerDetail.benifitByMonth.revenue),
                                iconPath: 'svg/sales_amount.svg',
                                headerTxt: 'Doanh thu'),
                          ),
                          SizedBox(
                            height: 20,
                            child: VerticalDivider(
                              color: Black15,
                            ),
                          ),
                          Expanded(
                            child: TotalReportItem(
                                bgColor: White,
                                contentTxt:
                                    buyerDetail.benifitByMonth.count.toString(),
                                iconPath: 'svg/order_high.svg',
                                headerTxt: 'Đã giao'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Đơn gần nhất: ',
                          style: headStyleSmallLargeLLigh,
                          children: [
                            TextSpan(
                                text:
                                    '${formatLocalDateTimeOnlyDate(buyerDetail.getLastestTimeOrder())}',
                                style: headStyleSmallLarge)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ReportByProductLastTimeAsTable(
                  benifitByProducts: buyerDetail.benifitByProducts,
                ),
                SizedBox(
                  height: 10,
                ),
                LastestOrderOfBuyer(
                  buyerDetail: buyerDetail,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
