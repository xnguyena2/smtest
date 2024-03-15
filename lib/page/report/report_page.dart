import 'package:flutter/material.dart';
import 'package:sales_management/page/report/component/report_bar.dart';
import 'package:sales_management/page/report/report_benifit_tab.dart';
import 'package:sales_management/page/report/report_selling_tab.dart';
import 'package:sales_management/utils/constants.dart';

class ReportPage extends StatelessWidget {
  ReportPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: ReportBar(),
        body: DefaultTabController(
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ColoredBox(
                color: White,
                child: TabBar(
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
                      height: 35,
                      child: SizedBox(
                        width: 200,
                        child: Center(child: Text('Bán hàng')),
                      ),
                    ),
                    Tab(
                      height: 35,
                      child: SizedBox(
                        width: 200,
                        child: Center(child: Text('Lãi lỗ')),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ReportSellingTab(),
                    ReportBenifitTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
