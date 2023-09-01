import 'package:flutter/material.dart';
import 'package:sales_management/component/btn/approve_btn.dart';
import 'package:sales_management/component/btn/cancel_btn.dart';
import 'package:sales_management/utils/constants.dart';

import '../../component/text_round.dart';
import 'component/order_list_bar.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: OrderListBar(),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              ColoredBox(
                color: White,
                child: TabBar(
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
                        width: 300,
                        child: Center(child: Text('Tất cả')),
                      ),
                    ),
                    Tab(
                      child: SizedBox(
                        width: 300,
                        child: Center(child: Text('Chờ xác nhận')),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      color: BackgroundColor,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Bàn 1 - Khu vực 1',
                                      style: headStyleMedium500,
                                    ),
                                    TextRound(
                                      txt: 'Đang xử lý',
                                      isHigh: false,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  'Khách lẻ',
                                  style: subInfoStyLargeLigh400,
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  '16/08 14/08/2023 TZJZDB',
                                  style: subInfoStyLargeLigh400,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(),
                                SizedBox(
                                  height: 9,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Tổng cộng',
                                      style: subInfoStyLarge400,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '75.000',
                                          style: headStyleMedium500,
                                        ),
                                        Text(
                                          'Chưa thanh toán',
                                          style: subInfoStyMediumAlert400,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: CancelBtn(
                                        txt: 'Hủy bỏ',
                                        padding:
                                            EdgeInsets.symmetric(vertical: 14),
                                        isSmallTxt: true,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: ApproveBtn(
                                        txt: 'Đã giao',
                                        padding:
                                            EdgeInsets.symmetric(vertical: 14),
                                        isSmallTxt: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(height: 10),
                        itemCount: 3,
                      ),
                    ),
                    Placeholder(),
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
