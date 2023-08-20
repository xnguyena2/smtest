import 'package:flutter/material.dart';
import 'package:sales_management/page/product_selector/component/product_selector_bar.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

const List<String> listCategory = ['Mỳ ăn liền', 'Đồ ăn'];

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

class ProductSelectorPage extends StatelessWidget {
  const ProductSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: ProductSelectorBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        color: BackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return LoadSvg(assetPath: 'svg/grid_horizontal.svg');
                    }
                    if (index == 1) {
                      return CategoryItem(
                        txt: 'Tất cả',
                        isActive: true,
                      );
                    }
                    return CategoryItem(
                      txt: listCategory[index - 2],
                      isActive: false,
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        width: 10,
                      ),
                  itemCount: listCategory.length + 2),
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
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
                    borderRadius: defaultBorderRadius,
                    border: defaultBorder,
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/black-rocks.jpeg',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
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
          ],
        ),
      ),
    ));
  }
}

class CategoryItem extends StatelessWidget {
  final String txt;
  final bool isActive;
  const CategoryItem({
    super.key,
    required this.txt,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: White,
          borderRadius: defaultBorderRadius,
          border: isActive ? mainHighBorder : categoryBorder,
        ),
        child: Text(
          txt,
          style: isActive ? headStyleMediumHigh : headStyleMediumNormalLight,
        ),
      ),
    );
  }
}
