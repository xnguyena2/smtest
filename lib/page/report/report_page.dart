import 'package:flutter/material.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/page/home/compoment/monthly_report.dart';
import 'package:sales_management/page/report/api/list_date_benefit.dart';
import 'package:sales_management/page/report/api/report_api.dart';
import 'package:sales_management/page/report/component/report_as_table.dart';
import 'package:sales_management/page/report/component/report_bar.dart';
import 'package:sales_management/page/report/component/report_by.dart';
import 'package:sales_management/page/report/component/report_main_info.dart';
import 'package:sales_management/page/report/component/report_time_selector.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/utils.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late Future<ListDateBenifitDataResult> _loadData;
  String? start;
  String? end;

  void refresh() {
    _loadData = getReportOfCurrentMonthByDate(start: start, end: end);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: ReportBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TimeSelector(
                onChagneDateTime: (DateTimeRange) {
                  start = localDateTime2ServerFormat(DateTimeRange.start);
                  end = localDateTime2ServerFormat(
                      DateTimeRange.end.add(Duration(days: 1)));
                  refresh();
                  setState(() {});
                },
                onChangeTime: (listTime) {
                  start = listTime[0];
                  end = listTime[1];
                  if (listTime[0].isEmpty) {
                    start = end = null;
                  }
                  refresh();
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: FetchAPI<ListDateBenifitDataResult>(
                future: _loadData,
                successBuilder: (ListDateBenifitDataResult) {
                  double totalPrice = ListDateBenifitDataResult.totalPrice;
                  double totalRevenue = ListDateBenifitDataResult.totalRevenue;
                  double totalCost = ListDateBenifitDataResult.totalCost;
                  double totalProfit = ListDateBenifitDataResult.totalProfit;
                  double totalDiscount =
                      ListDateBenifitDataResult.totalDiscount;
                  double totalShipPrice =
                      ListDateBenifitDataResult.totalShipPrice;
                  int numOrder = ListDateBenifitDataResult.numOrder;
                  int numbuyer = ListDateBenifitDataResult.numberBuyer;
                  return SingleChildScrollView(
                    child: Container(
                      color: BackgroundColor,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          ReportMainInfo(
                            totalRevenue: totalRevenue,
                            numOrder: numOrder,
                            numbuyer: numbuyer,
                            totalProfit: totalProfit,
                            totalCost: totalCost,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          MonthlyReport(
                            margin: null,
                            padding: EdgeInsets.zero,
                            enableShowReportPageBtn: false,
                            listResult: ListDateBenifitDataResult,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          ReportAsTable(
                            header: 'Phương thức thanh toán',
                            datas: {
                              'Tiền mặt': MoneyFormater.format(totalRevenue),
                              'Đã ghi nợ': '0',
                              'Chưa thanh toán': MoneyFormater.format(
                                  totalPrice +
                                      totalShipPrice -
                                      totalDiscount -
                                      totalRevenue),
                            },
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          ReportAsTable(
                            header: 'Doanh thu chi tiết',
                            datas: {
                              'Tổng giá bán':
                                  MoneyFormater.format(totalPrice),
                              'Giảm giá': MoneyFormater.format(totalDiscount),
                              'Phí vận chuyển':
                                  MoneyFormater.format(totalShipPrice),
                            },
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          ReportBy(
                            begin: start,
                            end: end,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
