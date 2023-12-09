import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/component/high_border_container.dart';
import 'package:sales_management/page/home/api/model/bootstrap.dart';
import 'package:sales_management/page/product_info/product_info.dart';
import 'package:sales_management/page/product_selector/component/product_selector_bar.dart';
import 'package:sales_management/page/product_selector/component/product_selector_bottombar.dart';
import 'package:sales_management/page/product_selector/component/product_selector_product_item.dart';
import 'package:sales_management/page/product_selector/component/provider_product.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';
import 'package:sales_management/utils/utils.dart';

import '../../component/category_selector.dart';

class ProductSelectorPage extends StatefulWidget {
  final PackageDataResponse? packageDataResponse;
  final VoidCallbackArg<PackageDataResponse> onUpdated;
  const ProductSelectorPage(
      {super.key, required this.packageDataResponse, required this.onUpdated});

  @override
  State<ProductSelectorPage> createState() => _ProductSelectorPageState();
}

class _ProductSelectorPageState extends State<ProductSelectorPage> {
  late Future<BootStrapData?> loadConfig;
  late List<BeerSubmitData> listAllProduct;
  late List<BeerSubmitData> listProduct;
  late List<BeerSubmitData> listProductOfCat;
  late List<String> listCategory;

  List<String> listCateSelected = ['Tất cả'];

  late final isProductSelector = widget.packageDataResponse != null;

  Future<BootStrapData?> getAllProduct(Box<dynamic> box) async {
    // var box = Hive.box(hiveSettingBox);
    BootStrapData? config = box.get(hiveConfigKey);
    if (config == null) {
      return null;
    }

    final results = config.products;
    final listCategoryContent = config.deviceConfig?.categorys ?? '';
    listCategory = ['Tất cả'];

    final List<String> allCat = listCategoryContent.isEmpty
        ? []
        : List.from(jsonDecode(listCategoryContent));
    listCategory.addAll(allCat);

    listAllProduct = flatten<BeerSubmitData>(results.map(
      (e) {
        return e.flatUnit();
      },
    ));
    listAllProduct.sort(
      (a, b) => a.name.compareTo(b.name),
    );
    listProductOfCat = listProduct = listAllProduct;
    return config;
  }

  Future<BootStrapData?> addProduct(BeerSubmitData product) async {
    var box = Hive.box(hiveSettingBox);
    BootStrapData? config = box.get(hiveConfigKey);
    if (config == null) {
      return null;
    }

    config.addOrReplaceProduct(product);

    box.put(hiveConfigKey, config);

    final results = config.products;
    final listCategoryContent = config.deviceConfig?.categorys ?? '';
    listCategory = ['Tất cả'];

    final List<String> allCat = List.from(jsonDecode(listCategoryContent));
    listCategory.addAll(allCat);

    listAllProduct = flatten<BeerSubmitData>(results.map(
      (e) {
        return e.flatUnit();
      },
    ));
    listAllProduct.sort(
      (a, b) => a.name.compareTo(b.name),
    );
    listProductOfCat = listProduct = listAllProduct;
    return config;
  }

