import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/btn/round_btn.dart';
import 'package:sales_management/component/btn/switch_btn.dart';
import 'package:sales_management/component/check_radio_item.dart';
import 'package:sales_management/component/checkbox/check_box.dart';
import 'package:sales_management/component/image_loading.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/component/textfield/editable_text_form_field.dart';
import 'package:sales_management/component/textfield/text_under_line_custome.dart';
import 'package:sales_management/page/product_selector/component/provider_product.dart';
import 'package:sales_management/page/product_selector/product_selector_page.dart';
import 'package:sales_management/utils/alter_dialog.dart';
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
  final bool enableAllFunction = false;
  late final PackageDataResponse data;
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
                  if (enableAllFunction) ...[
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
                  ],
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
                      padding: data.items.isNotEmpty
                          ? const EdgeInsets.symmetric(vertical: 10)
                          : const EdgeInsets.symmetric(vertical: 50),
                    ),
                  )
                ],
              ),
            ),
          if (data.items.isNotEmpty) ...[
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
  final TextEditingController itemPriceTxtController = TextEditingController();
  final FocusNode priceFocus = FocusNode();
  final FocusNode discountFocus = FocusNode();
  final FocusNode noteFocus = FocusNode();
  bool valueEmpty = false;
  bool isDiscountPercent = false;
  bool isProductValid = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productInPackageResponse = widget.productInPackageResponse;
    imgUrl =
        productInPackageResponse.beerSubmitData?.getUnitFristLargeOrDefaultImg;
    unitNo = productInPackageResponse.numberUnit;
    noUnitTxtController.text = unitNo.toString();
    if (productInPackageResponse.discountPercent != 0 ||
        productInPackageResponse.discountAmount != 0) {
      isDiscountPercent = productInPackageResponse.discountPercent > 0;
    }
    discountTxtController.text = MoneyFormater.format(isDiscountPercent
        ? productInPackageResponse.discountPercent
        : productInPackageResponse.discountAmount);
    isProductValid = !(productInPackageResponse.beerSubmitData == null ||
        productInPackageResponse.beerSubmitData?.isAvariable == false);
    itemPriceTxtController.text =
        MoneyFormater.format(productInPackageResponse.price);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    noUnitTxtController.dispose();
    discountTxtController.dispose();
    itemPriceTxtController.dispose();
    priceFocus.dispose();
    discountFocus.dispose();
    noteFocus.dispose();
  }

  void deleteItem() {
    productInPackageResponse.numberUnit = 0;
    itemPackageChagneNo();
  }

  void removeItemToPackage() {
    productInPackageResponse.numberUnit--;
    itemPackageChagneNo();
  }

  void addItemToPackage() {
    productInPackageResponse.numberUnit++;
    itemPackageChagneNo();
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

  void applyItemPrice(bool value) {
    productInPackageResponse.price = value
        ? productInPackageResponse.getWholesalePrice
        : productInPackageResponse.getPrice;
    itemPriceTxtController.text =
        MoneyFormater.format(productInPackageResponse.price);
  }

  @override
  Widget build(BuildContext context) {
    String priceDiscountFormat = productInPackageResponse.priceDiscountFormat;
    String totalPriceFormat =
        MoneyFormater.format(productInPackageResponse.totalPriceDiscount);
    String productName = productInPackageResponse.get_show_name;

    final isWholesaleMode = productInPackageResponse.isWholesaleMode;

    final isApplyWholesaleMode = productInPackageResponse.isApplyWholesaleMode;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
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
                                assetPath: 'svg/product.svg',
                                width: 20,
                                height: 20)
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                productName,
                                style: headStyleXLarge,
                              ),
                            ],
                          ),
                          if (widget.isEditting)
                            Container(
                              width: 127,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: defaultBorderRadius,
                                  border: defaultBorder),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      textInputAction: TextInputAction.done,
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
                                              productInPackageResponse
                                                  .numberUnit
                                                  .toString();
                                        }
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                      onTapOutside: (e) {
                                        if (valueEmpty) {
                                          noUnitTxtController.text =
                                              productInPackageResponse
                                                  .numberUnit
                                                  .toString();
                                        }
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                      onFieldSubmitted: (v) {
                                        if (valueEmpty) {
                                          noUnitTxtController.text =
                                              productInPackageResponse
                                                  .numberUnit
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
                          else if (isWholesaleMode && isApplyWholesaleMode)
                            const Text(
                              'Đã áp giá sỉ',
                              style: headStyleSmallLarge,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (widget.isEditting) ...[
                          if (isWholesaleMode)
                            Row(
                              children: [
                                const Text(
                                  'Áp giá sỉ:',
                                  style: headStyleSmallLarge,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SmallCheckBox(
                                  key: ValueKey(isApplyWholesaleMode),
                                  isChecked: isApplyWholesaleMode,
                                  onChanged: (value) {
                                    applyItemPrice(value);
                                    widget.onRefreshData();
                                    setState(() {});
                                  },
                                ),
                              ],
                            )
                          else
                            SizedBox(),
                          GestureDetector(
                            onTap: () {
                              _container_edit_height = max_height;
                              setState(() {});
                            },
                            child: TextUnderlineCustome(
                                totalPriceFormat: totalPriceFormat),
                          ),
                        ] else ...[
                          Text(
                            priceDiscountFormat,
                            style: headStyleBigMediumBlackLight,
                          ),
                          Text(
                            'x${productInPackageResponse.numberUnit}',
                            style: headStyleBigMedium,
                          ),
                          Text(
                            totalPriceFormat,
                            style: headStyleXLarge,
                          )
                        ],
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
                          const SizedBox(
                            height: 7,
                          ),
                          const Divider(
                            color: Black15,
                            thickness: 0.3,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Row(
                                      children: [
                                        Text(
                                          'Giá bán',
                                          style: headStyleSemiLargeLigh500,
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: EditAbleTextFormField(
                                        controller: itemPriceTxtController,
                                        focusNode: priceFocus,
                                        textAlign: TextAlign.right,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          CurrencyInputFormatter(),
                                        ],
                                        maxLines: 1,
                                        style: customerNameBigHight,
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.zero,
                                          isDense: true,
                                          border: InputBorder.none,
                                        ),
                                        onTapOutside: (event) {
                                          priceFocus.unfocus();
                                        },
                                        onChanged: (value) {
                                          productInPackageResponse.price =
                                              tryParseMoney(value);
                                          widget.onRefreshData();
                                          setState(() {});
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Chiết khấu',
                                          style: headStyleSemiLargeLigh500,
                                        ),
                                        const SizedBox(
                                          width: 18,
                                        ),
                                        SwitchBtn(
                                          firstTxt: 'VND',
                                          secondTxt: '%',
                                          enableIndex:
                                              isDiscountPercent ? 1 : 0,
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
                                      child: EditAbleTextFormField(
                                        controller: discountTxtController,
                                        focusNode: discountFocus,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          CurrencyInputFormatter(),
                                          if (isDiscountPercent)
                                            LengthLimitingTextInputFormatter(2)
                                        ],
                                        textAlign: TextAlign.right,
                                        maxLines: 1,
                                        style: customerNameBigHight,
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.zero,
                                          isDense: true,
                                          border: InputBorder.none,
                                        ),
                                        onTapOutside: (event) {
                                          discountFocus.unfocus();
                                        },
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
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Row(
                                      children: [
                                        Text(
                                          'Ghi chú',
                                          style: headStyleSemiLargeLigh500,
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: EditAbleTextFormField(
                                        focusNode: noteFocus,
                                        textAlign: TextAlign.right,
                                        initialValue:
                                            productInPackageResponse.note,
                                        maxLines: 1,
                                        style: customerNameBig,
                                        decoration: const InputDecoration(
                                          hintText: 'Ghi chú',
                                          contentPadding: EdgeInsets.zero,
                                          isDense: true,
                                          border: InputBorder.none,
                                        ),
                                        onTapOutside: (event) {
                                          noteFocus.unfocus();
                                        },
                                        onChanged: (value) {
                                          productInPackageResponse.note = value;
                                        },
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
        ),
        if (widget.isEditting)
          Positioned(
            top: -8,
            left: 2,
            child: GestureDetector(
              onTap: () {
                deleteItem();
              },
              child: LoadSvg(assetPath: 'svg/close_circle.svg'),
            ),
          ),
        if (!isProductValid)
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                showDefaultDialog(context, 'Thông báo!',
                    'có vẻ sản phẩm đã hết hàng hoặc bị xóa, bạn hãy kiểm tra lại tình trạng sản phẩm đảm bảo rằng vẫn còn hàng để tiếp tục bán!!',
                    onOk: () {}, onCancel: () {});
              },
              child: Container(
                decoration: BoxDecoration(
                  color: White70,
                  borderRadius: defaultBorderRadius,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
