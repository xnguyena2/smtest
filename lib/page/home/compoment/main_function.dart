import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants.dart';

const List<Map<String, String>> listMainFunction = [
  {
    'icon': 'svg/order_food.svg',
    'name': 'Tạo đơn',
  },
  {
    'icon': 'svg/table_order.svg',
    'name': 'Quản lý bàn',
  },
  {
    'icon': 'svg/order_manage.svg',
    'name': 'Đơn hàng',
  },
  {
    'icon': 'svg/goods.svg',
    'name': 'Sản phẩm',
  },
  {
    'icon': 'svg/report.svg',
    'name': 'Báo cáo',
  },
];

class MainFunction extends StatelessWidget {
  const MainFunction({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100,
          childAspectRatio: 1 / 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: listMainFunction.length,
        itemBuilder: (context, index) {
          var item = listMainFunction[index];
          return Container(
            decoration: BoxDecoration(
              color: White,
              borderRadius: defaultBorder,
              border: Border.all(color: borderColor, width: 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  width: 40,
                  item['icon'].toString(),
                ),
                Text(
                  item['name'].toString(),
                  style: subInfoStyLarge400,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
