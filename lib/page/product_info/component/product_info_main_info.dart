import 'package:flutter/material.dart';
import 'package:sales_management/component/high_border_container.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class MainProductInfo extends StatelessWidget {
  const MainProductInfo({
    super.key,
  });

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
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return LoadSvg(
                          assetPath: 'svg/menu.svg',
                        );
                      }
                      if (index == 1) {
                        return CategoryItem(
                          txt: 'Đồ ăn',
                          isSelected: true,
                        );
                      }
                      if (index == 4) {
                        return HighBorderContainer(
                          padding: EdgeInsets.symmetric(
                              vertical: 11, horizontal: 18),
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
                        );
                      }
                      return CategoryItem(
                        txt: 'Mỳ ăn liền',
                        isSelected: false,
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          width: 12,
                        ),
                    itemCount: 5),
              ),
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
          isSelected
              ? SizedBox(
                  width: 10,
                )
              : SizedBox(),
          isSelected
              ? LoadSvg(
                  colorFilter:
                      ColorFilter.mode(TableHighColor, BlendMode.srcIn),
                  assetPath: 'svg/close_circle.svg')
              : SizedBox(),
        ],
      ),
    );
  }
}
