import 'package:flutter/material.dart';

import 'header.dart';
import 'navigation_next.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: Column(
        children: [
          const header(
            title: 'Đơn hàng',
            titleImg: 'svg/cart_check.svg',
            endChild: NavigationNext(
              title: 'Xem thêm',
              assetPath: 'svg/order.svg',
            ),
          ),
        ],
      ),
    );
  }
}
