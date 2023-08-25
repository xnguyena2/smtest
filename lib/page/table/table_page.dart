import 'package:flutter/material.dart';
import 'package:sales_management/utils/svg_loader.dart';

import '../../component/category_selector.dart';
import '../../utils/constants.dart';
import 'component/table_selector_bar.dart';

class TablePage extends StatelessWidget {
  const TablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TableSelectorBar(),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          color: BackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Status(),
              SizedBox(
                height: 10,
              ),
              CategorySelector(
                listCategory: ['Khu vực 1', 'Khu vực 2'],
              ),
              SizedBox(
                height: 5,
              ),
              ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Area();
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                  itemCount: 2),
            ],
          ),
        ),
      ),
    );
  }
}

class Area extends StatelessWidget {
  const Area({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Khu vực 1',
              style: headStyleMedium,
            ),
            Text('2 còn trống', style: headStyleMediumNormalLight),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: White,
            border: defaultBorder,
            borderRadius: defaultBorderRadius,
          ),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 120,
              childAspectRatio: 12 / 10,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 2 + 1,
            itemBuilder: (context, index) {
              if (index == 2)
                return Container(
                  decoration: BoxDecoration(
                    color: BackgroundColor,
                    borderRadius: defaultBorderRadius,
                    border: defaultBorder,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoadSvg(
                        assetPath: 'svg/plus.svg',
                        colorFilter: ColorFilter.mode(
                          MainHighColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Thêm bàn mới',
                        style: subInfoStyLargeHigh400,
                      ),
                    ],
                  ),
                );
              return TableItem(
                isSelected: index == 0,
              );
            },
          ),
        ),
      ],
    );
  }
}

class TableItem extends StatelessWidget {
  final bool isSelected;
  const TableItem({
    super.key,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: BackgroundColorLigh,
        borderRadius: defaultBorderRadius,
        border: isSelected ? tableHighBorder : defaultBorder,
      ),
      child: Column(
        children: [
          Container(
            color: isSelected ? TableHighBGColor : TableHeaderBGColor,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bàn 1',
                  style:
                      isSelected ? headStyleMediumNormaWhite : headStyleMedium,
                ),
              ],
            ),
          ),
          Expanded(
            child: isSelected
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LoadSvg(assetPath: 'svg/time_filled.svg'),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '18 giờ',
                            style: subInfoStyLargeTable400,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LoadSvg(assetPath: 'svg/money_alt.svg'),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '15.000',
                            style: subInfoStyLargeTable400,
                          )
                        ],
                      ),
                    ],
                  )
                : Center(
                    child: LoadSvg(assetPath: 'svg/table_filled.svg'),
                  ),
          ),
        ],
      ),
    );
  }
}

class Status extends StatelessWidget {
  const Status({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: White,
        borderRadius: defaultBorderRadius,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                LoadSvg(assetPath: 'svg/table.svg'),
                SizedBox(
                  width: 19,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Còn trống: ',
                    style: subInfoStyLarge500,
                    children: [
                      TextSpan(text: '99', style: subInfoStyLarge600High)
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
              height: 20,
              child: const VerticalDivider(
                width: 32,
              )),
          Expanded(
            child: Row(
              children: [
                LoadSvg(assetPath: 'svg/time.svg'),
                SizedBox(
                  width: 19,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Còn trống: ',
                    style: subInfoStyLarge500,
                    children: [
                      TextSpan(text: '99', style: subInfoStyLarge600High)
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
