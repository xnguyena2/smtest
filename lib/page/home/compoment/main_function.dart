import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants.dart';
import '../../../utils/svg_loader.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 80,
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
                boxShadow: const [
                  BoxShadow(
                      color: borderColorLight,
                      blurRadius: 2,
                      offset: Offset(0, 2))
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LoadSvg(
                  assetPath: item['icon'].toString(),
                  width: 40,
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
