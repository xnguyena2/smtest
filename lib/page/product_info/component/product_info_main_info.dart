import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/component/category_selector.dart';
import 'package:sales_management/component/high_border_container.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/component/modal/simple_modal.dart';
import 'package:sales_management/page/home/api/home_api.dart';
import 'package:sales_management/page/home/api/model/bootstrap.dart';
import 'package:sales_management/page/product_info/api/model/category_container.dart';
import 'package:sales_management/page/product_info/component/modal_create_category.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/snack_bar.dart';
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
  BootStrapData? config;
  late List<String> listCateSelected = product.list_categorys ?? [];
  late List<String> listCategory;

  Future<BootStrapData?> getAllProduct() async {
    var box = Hive.box(hiveSettingBox);
    config = box.get(hiveConfigKey);

    final listCategoryContent = config?.deviceConfig?.categorys ?? '';

    listCategory = listCategoryContent.isEmpty
        ? []
        : List.from(jsonDecode(listCategoryContent));
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
              isNumberOnly: true,
              header: 'Giá sỉ',
              hint: '0-0',
              isImportance: false,
              isDisable: true,
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
                    lastWidget: GestureDetector(
                      onTap: () {
                        showDefaultModal(
                          context: context,
                          content: ModalCreateCategory(
                              onDone: (category) {
                                listCategory.add(category.category);
                                config?.deviceConfig?.categorys =
                                    jsonEncode(listCategory);
                                if (config?.deviceConfig != null) {
                                  udpateConfig(config!.deviceConfig!)
                                      .then((value) {
                                    var box = Hive.box(hiveSettingBox);
                                    box.put(hiveConfigKey, config);
                                    showNotification(
                                        context, 'Thêm danh mục thành công!');
                                  }).onError((error, stackTrace) {
                                    listCategory.remove(category.category);
                                    config?.deviceConfig?.categorys =
                                        jsonEncode(listCategory);
                                    showAlert(
                                        context, 'Không thể thêm danh mục!!');
                                  });
                                }
                                setState(() {});
                              },
                              config: CategoryContainer(category: '')),
                        );
                      },
                      child: HighBorderContainer(
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
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
