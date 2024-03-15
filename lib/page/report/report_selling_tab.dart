import 'package:flutter/material.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/component/interface/list_report_interface.dart';
import 'package:sales_management/page/home/compoment/monthly_report.dart';
import 'package:sales_management/page/report/api/report_api.dart';
import 'package:sales_management/page/report/component/report_as_table.dart';
import 'package:sales_management/page/report/component/report_bar.dart';
import 'package:sales_management/page/report/component/report_by.dart';
import 'package:sales_management/page/report/component/report_cancel_return_order.dart';
import 'package:sales_management/page/report/component/report_main_info.dart';
import 'package:sales_management/page/report/component/report_time_selector.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/utils.dart';

class ReportSellingTab extends StatefulWidget {
  const ReportSellingTab({super.key});

  @override
  State<ReportSellingTab> createState() => _ReportSellingTabState();
}

class _ReportSellingTabState extends State<ReportSellingTab> {
  late Future<ListReportInterface> _loadData;
  String? start;
  String? end;

  void refresh(bool today) {
    _loadData = today
        ? getReportOfToDay(start: start, end: end)
        : getReportOfCurrentMonthByDate(start: start, end: end);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refresh(false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TimeSelector(
            onChagneDateTime: (DateTimeRange) {
              start = localDateTime2ServerFormat(DateTimeRange.start);
              end = localDateTime2ServerFormat(
                  DateTimeRange.end.add(Duration(days: 1)));
              refresh(false);
              setState(() {});
            },
            onChangeTime: (listTime) {
              bool isToday = false;
              if (listTime.length == 3) {
                isToday = true;
              }
              start = listTime[0];
              end = listTime[1];
              if (listTime[0].isEmpty) {
                start = end = null;
              }
              refresh(isToday);
              setState(() {});
            },
          ),
        ),
        Expanded(
          child: FetchAPI<ListReportInterface>(
            future: _loadData,
            successBuilder: (ListDateBenifitDataResult) {
              double totalPrice = ListDateBenifitDataResult.totalPrice;
              double totalRevenue = ListDateBenifitDataResult.totalRevenue;
              double totalCost = ListDateBenifitDataResult.totalCost;
              double totalProfit = ListDateBenifitDataResult.totalProfit;
              double totalDiscount = ListDateBenifitDataResult.totalDiscount;
              double totalShipPrice = ListDateBenifitDataResult.totalShipPrice;
              int numOrder = ListDateBenifitDataResult.numOrder;
              int numbuyer = ListDateBenifitDataResult.numberBuyer;
              return SingleChildScrollView(
                child: Container(
                  color: BackgroundColor,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      ReportMainInfo(
                        totalRevenue: totalRevenue,
                        numOrder: numOrder,
                        numbuyer: numbuyer,
                        totalProfit: totalProfit,
                        totalCost: totalCost,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      MonthlyReport(
                        margin: null,
                        padding: EdgeInsets.zero,
                        enableShowReportPageBtn: false,
                        listResult: ListDateBenifitDataResult,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ReportAsTable(
                        header: 'Phương thức thanh toán',
                        datas: [
                          ReportItem(
                              reportType: HeaderReportType.MAIN,
                              header: 'Tiền mặt',
                              value: MoneyFormater.format(totalRevenue)),
                          ReportItem(
                              reportType: HeaderReportType.MAIN,
                              header: 'Đã ghi nợ',
                              value: '0'),
                          ReportItem(
                            reportType: HeaderReportType.MAIN,
                            header: 'Chưa thanh toán',
                            value: MoneyFormater.format(totalPrice +
                                totalShipPrice -
                                totalDiscount -
                                totalRevenue),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ReportAsTable(
                        header: 'Doanh thu chi tiết',
                        datas: [
                          ReportItem(
                            reportType: HeaderReportType.MAIN,
                            header: 'Tổng giá bán',
                            value: MoneyFormater.format(totalPrice),
                          ),
                          ReportItem(
                            reportType: HeaderReportType.MAIN,
                            header: 'Chiết khấu',
                            value: '-${MoneyFormater.format(totalDiscount)}',
                          ),
                          ReportItem(
                            reportType: HeaderReportType.MAIN,
                            header: 'Phí vận chuyển',
                            value: MoneyFormater.format(totalShipPrice),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ReportBy(
                        begin: start,
                        end: end,
                        isShowProfit: true,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ReportCancelAndReturnOrder(
                        begin: start,
                        end: end,
                      ),
                      const SizedBox(
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
    );
  }
}
