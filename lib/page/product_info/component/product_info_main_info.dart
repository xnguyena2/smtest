import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/component/category_selector.dart';
import 'package:sales_management/component/high_border_container.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/page/home/api/model/bootstrap.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class MainProductInfo extends StatefulWidget {
  final BeerSubmitData product;
  const MainProductInfo({
    super.key,
    required this.product,
  });

  @override
  State<MainProductInfo> createState() => _MainProductInfoState();
}

class _MainProductInfoState extends State<MainProductInfo> {
  late final BeerSubmitData product;
  late Future<BootStrapData?> loadConfig;
  List<String> listCateSelected = [];
  late final List<String> listCategory;

  Future<BootStrapData?> getAllProduct() async {
    var box = Hive.box(hiveSettingBox);
    BootStrapData? config = box.get(hiveConfigKey);

    final listCategoryContent = config?.deviceConfig?.categorys ?? '';

    listCategory = List.from(jsonDecode(listCategoryContent));
    return config;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadConfig = getAllProduct();
    product = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    return FetchAPI<BootStrapData?>(
      future: loadConfig,
      successBuilder: (BootStrapData? data) => DefaultPaddingContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputFiledWithHeader(
              initValue: product.name,
              header: 'Tên sản phẩm',
              hint: 'Ví dụ: Mỳ hảo hảo',
              isImportance: true,
              onChanged: (value) {
                product.name = value;
              },
            ),
            SizedBox(
              height: 21,
            ),
            Row(
              children: [
                Expanded(
                  child: InputFiledWithHeader(
                    isNumberOnly: true,
                    isMoneyFormat: true,
                    initValue: (product.getPrice <= 0 ? '' : product.getPrice)
                        .toString(),
                    header: 'Giá bán',
                    hint: '0.000',
                    isImportance: true,
                    onChanged: (value) {
                      product.listUnit?.firstOrNull?.price =
                          double.tryParse(value) ?? 0;
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: InputFiledWithHeader(
                    isNumberOnly: true,
                    initValue:
                        (product.getBuyPrice <= 0 ? '' : product.getBuyPrice)
                            .toString(),
                    header: 'Giá vốn',
                    hint: '0.000',
                    isImportance: true,
                    onChanged: (value) {
                      product.listUnit?.firstOrNull?.buyPrice =
                          double.tryParse(value) ?? 0;
                    },
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
                    listCategory: listCategory,
                    onChanged: (listSelected) {
                      listCateSelected = listSelected;
                      product.updateListCat(listCateSelected);
                      setState(() {});
                    },
                    itemsSelected: listCateSelected,
                    isFlip: true,
                    firstWidget: LoadSvg(
                      assetPath: 'svg/menu.svg',
                    ),
                    multiSelected: true,
                    lastWidget: HighBorderContainer(
                      isHight: true,
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
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
