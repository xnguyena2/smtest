import 'package:flutter/material.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/btn/switch_btn.dart';
import 'package:sales_management/component/check_radio_item.dart';
import 'package:sales_management/page/product_selector/product_selector_page.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class ListProduct extends StatefulWidget {
  final PackageDataResponse data;
  const ListProduct({
    super.key,
    required this.data,
  });

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  late final PackageDataResponse data;
  late final List<ProductInPackageResponse> listProducts;
  String currentPriceType = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.data;
    listProducts = data.items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: White,
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: RoundBtn(
                    icon: LoadSvg(
                        assetPath: 'svg/print.svg', width: 20, height: 20),
                    txt: 'In bếp',
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  width: 18,
                ),
                Expanded(
                  child: RoundBtn(
                    isSelected: true,
                    icon: LoadSvg(
                        assetPath: 'svg/plus_large.svg', width: 20, height: 20),
                    txt: 'Thêm sản phẩm',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductSelectorPage(
                            packageDataResponse: data,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Giá áp dụng:',
                  style: headStyleSemiLargeLigh500,
                ),
                Row(
                  children: [
                    CheckRadioItem<String>(
                      txt: 'Giá lẻ',
                      groupValue: currentPriceType,
                      value: 'retailprice',
                      onChanged: (value) {
                        currentPriceType = 'retailprice';
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    CheckRadioItem<String>(
                      txt: 'Giá sỉ',
                      groupValue: currentPriceType,
                      value: 'wholesale',
                      onChanged: (value) {
                        currentPriceType = 'wholesale';
                      },
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ProductItem(
                  isEditting: true,
                  productInPackageResponse: listProducts[index],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
                  child: Divider(
                    color: Black40,
                  )),
              itemCount: listProducts.length),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final ProductInPackageResponse productInPackageResponse;
  final bool isEditting;
  const ProductItem(
      {super.key,
      this.isEditting = false,
      required this.productInPackageResponse});

  @override
  Widget build(BuildContext context) {
    String total_price = productInPackageResponse.priceFormat;
    String? unitName =
        productInPackageResponse.beerSubmitData?.listUnit?.firstOrNull?.name;
    String productName =
        '${productInPackageResponse.beerSubmitData?.name ?? 'Removed'}(${unitName ?? 'Removed'})';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(
            height: 80,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      border: defaultBorder,
                      borderRadius: defaultSquareBorderRadius,
                      color: BackgroundColor),
                  child: Center(
                    child: LoadSvg(
                        assetPath: 'svg/product.svg', width: 20, height: 20),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        productName,
                        style: headStyleXLarge,
                      ),
                      if (isEditting)
                        Container(
                          width: 127,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: defaultBorderRadius,
                              border: defaultBorder),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LoadSvg(
                                  assetPath: 'svg/minus.svg',
                                  width: 20,
                                  height: 20),
                              Expanded(
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  initialValue: productInPackageResponse
                                      .numberUnit
                                      .toString(),
                                  maxLines: 1,
                                  style: headStyleSemiLarge500,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    isDense: true,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              LoadSvg(
                                  assetPath: 'svg/plus.svg',
                                  width: 20,
                                  height: 20,
                                  color: TableHighColor)
                            ],
                          ),
                        )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (!isEditting) ...[
                      Text(
                        '15.000',
                        style: headStyleBigMediumBlackLight,
                      ),
                      Text(
                        'x6',
                        style: headStyleBigMedium,
                      )
                    ],
                    isEditting
                        ? Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.bottomCenter,
                            children: [
                              Text(
                                total_price,
                                style: headStyleXLargehightUnderline.copyWith(
                                  decorationColor: Colors.white,
                                ),
                              ),
                              Positioned(
                                bottom: -5,
                                child: Text(
                                  total_price,
                                  style: headStyleXLargehightUnderline.copyWith(
                                    color: Colors.transparent,
                                  ),
                                ),
                              )
                            ],
                          )
                        : Text(
                            total_price,
                            style: headStyleXLarge,
                          )
                  ],
                )
              ],
            ),
          ),
          if (isEditting)
            SizedBox(
              height: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 7,
                  ),
                  Divider(
                    color: Black15,
                    thickness: 0.3,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Giá bán',
                                  style: headStyleSemiLargeLigh500,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 60,
                                  child: TextFormField(
                                    textAlign: TextAlign.right,
                                    initialValue: '30.000',
                                    maxLines: 1,
                                    style: customerNameBigHight,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      isDense: true,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                LoadSvg(
                                    assetPath: 'svg/edit_pencil_line_01.svg')
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Chiết khấu',
                                  style: headStyleSemiLargeLigh500,
                                ),
                                SizedBox(
                                  width: 18,
                                ),
                                SwitchBtn(
                                  firstTxt: 'VND',
                                  secondTxt: '%',
                                )
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 60,
                                  child: TextFormField(
                                    textAlign: TextAlign.right,
                                    initialValue: '30.000',
                                    maxLines: 1,
                                    style: customerNameBigHight,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      isDense: true,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                LoadSvg(
                                    assetPath: 'svg/edit_pencil_line_01.svg')
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Ghi chú',
                                  style: headStyleSemiLargeLigh500,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: TextFormField(
                                    textAlign: TextAlign.right,
                                    initialValue: 'ghi chú ở đây',
                                    maxLines: 1,
                                    style: customerNameBigHight,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      isDense: true,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                LoadSvg(
                                    assetPath: 'svg/edit_pencil_line_01.svg')
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  LoadSvg(assetPath: 'svg/collapse.svg')
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class RoundBtn extends StatelessWidget {
  final String txt;
  final Widget icon;
  final bool isSelected;
  final VoidCallback onPressed;
  const RoundBtn({
    super.key,
    required this.txt,
    required this.icon,
    required this.onPressed,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: defaultBorderRadius,
          border: isSelected ? tableHighBorder : lightBorder,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(
              width: 10,
            ),
            Text(
              txt,
              style: isSelected
                  ? headStyleSemiLargeHigh500
                  : headStyleSemiLargeLigh500,
            ),
          ],
        ),
      ),
    );
  }
}
