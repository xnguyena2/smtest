import 'package:flutter/material.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/component/interface/list_report_interface.dart';
import 'package:sales_management/page/home/compoment/monthly_report.dart';
import 'package:sales_management/page/report/api/report_api.dart';
import 'package:sales_management/page/report/component/report_as_table.dart';
import 'package:sales_management/page/report/component/report_bar.dart';
import 'package:sales_management/page/report/component/report_benifit_main_info.dart';
import 'package:sales_management/page/report/component/report_main_info.dart';
import 'package:sales_management/page/report/component/report_time_selector.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/utils.dart';

class ReportBenifitTab extends StatefulWidget {
  const ReportBenifitTab({super.key});

  @override
  State<ReportBenifitTab> createState() => _ReportBenifitTabtate();
}

class _ReportBenifitTabtate extends State<ReportBenifitTab> {
  late Future<ListReportInterface> _loadData;
  String? start;
  String? end;

  void refresh(bool today) {
    _loadData = today
        ? getBenifitOfToDay(start: start, end: end)
        : getBenifitOfCurrentMonthByDate(start: start, end: end);
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
              final totalSellingMoney =
                  ListDateBenifitDataResult.totalSellingRevenue;
              final totalSellingCost =
                  ListDateBenifitDataResult.totalSellingCost;
              final totalIncomeMoney = ListDateBenifitDataResult.totalIncome;
              final totalOutComeMoney = ListDateBenifitDataResult.totalOutCome;
              return SingleChildScrollView(
                child: Container(
                  color: BackgroundColor,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      ReportBenifitMainInfo(
                        totalSellingMoney: totalSellingMoney,
                        totalSellingCost: totalSellingCost,
                        totalIncomeMoney: totalIncomeMoney,
                        totalOutComeMoney: totalOutComeMoney,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Text(
                              'Xu hướng lãi/lỗ',
                              style: headStyleLargeBlackLigh,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          MonthlyReport(
                            margin: null,
                            padding: EdgeInsets.zero,
                            enableShowReportPageBtn: false,
                            isShowOnlyProfit: true,
                            listResult: ListDateBenifitDataResult,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ReportAsTable(
                        header: 'Chi tiết lãi lỗ',
                        datas: [
                          ReportItem(
                            reportType: HeaderReportType.MAIN,
                            header: 'Doanh thu bán hàng (1)',
                            value: MoneyFormater.format(totalRevenue),
                          ),
                          ReportItem(
                            reportType: HeaderReportType.SUB,
                            header: 'Tổng bán ra',
                            value: MoneyFormater.format(totalPrice),
                          ),
                          ReportItem(
                            reportType: HeaderReportType.SUB,
                            header: 'Thu phí vận chuyển',
                            value: MoneyFormater.format(totalShipPrice),
                          ),
                          ReportItem(
                            reportType: HeaderReportType.SUB,
                            header: 'Khuyến mãi',
                            value: MoneyFormater.format(
                                ListDateBenifitDataResult
                                    .totalDiscountPromotional),
                          ),
                          ReportItem(
                            reportType: HeaderReportType.SUB,
                            header: 'Chiết khấu',
                            value: MoneyFormater.format(
                              ListDateBenifitDataResult.totalDiscount,
                            ),
                          ),
                          ReportItem(
                            reportType: HeaderReportType.SUB,
                            header: 'Giảm gái từ điểm',
                            value: MoneyFormater.format(
                              ListDateBenifitDataResult.totalDiscountByPoint,
                            ),
                          ),
                          ReportItem(
                            reportType: HeaderReportType.SUB,
                            header: 'Hoàn trả BUG',
                            value: MoneyFormater.format(
                              ListDateBenifitDataResult.totalReturnPrice,
                            ),
                          ),
                          ReportItem(
                            reportType: HeaderReportType.SUB,
                            header: 'Phụ thu',
                            value: MoneyFormater.format(
                              ListDateBenifitDataResult.totalAdditionalFee,
                            ),
                          ),
                        ],
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
