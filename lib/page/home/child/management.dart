import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/page/home/api/model/bootstrap.dart';
import 'package:sales_management/page/home/compoment/order_list.dart';
import 'package:sales_management/page/report/api/list_date_benefit.dart';
import 'package:sales_management/page/report/api/report_api.dart';
import 'package:sales_management/utils/constants.dart';

import '../compoment/guide.dart';
import '../compoment/main_function.dart';
import '../compoment/monthly_report.dart';
import '../compoment/quick_report.dart';

class Management extends StatefulWidget {
  final BenifitByMonth? benifitByMonth;
  const Management({
    super.key,
    required this.benifitByMonth,
  });

  @override
  State<Management> createState() => _ManagementState();
}

class _ManagementState extends State<Management> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          QuickReport(
            benifitByMonth: widget.benifitByMonth,
          ),
          // Guide(),
          MainFunction(),
          FetchAPI<ListDateBenifitDataResult>(
            future: getReportOfCurrentMonthByDate(),
            successBuilder: (ListDateBenifitDataResult) {
              return MonthlyReport(
                margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.symmetric(vertical: 10),
                enableShowReportPageBtn: true,
                listResult: ListDateBenifitDataResult,
              );
            },
          ),
          // OrderList(),
        ],
      ),
    );
  }
}
