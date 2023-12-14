import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/btn/round_btn.dart';
import 'package:sales_management/component/btn/switch_btn.dart';
import 'package:sales_management/component/check_radio_item.dart';
import 'package:sales_management/component/image_loading.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/page/product_selector/component/provider_product.dart';
import 'package:sales_management/page/product_selector/product_selector_page.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';
import 'package:sales_management/utils/utils.dart';

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
  String currentPriceType = 'retailprice';
  late bool isDone = data.isDone;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: White,
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          if (!isDone)
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
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
                          assetPath: 'svg/plus_large.svg',
                          width: 20,
                          height: 20),
                      txt: 'Thêm sản phẩm',
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductSelectorPage(
                              packageDataResponse: data.clone(),
                              onUpdated: (PackageDataResponse) {
                                data.updateListProductItem(PackageDataResponse);
                              },
                            ),
                          ),
                        );
                        context.read<ProductProvider>().justRefresh();
                        setState(() {});
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
              final item = data.items[index];
              return ProductItem(
                key: ValueKey(
                    '${item.productSecondId + item.productUnitSecondId}${item.numberUnit}'),
                isEditting: !isDone,
                productInPackageResponse: item,
                updateNumberUnit: (productInPackageResponse) {
                  data.addOrUpdateProduct(productInPackageResponse);
                },
                onRefreshData: () {
                  data.updatePrice();
                  context.read<ProductProvider>().justRefresh();
                },
                onRemoveItem: () {
                  setState(() {});
                },
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
                height: 15,
                child: Divider(
                  color: Black40,
                )),
            itemCount: data.items.length,
          ),
        ],
      ),
    );
  }
}

