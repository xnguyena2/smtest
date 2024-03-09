import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sales_management/api/local_storage/local_storage.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/page/home/api/model/bootstrap.dart';
import 'package:sales_management/page/home/compoment/order_list.dart';
import 'package:sales_management/page/report/api/list_date_benefit.dart';
import 'package:sales_management/page/report/api/report_api.dart';

import '../compoment/guide.dart';
import '../compoment/main_function.dart';
import '../compoment/monthly_report.dart';
import '../compoment/quick_report.dart';

class Management extends StatelessWidget {
  Future<BenifitByMonth?> getBenifitOfMonth(Box<dynamic> box) async {
    BootStrapData? config = LocalStorage.getBootStrap(box);
    if (config == null) {
      return null;
    }

    return config.benifit;
  }

  const Management({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: LocalStorage.getListenBootStrapKey(),
      builder: (BuildContext context, Box<dynamic> value, Widget? child) {
        return FetchAPI<BenifitByMonth?>(
          future: getBenifitOfMonth(value),
          successBuilder: (benifitByMonth) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: -600,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 600,
                          color: Color(0xFF1F6C98),
                        ),
                      ),
                      QuickReport(
                        benifitByMonth: benifitByMonth,
                      ),
                    ],
                  ),
                  const Guide(),
                  const MainFunction(),
                  FetchAPI<ListDateBenifitDataResult>(
                    future: getReportOfCurrentMonthByDate(),
                    successBuilder: (ListDateBenifitDataResult) {
                      return MonthlyReport(
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
          },
        );
      },
    );
  }
}
