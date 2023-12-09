import 'package:flutter/material.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/page/home/compoment/monthly_report.dart';
import 'package:sales_management/page/report/api/list_date_benefit.dart';
import 'package:sales_management/page/report/api/report_api.dart';
import 'package:sales_management/page/report/component/report_bar.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: ReportBar(),
        body: FetchAPI<ListDateBenifitDataResult>(
          future: getReportOfCurrentMonthByDate(),
          successBuilder: (ListDateBenifitDataResult) {
            double totalRevenue = ListDateBenifitDataResult.totalRevenue;
            double totalCost = ListDateBenifitDataResult.totalCost;
            double totalProfit = ListDateBenifitDataResult.totalProfit;
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                color: BackgroundColor,
                child: Column(
                  children: [
                    RevenueInfo(
                      profit: MoneyFormater.format(totalProfit),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      color: White,
                      padding:
                          EdgeInsets.symmetric(vertical: 26, horizontal: 16),
                      child: Column(
                        children: [
                          ReportItemInfo(
                            header: 'Doanh thu',
                            content: MoneyFormater.format(totalRevenue),
                            style: headStyleXLargeSemiBoldRevenue,
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          ReportItemInfo(
                            header: 'Giá vốn hàng hóa',
                            content: MoneyFormater.format(totalCost),
                            style: headStyleXLargeSemiBoldCost,
                          ),
                          // SizedBox(
                          //   height: 24,
                          // ),
                          // ReportItemInfo(
                          //   header: 'Chi phí',
                          //   content: '0',
                          //   style: headStyleXLargeSemiBoldRed,
                          // ),
                          // SizedBox(
                          //   height: 24,
                          // ),
                          // ReportItemInfo(
                          //   header: 'Lợi nhuận',
                          //   content: MoneyFormater.format(totalProfit),
                          //   style: headStyleXLargeSemiBoldProfit,
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MonthlyReport(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      enableShowReportPageBtn: false,
                      listResult: ListDateBenifitDataResult,
                    ),
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

class ReportItemInfo extends StatelessWidget {
  final String header;
  final String content;
  final TextStyle style;
  const ReportItemInfo({
    super.key,
    required this.header,
    required this.content,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          header,
          style: headStyleXLargeLigh,
        ),
        Text(
          content,
          style: style,
        ),
      ],
    );
  }
}

class RevenueInfo extends StatelessWidget {
  final String profit;
  const RevenueInfo({
    super.key,
    required this.profit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: defaultBorderRadius,
        color: White,
        boxShadow: [defaultShadow],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadSvg(assetPath: 'svg/currency_revenue_solid.svg'),
              SizedBox(
                width: 7,
              ),
              Text(
                'Lợi nhuận',
                style: customerNameBig,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            profit,
            style: moneyStyleSuperLargeHigh,
          ),
        ],
      ),
    );
  }
}
