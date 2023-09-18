import 'package:flutter/material.dart';
import 'package:sales_management/component/btn/switch_btn.dart';
import 'package:sales_management/component/check_radio_item.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class ListProduct extends StatelessWidget {
  const ListProduct({
    super.key,
  });

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
                    CheckRadioItem(isCheck: false, txt: 'Giá lẻ'),
                    SizedBox(
                      width: 20,
                    ),
                    CheckRadioItem(isCheck: true, txt: 'Giá sỉ')
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
                );
              },
              separatorBuilder: (context, index) =>
                  SizedBox(height: 15, child: Divider()),
              itemCount: 3),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final bool isEditting;
  const ProductItem({super.key, this.isEditting = false});

  @override
  Widget build(BuildContext context) {
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
                        'Mỳ hảo hảo',
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
                                  initialValue: '99',
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
                                  colorFilter: ColorFilter.mode(
                                      TableHighColor, BlendMode.srcIn))
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
                                '90.000',
                                style: headStyleXLargehightUnderline.copyWith(
                                  decorationColor: Colors.white,
                                ),
                              ),
                              Positioned(
                                bottom: -5,
                                child: Text(
                                  '90.000',
                                  style: headStyleXLargehightUnderline.copyWith(
                                    color: Colors.transparent,
                                  ),
                                ),
                              )
                            ],
                          )
                        : Text(
                            '90.000',
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
                  Divider(),
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
  const RoundBtn({
    super.key,
    required this.txt,
    required this.icon,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
