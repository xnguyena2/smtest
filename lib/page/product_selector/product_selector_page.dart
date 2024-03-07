import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sales_management/api/local_storage/local_storage.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/component/high_border_container.dart';
import 'package:sales_management/component/loading_overlay_alt.dart';
import 'package:sales_management/page/create_order/create_order_page.dart';
import 'package:sales_management/page/home/api/model/bootstrap.dart';
import 'package:sales_management/page/order_list/provider/search_provider.dart';
import 'package:sales_management/page/product_info/product_info.dart';
import 'package:sales_management/page/product_selector/component/product_selector_bar.dart';
import 'package:sales_management/page/product_selector/component/product_selector_bottombar.dart';
import 'package:sales_management/page/product_selector/component/product_selector_manager_item.dart';
import 'package:sales_management/page/product_selector/component/product_selector_product_item.dart';
import 'package:sales_management/page/product_selector/component/provider_product.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';
import 'package:sales_management/utils/utils.dart';

import '../../component/category_selector.dart';

class ProductSelectorPage extends StatefulWidget {
  final bool firstSelectProductWhenCreateOrder;
  final VoidCallbackArg<PackageDataResponse>? onUpdatedPasstoCreateOrder;
  final VoidCallbackArg<PackageDataResponse>? onDeletedPasstoCreateOrder;
  final PackageDataResponse? packageDataResponse;
  final VoidCallbackArg<PackageDataResponse> onUpdated;
  const ProductSelectorPage({
    super.key,
    required this.packageDataResponse,
    required this.onUpdated,
    this.firstSelectProductWhenCreateOrder = false,
    this.onUpdatedPasstoCreateOrder,
    this.onDeletedPasstoCreateOrder,
  });

  @override
  State<ProductSelectorPage> createState() => _ProductSelectorPageState();
}

class _ProductSelectorPageState extends State<ProductSelectorPage> {
  final GlobalKey<__BodyContenStateState> _keyBody = GlobalKey();

  late Future<BootStrapData?> loadConfig;
  late List<BeerSubmitData> listAllProduct;
  late List<String> listCategory;

  late final isProductSelector = widget.packageDataResponse != null;

  void loadDataFrom({required BootStrapData config}) {
    final results = config.products;
    final listCategoryContent = config.deviceConfig?.categorys ?? '';
    listCategory = ['Tất cả'];

    final List<String> allCat = listCategoryContent.isEmpty
        ? []
        : List.from(jsonDecode(listCategoryContent));
    listCategory.addAll(allCat);

    listAllProduct = results;
    listAllProduct.sort(
      (a, b) => a.name.compareTo(b.name),
    );
  }

  Future<BootStrapData?> getAllProduct(Box<dynamic> box) async {
    BootStrapData? config = LocalStorage.getBootStrap(box);
    if (config == null) {
      return null;
    }
    loadDataFrom(config: config);
    return config;
  }

  Future<BootStrapData?> addProduct(BeerSubmitData product) async {
    BootStrapData? config = LocalStorage.getBootStrap();
    if (config == null) {
      return null;
    }

    config.addOrReplaceProduct(product);

    LocalStorage.setBootstrapData(config);

    loadDataFrom(config: config);

    return config;
  }

  Future<BootStrapData?> updateProduct(BeerSubmitData product) async {
    BootStrapData? config = LocalStorage.getBootStrap();
    if (config == null) {
      return null;
    }

    config.addOrReplaceProduct(product);

    LocalStorage.setBootstrapData(config);

    return config;
  }

