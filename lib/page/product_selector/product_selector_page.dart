import 'dart:ui';

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
                maxCrossAxisExtent: 120,
                childAspectRatio: 1 / 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: listMainFunction.length + 1,
              itemBuilder: (context, index) {
                if (index == listMainFunction.length)
                  return Container(
                    decoration: BoxDecoration(
                      color: White,
                      borderRadius: defaultBorderRadius,
                      border: defaultBorder,
                    ),
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          LoadSvg(
                            assetPath: 'svg/plus.svg',
                            colorFilter: ColorFilter.mode(
                              MainHighColor,
                              BlendMode.srcIn,
                            ),
                          ),
                          Positioned(
                            bottom: -25,
                            child: Text(
                              'Thêm sản phẩm',
                              style: subInfoStyLargeHigh400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                var item = listMainFunction[index];
                return ProductSelectorItem();
              },
            ),
          ],
        ),
      ),
    ));
  }
}

class ProductSelectorItem extends StatelessWidget {
  const ProductSelectorItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: White,
        borderRadius: defaultBorderRadius,
        border: defaultBorder,
        image: DecorationImage(
          image: AssetImage(
            'assets/images/shop_logo.png',
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
            margin: EdgeInsets.only(top: 12, left: 6, right: 6),
            decoration: BoxDecoration(
                color: White,
                borderRadius: defaultSquareBorderRadius,
                border: defaultBorder),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LoadSvg(assetPath: 'svg/minus.svg'),
                SizedBox(
                  width: 18,
                  child: TextFormField(
                    initialValue: '99',
                    maxLines: 1,
                    style: headStyleLarge,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                LoadSvg(
                  assetPath: 'svg/plus.svg',
                  colorFilter: ColorFilter.mode(
                    MainHighColor,
                    BlendMode.srcIn,
                  ),
                )
              ],
            ),
          ),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 4.0,
                sigmaY: 4.0,
              ),
              child: Container(
                color: Color.fromRGBO(214, 214, 214, 0.40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Mỳ hảo hảo',
                          style: subInfoStyLarge400,
                        ),
                        Text(
                          '15.000',
                          style: subInfoStyLarge600,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
