import 'package:flutter/material.dart';
import 'package:sales_management/component/category_selector.dart';
import 'package:sales_management/component/high_border_container.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class MainProductInfo extends StatefulWidget {
  const MainProductInfo({
    super.key,
  });

  @override
  State<MainProductInfo> createState() => _MainProductInfoState();
}

class _MainProductInfoState extends State<MainProductInfo> {
  List<String> listCateSelected = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultPaddingContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputFiledWithHeader(
            header: 'Tên sản phẩm',
            hint: 'Ví dụ: Mỳ hảo hảo',
            isImportance: true,
          ),
          SizedBox(
            height: 21,
          ),
          Row(
            children: [
              Expanded(
                child: InputFiledWithHeader(
                  header: 'Giá bán',
                  hint: '0.000',
                  isImportance: true,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: InputFiledWithHeader(
                  header: 'Giá vốn',
                  hint: '0.000',
                  isImportance: true,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 21,
          ),
          InputFiledWithHeader(
            header: 'Giá sỉ',
            hint: '0-0',
            isImportance: false,
          ),
          SizedBox(
            height: 21,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Danh mục',
                style: headStyleSemiLarge400,
              ),
              SizedBox(
                height: 7,
              ),
              SizedBox(
                  height: 42,
                  child: CategorySelector(
                    listCategory: ['đồ ăn', 'mỳ ăn liền'],
                    onChanged: (listSelected) {
                      listCateSelected = listSelected;
                      setState(() {});
                    },
                    itemsSelected: listCateSelected,
                    isFlip: true,
                    firstWidget: LoadSvg(
                      assetPath: 'svg/menu.svg',
                    ),
                    multiSelected: true,
                    lastWidget: HighBorderContainer(
                      padding:
                          EdgeInsets.symmetric(vertical: 11, horizontal: 18),
                      child: Row(
                        children: [
                          LoadSvg(assetPath: 'svg/plus_large.svg'),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Tạo danh muc',
                            style: headStyleSemiLargeHigh500,
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String txt;
  final bool isSelected;
  const CategoryItem({
    super.key,
    required this.txt,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 11, horizontal: 18),
      decoration: BoxDecoration(
          color: isSelected ? HighColor15 : BackgroundColor,
          borderRadius: defaultBorderRadius),
      child: Row(
        children: [
          Text(
            txt,
            style: isSelected
                ? headStyleSemiLargeHigh400
                : headStyleSemiLargeLight400,
          ),
          if (isSelected) ...[
            SizedBox(
              width: 10,
            ),
            LoadSvg(color: TableHighColor, assetPath: 'svg/close_circle.svg')
          ],
        ],
      ),
    );
  }
}