  void showProductInfo(BeerSubmitData product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductInfo(
          product: product,
          onAdded: (product) {
            loadConfig = addProduct(product);
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addNewProduct = () {
      showProductInfo(BeerSubmitData.createEmpty(groupID, generateUUID()));
    };
    return SafeArea(
      top: false,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ProductProvider(widget.packageDataResponse),
          )
        ],
        child: Scaffold(
          appBar: ProductSelectorBar(
            onBackPressed: () {
              Navigator.pop(context);
            },
            onChanged: (searchTxt) {
              listProduct = listProductOfCat
                  .where((element) => element.searchMatch(searchTxt))
                  .toList();
              setState(() {});
            },
          ),
          floatingActionButton: isProductSelector
              ? null
              : FloatingActionButton.small(
                  elevation: 2,
                  backgroundColor: MainHighColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: floatBottomBorderRadius,
                  ),
                  onPressed: addNewProduct,
                  child: LoadSvg(
                    assetPath: 'svg/plus_large_width_2.svg',
                    color: White,
                  ),
                ),
          body: ValueListenableBuilder<Box>(
            valueListenable:
                Hive.box(hiveSettingBox).listenable(keys: [hiveConfigKey]),
            builder: (context, value, child) {
              loadConfig = getAllProduct(value);
              return FetchAPI<BootStrapData?>(
                future: loadConfig, //getall(),
                successBuilder: (BootStrapData? data) {
                  if (listAllProduct.isEmpty) {
                    return Center(
                      child: GestureDetector(
                        onTap: addNewProduct,
                        child: HighBorderContainer(
                          isHight: true,
                          padding: EdgeInsets.symmetric(
                              vertical: 11, horizontal: 18),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              LoadSvg(assetPath: 'svg/plus_large.svg'),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Tạo sản phẩm',
                                style: headStyleSemiLargeHigh500,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                      color: BackgroundColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CategorySelector(
                            listCategory: listCategory,
                            multiSelected: false,
                            onChanged: (listCategorySelected) {
                              listCateSelected = listCategorySelected;
                              final String? firstCat =
                                  listCategorySelected.firstOrNull;
                              if (firstCat == null || firstCat == 'Tất cả') {
                                listProductOfCat = listProduct = listAllProduct;
                                setState(() {});
                                return;
                              }
                              listProductOfCat = listProduct = listAllProduct
                                  .where((element) => element
                                      .isContainCategory(listCateSelected))
                                  .toList();

                              setState(() {});
                            },
                            itemsSelected: listCateSelected,
                            firstWidget:
                                LoadSvg(assetPath: 'svg/grid_horizontal.svg'),
                            isFlip: false,
                          ),
                          if (isProductSelector)
                            selectProduct()
                          else
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final item = listProduct[index];
                                return GestureDetector(
                                  onTap: () {
                                    showProductInfo(item.clone());
                                  },
                                  child: ProductManagerItem(
                                    productData: item,
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10,
                              ),
                              itemCount: listProduct.length,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          bottomNavigationBar: isProductSelector
              ? ProductSelectorBottomBar(
                  done: () {
                    widget.onUpdated(widget.packageDataResponse!);
                    Navigator.pop(context);
                  },
                  cancel: () {
                    Navigator.pop(context);
                  },
                )
              : null,
        ),
      ),
    );
  }

  GridView selectProduct() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 120,
        childAspectRatio: 1 / 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: listProduct.length + 1,
      itemBuilder: (context, index) {
        if (index == listProduct.length) {
          return GestureDetector(
            onTap: () {
              showProductInfo(
                  BeerSubmitData.createEmpty(groupID, generateUUID()));
            },
            child: Container(
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
                      color: MainHighColor,
                    ),
                    const Positioned(
                      bottom: -25,
                      child: Text(
                        'Thêm sản phẩm',
                        style: subInfoStyLargeHigh400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        BeerSubmitData productData = listProduct[index];
        final productUnitID =
            productData.listUnit?.firstOrNull?.beerUnitSecondId;
        return ProductSelectorItem(
          key: ValueKey(productUnitID),
          productData: productData,
          productInPackageResponse: productUnitID == null
              ? null
              : widget.packageDataResponse!.productMap[productUnitID],
          updateNumberUnit: (productInPackageResponse) {
            widget.packageDataResponse!
                .addOrUpdateProduct(productInPackageResponse);
            context.read<ProductProvider>().justRefresh();
          },
        );
      },
    );
  }
}

class ProductManagerItem extends StatelessWidget {
  final BeerSubmitData productData;
  const ProductManagerItem({
    super.key,
    required this.productData,
  });

  @override
  Widget build(BuildContext context) {
    final imgUrl = productData.getFristLargeImg;
    final name = productData.get_show_name;
    final price = productData.getRealPrice;

    return Container(
      decoration: BoxDecoration(
        color: White,
        borderRadius: defaultBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ConstrainedBox(
          constraints: BoxConstraints.tight(Size.fromHeight(70)),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    border: defaultBorder,
                    color: BackgroundColor,
                    borderRadius: defaultBorderRadius,
                    image: DecorationImage(
                      image: (imgUrl == null
                          ? const AssetImage(
                              'assets/images/product.png',
                            )
                          : NetworkImage(imgUrl)) as ImageProvider,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 18,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      name,
                      style: headStyleSemiLarge500,
                    ),
                    Text(
                      MoneyFormater.format(price),
                      style: headStyleSemiLargeHigh500,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