  Future<BootStrapData?> deleteProduct(BeerSubmitData product) async {
    BootStrapData? config = LocalStorage.getBootStrap();
    if (config == null) {
      return null;
    }

    config.deleteProduct(product);

    LocalStorage.setBootstrapData(config);

    loadDataFrom(config: config);

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
            _keyBody.currentState?.updateListProduct(listAllProduct);
          },
          onDeleted: (product) {
            loadConfig = deleteProduct(product);
            _keyBody.currentState?.updateListProduct(listAllProduct);
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
    addNewProduct() {
      showProductInfo(BeerSubmitData.createEmpty(groupID));
    }

    return LoadingOverlayAlt(
      child: SafeArea(
        top: false,
        bottom: false,
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => ProductProvider(widget.packageDataResponse),
            ),
            ChangeNotifierProvider(
              create: (_) => SearchProvider(''),
            ),
          ],
          child: Builder(builder: (context) {
            return Scaffold(
              appBar: ProductSelectorBar(
                onBackPressed: () {
                  Navigator.pop(context);
                },
                onChanged: (searchTxt) {
                  context.read<SearchProvider>().updateValue = searchTxt;
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
                valueListenable: LocalStorage.getListenBootStrapKey(),
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 11, horizontal: 18),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  LoadSvg(assetPath: 'svg/plus_large.svg'),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    'Tạo sản phẩm',
                                    style: headStyleSemiLargeHigh500,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return _BodyContenState(
                        key: _keyBody,
                        listCategory: listCategory,
                        listAllProduct: listAllProduct,
                        packageDataResponse: widget.packageDataResponse,
                        showProduct: (BeerSubmitData) {
                          showProductInfo(BeerSubmitData);
                        },
                        updateProduct: updateProduct,
                      );
                    },
                  );
                },
              ),
              bottomNavigationBar: isProductSelector
                  ? ProductSelectorBottomBar(
                      done: () {
                        if (widget.firstSelectProductWhenCreateOrder) {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateOrderPage(
                                data: widget.packageDataResponse!,
                                onUpdated: widget.onUpdatedPasstoCreateOrder!,
                                onDelete: widget.onDeletedPasstoCreateOrder!,
                                isTempOrder: true,
                              ),
                            ),
                          );
                          return;
                        }
                        widget.packageDataResponse?.cleanEmptyProduct();
                        widget.onUpdated(widget.packageDataResponse!);
                        Navigator.pop(context);
                      },
                      cancel: () {
                        Navigator.pop(context);
                      },
                    )
                  : null,
            );
          }),
        ),
      ),
    );
  }
}

class _BodyContenState extends StatefulWidget {
  final PackageDataResponse? packageDataResponse;
  final List<String> listCategory;
  final List<BeerSubmitData> listAllProduct;
  final VoidCallbackArg<BeerSubmitData> showProduct;
  final VoidCallbackArg<BeerSubmitData> updateProduct;

  const _BodyContenState({
    super.key,
    required this.listCategory,
    required this.listAllProduct,
    required this.packageDataResponse,
    required this.showProduct,
    required this.updateProduct,
  });

  @override
  State<_BodyContenState> createState() => __BodyContenStateState();
}

class __BodyContenStateState extends State<_BodyContenState> {
  late List<BeerSubmitData> listProduct;
  late List<BeerSubmitData> listProductOfCat;
  List<String> listCateSelected = ['Tất cả'];

  late final isProductSelector = widget.packageDataResponse != null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listProductOfCat = listProduct = widget.listAllProduct;
  }

  void updateListProduct(List<BeerSubmitData> listAllProduct) {
    listProductOfCat = listProduct = listAllProduct;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchProvider>().getTxt ?? '';
    listProduct = listProductOfCat
        .where((element) => element.searchMatch(filter))
        .toList();
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
        color: BackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategorySelector(
              listCategory: widget.listCategory,
              multiSelected: false,
              onChanged: (listCategorySelected) {
                listCateSelected = listCategorySelected;
                final String? firstCat = listCategorySelected.firstOrNull;
                if (firstCat == null || firstCat == 'Tất cả') {
                  listProductOfCat = listProduct = widget.listAllProduct;
                  setState(() {});
                  return;
                }
                listProductOfCat = listProduct = widget.listAllProduct
                    .where((element) =>
                        element.isContainCategory(listCateSelected))
                    .toList();
                print(listProduct.length);

                setState(() {});
              },
              itemsSelected: listCateSelected,
              firstWidget: LoadSvg(assetPath: 'svg/grid_horizontal.svg'),
              isFlip: false,
            ),
            if (isProductSelector) selectProduct() else listAllProductInfo(),
          ],
        ),
      ),
    );
  }

  ListView listAllProductInfo() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final item = listProduct[index];
        final productID = item.beerSecondID;
        return GestureDetector(
          key: ValueKey(productID),
          onTap: () {
            widget.showProduct(item.clone());
          },
          child: ProductManagerItem(
            productData: item,
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemCount: listProduct.length,
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
              widget.showProduct(BeerSubmitData.createEmpty(groupID));
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
        final productID = productData.beerSecondID;
        return ProductSelectorItem(
          key: ValueKey(productID),
          productData: productData,
          updateNumberUnit: (productInPackageResponse) {
            widget.packageDataResponse!
                .addOrUpdateProduct(productInPackageResponse);
            context.read<ProductProvider>().justRefresh();
          },
          onChanged: (p) {
            widget.updateProduct(p);
            setState(() {});
          },
          productInPackage: widget.packageDataResponse!.productMap[productID],
        );
      },
    );
  }
}
