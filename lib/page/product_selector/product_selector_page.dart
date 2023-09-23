import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/api/model/product_package.dart';
import 'package:sales_management/api/model/search_result.dart';
import 'package:sales_management/api/model/user_info_query.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/component/image_loading.dart';
import 'package:sales_management/page/account/api/account_api.dart';
import 'package:sales_management/page/product_selector/api/product_selector_api.dart';
import 'package:sales_management/page/product_selector/component/product_selector_bar.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/utils.dart';

import '../../component/category_selector.dart';

const List<String> listCategory = ['Mỳ ăn liền', 'Đồ ăn'];

class ProductSelectorPage extends StatelessWidget {
  const ProductSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    // getall().then((value) {
    //   print(value.count);
    // }).catchError((e) {
    //   print('Got error: $e');
    //   signin().then((value) {
    //     print(value.token);
    //   });
    // });
    // signin().then((value) {
    //   print(value.token);
    // });
    // me();
    fetchPackage(UserInfoQuery(
            group_id: groupID, id: deviceID, page: 0, size: 10000))
        .then((value) => null);
    return SafeArea(
        child: Scaffold(
      appBar: ProductSelectorBar(),
      body: FetchAPI<SearchResult<BeerSubmitData>>(
        future: getall(),
        successBuilder: (SearchResult<BeerSubmitData> data) {
          final results = flatten<BeerSubmitData>(data.result.map(
            (e) {
              return e.flatUnit();
            },
          ));
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              color: BackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CategorySelector(
                    listCategory: listCategory,
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 120,
                      childAspectRatio: 1 / 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: results.length + 1,
                    itemBuilder: (context, index) {
                      if (index == results.length)
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
                      return ProductSelectorItem(
                        productData: results[index],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}

class ProductSelectorItem extends StatefulWidget {
  final BeerSubmitData productData;
  const ProductSelectorItem({
    super.key,
    required this.productData,
  });

  @override
  State<ProductSelectorItem> createState() => _ProductSelectorItemState();
}

class _ProductSelectorItemState extends State<ProductSelectorItem> {
  late final String? imgUrl;
  late final String name;
  late final double price;
  bool processing = false;
  late ListUnit unit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    unit = widget.productData.listUnit[0];
    imgUrl = widget.productData.getFristLargeImg;
    name = widget.productData.name;
    price = widget.productData.getRealPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: White,
        borderRadius: defaultBorderRadius,
        border: defaultBorder,
        image: DecorationImage(
          image: (imgUrl == null
              ? const AssetImage(
                  'assets/images/shop_logo.png',
                )
              : NetworkImage(imgUrl!)) as ImageProvider,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
            margin: const EdgeInsets.only(top: 12, left: 6, right: 6),
            decoration: BoxDecoration(
                color: White,
                borderRadius: defaultSquareBorderRadius,
                border: defaultBorder),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: LoadSvg(assetPath: 'svg/minus.svg'),
                  onTap: () => changePackage(unit, -1),
                ),
                SizedBox(
                  width: 18,
                  child: TextFormField(
                    initialValue: '99',
                    maxLines: 1,
                    style: headStyleLarge,
                    onEditingComplete: () {
                      print('onEditingComplete');
                    },
                    onFieldSubmitted: (value) {
                      print('onFieldSubmitted');
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => changePackage(unit, 1),
                  child: LoadSvg(
                    assetPath: 'svg/plus.svg',
                    colorFilter: const ColorFilter.mode(
                      MainHighColor,
                      BlendMode.srcIn,
                    ),
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
                child: Column(
                  children: [
                    Text(
                      name,
                      style: subInfoStyLarge400,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          MoneyFormater.format(price),
                          style: subInfoStyLarge600,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void changePackage(ListUnit unit, int diff) {
    setState(() {
      processing = true;
    });
    addToPackage(
      ProductPackage(
          group_id: groupID,
          beerID: unit.beer,
          beerUnits: [
            BeerUnits(beerUnitID: unit.beerUnitSecondId, numberUnit: diff)
          ],
          deviceID: deviceID),
    ).then((value) {
      processing = false;
      // widget.item.numberUnit += diff;
      // widget.updateItemCount.call();
    }).catchError(
      (error, stackTrace) {
        setState(() {
          processing = false;
        });
        print("Error: $error");
      },
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