class ProductItem extends StatefulWidget {
  final ProductInPackageResponse productInPackageResponse;
  final bool isEditting;
  final VoidCallbackArg<ProductInPackageResponse> updateNumberUnit;
  final VoidCallback onRefreshData;
  final VoidCallback onRemoveItem;
  const ProductItem(
      {super.key,
      this.isEditting = false,
      required this.productInPackageResponse,
      required this.updateNumberUnit,
      required this.onRefreshData,
      required this.onRemoveItem});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  static const double max_height = 130;
  double _container_edit_height = 0;
  late final ProductInPackageResponse productInPackageResponse;
  late String? imgUrl;
  late int unitNo;
  final TextEditingController noUnitTxtController = TextEditingController();
  final TextEditingController discountTxtController = TextEditingController();
  final FocusNode priceFocus = FocusNode();
  final FocusNode discountFocus = FocusNode();
  final FocusNode noteFocus = FocusNode();
  bool valueEmpty = false;
  bool isDiscountPercent = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productInPackageResponse = widget.productInPackageResponse;
    imgUrl = productInPackageResponse.beerSubmitData?.getFristLargeImg;
    unitNo = productInPackageResponse.numberUnit;
    noUnitTxtController.text = unitNo.toString();
    if (productInPackageResponse.discountPercent != 0 ||
        productInPackageResponse.discountAmount != 0) {
      isDiscountPercent = productInPackageResponse.discountPercent > 0;
    }
    discountTxtController.text = isDiscountPercent
        ? productInPackageResponse.discountPercent.toString()
        : MoneyFormater.format(productInPackageResponse.discountAmount);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    noUnitTxtController.dispose();
    discountTxtController.dispose();
    priceFocus.dispose();
    discountFocus.dispose();
    noteFocus.dispose();
  }

  void removeItemToPackage() {
    if (productInPackageResponse.numberUnit < 1) {
      return;
    }
    productInPackageResponse.numberUnit--;
    itemPackageChagneNo();
  }

  void addItemToPackage() {
    productInPackageResponse.numberUnit++;
    setState(() {});
  }

  void itemPackageChagneNo() {
    widget.updateNumberUnit(productInPackageResponse);
    unitNo = productInPackageResponse.numberUnit;
    noUnitTxtController.text = unitNo.toString();
    widget.onRefreshData();
    if (unitNo <= 0) {
      widget.onRemoveItem();
      return;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String priceDiscountFormat = productInPackageResponse.priceDiscountFormat;
    String totalPriceFormat =
        MoneyFormater.format(productInPackageResponse.totalPriceDiscount);
    String productName =
        productInPackageResponse.beerSubmitData?.get_show_name ?? 'Removed';

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
                    child: imgUrl == null
                        ? LoadSvg(
                            assetPath: 'svg/product.svg', width: 20, height: 20)
                        : AspectRatio(
                            aspectRatio: 1 / 1,
                            child: ImageLoading(url: imgUrl!),
                          ),
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
                      if (widget.isEditting)
                        Container(
                          width: 127,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: defaultBorderRadius,
                              border: defaultBorder),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  removeItemToPackage();
                                },
                                child: LoadSvg(
                                    assetPath: 'svg/minus.svg',
                                    width: 20,
                                    height: 20),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: noUnitTxtController,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: headStyleSemiLarge500,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    isDense: true,
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    valueEmpty = value.isEmpty;
                                    if (valueEmpty) {
                                      return;
                                    }
                                    productInPackageResponse.numberUnit =
                                        int.tryParse(value) ?? 0;
                                    itemPackageChagneNo();
                                  },
                                  onEditingComplete: () {
                                    if (valueEmpty) {
                                      noUnitTxtController.text =
                                          productInPackageResponse.numberUnit
                                              .toString();
                                    }
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  onTapOutside: (e) {
                                    if (valueEmpty) {
                                      noUnitTxtController.text =
                                          productInPackageResponse.numberUnit
                                              .toString();
                                    }
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  onFieldSubmitted: (v) {
                                    if (valueEmpty) {
                                      noUnitTxtController.text =
                                          productInPackageResponse.numberUnit
                                              .toString();
                                    }
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  addItemToPackage();
                                },
                                child: LoadSvg(
                                    assetPath: 'svg/plus.svg',
                                    width: 20,
                                    height: 20,
                                    color: TableHighColor),
                              )
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
                    if (!widget.isEditting) ...[
                      Text(
                        priceDiscountFormat,
                        style: headStyleBigMediumBlackLight,
                      ),
                      Text(
                        'x${productInPackageResponse.numberUnit}',
                        style: headStyleBigMedium,
                      )
                    ],
                    if (widget.isEditting)
                      GestureDetector(
                        onTap: () {
                          _container_edit_height = max_height;
                          setState(() {});
                        },
                        child: TextUnderlineCustome(
                            totalPriceFormat: totalPriceFormat),
                      )
                    else
                      Text(
                        totalPriceFormat,
                        style: headStyleXLarge,
                      )
                  ],
                )
              ],
            ),
          ),
          if (widget.isEditting)
            AnimatedContainer(
              height: _container_edit_height,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: SizedBox(
                  height: max_height,
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
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          focusNode: priceFocus,
                                          textAlign: TextAlign.right,
                                          initialValue: MoneyFormater.format(
                                              productInPackageResponse.price),
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            CurrencyInputFormatter(),
                                          ],
                                          maxLines: 1,
                                          style: customerNameBigHight,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.zero,
                                            isDense: true,
                                            border: InputBorder.none,
                                          ),
                                          onChanged: (value) {
                                            productInPackageResponse.price =
                                                double.tryParse(value) ?? 0;
                                            widget.onRefreshData();
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => priceFocus.requestFocus(),
                                        child: LoadSvg(
                                            assetPath:
                                                'svg/edit_pencil_line_01.svg'),
                                      )
                                    ],
                                  ),
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
                                      enableIndex: isDiscountPercent ? 1 : 0,
                                      onChanged: (index) {
                                        if (index == 0) {
                                          isDiscountPercent = false;
                                          productInPackageResponse
                                              .discountPercent = 0;
                                          productInPackageResponse
                                              .discountAmount = 0;
                                        } else {
                                          isDiscountPercent = true;
                                          productInPackageResponse
                                              .discountAmount = 0;
                                          productInPackageResponse
                                              .discountPercent = 0;
                                        }
                                        discountTxtController.text = '0';
                                        widget.onRefreshData();
                                        setState(() {});
                                      },
                                    )
                                  ],
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: discountTxtController,
                                          focusNode: discountFocus,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            if (isDiscountPercent)
                                              LengthLimitingTextInputFormatter(
                                                  2)
                                            else
                                              CurrencyInputFormatter(),
                                          ],
                                          textAlign: TextAlign.right,
                                          maxLines: 1,
                                          style: customerNameBigHight,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.zero,
                                            isDense: true,
                                            border: InputBorder.none,
                                          ),
                                          onChanged: (value) {
                                            if (isDiscountPercent) {
                                              productInPackageResponse
                                                      .discountPercent =
                                                  double.tryParse(value) ?? 0;
                                            } else {
                                              productInPackageResponse
                                                      .discountAmount =
                                                  tryParseMoney(value);
                                            }
                                            widget.onRefreshData();
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () =>
                                            discountFocus.requestFocus(),
                                        child: LoadSvg(
                                            assetPath:
                                                'svg/edit_pencil_line_01.svg'),
                                      )
                                    ],
                                  ),
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
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          focusNode: noteFocus,
                                          textAlign: TextAlign.right,
                                          initialValue:
                                              productInPackageResponse.note,
                                          maxLines: 1,
                                          style: customerNameBig,
                                          decoration: InputDecoration(
                                            hintText: 'Ghi chú',
                                            contentPadding: EdgeInsets.zero,
                                            isDense: true,
                                            border: InputBorder.none,
                                          ),
                                          onChanged: (value) {
                                            productInPackageResponse.note =
                                                value;
                                          },
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => noteFocus.requestFocus(),
                                        child: LoadSvg(
                                            assetPath:
                                                'svg/edit_pencil_line_01.svg'),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _container_edit_height = 0;
                          setState(() {});
                        },
                        child: LoadSvg(assetPath: 'svg/collapse.svg'),
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
}

class TextUnderlineCustome extends StatelessWidget {
  const TextUnderlineCustome({
    super.key,
    required this.totalPriceFormat,
  });

  final String totalPriceFormat;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Text(
          totalPriceFormat,
          style: headStyleXLargehightUnderline.copyWith(
            decorationColor: Colors.white,
          ),
        ),
        Positioned(
          bottom: -5,
          child: Text(
            totalPriceFormat,
            style: headStyleXLargehightUnderline.copyWith(
              color: Colors.transparent,
            ),
          ),
        )
      ],
    );
  }
}
