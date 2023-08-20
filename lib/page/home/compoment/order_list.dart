import 'package:flutter/material.dart';
import 'package:sales_management/page/home/model/order.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/img_loader.dart';

import '../../../utils/svg_loader.dart';
import 'header.dart';
import 'navigation_next.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const header(
            title: 'Đơn hàng',
            titleImg: 'svg/cart_check.svg',
            endChild: NavigationNext(
              title: 'Xem thêm',
              assetPath: 'svg/order.svg',
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: White,
              borderRadius: defaultBorderRadius,
            ),
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                Order order = orderList[index];

                return Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: White,
                    borderRadius: defaultBorderRadius,
                    boxShadow: const [defaultShadow],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        foregroundImage: AssetImage(
                          "assets/images/shop_logo.png",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.title,
                              style: subInfoStyLarge600,
                            ),
                            Text(
                              order.full_name + ' | ' + order.phone,
                              style: subInfoStyMedium400,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            order.datetime,
                            style: subInfoStyMedium400Light,
                          ),
                          Text(
                            order.money.toString(),
                            style: subInfoStyLarge600High,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: 10,
              ),
              itemCount: orderList.length,
            ),
          ),
        ],
      ),
    );
  }
}
