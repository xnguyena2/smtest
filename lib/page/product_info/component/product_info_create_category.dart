import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/component/btn/round_btn.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/component/modal/simple_modal.dart';
import 'package:sales_management/component/textfield/editable_text_form_field.dart';
import 'package:sales_management/component/textfield/text_under_line_custome.dart';
import 'package:sales_management/page/product_info/component/modal_create_product_unit.dart';
import 'package:sales_management/page/product_info/component/modal_edit_price_warehouse_product_unit.dart';
import 'package:sales_management/page/product_unit_info/product_info.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/utils.dart';

class ProductCreateCategory extends StatefulWidget {
  final BeerSubmitData product;
  const ProductCreateCategory({
    super.key,
    required this.product,
  });

  @override
  State<ProductCreateCategory> createState() => _ProductCreateCategoryState();
}

class _ProductCreateCategoryState extends State<ProductCreateCategory> {
  @override
  Widget build(BuildContext context) {
    bool isHaveMultiCategory = widget.product.isHaveMultiCategory;
    updateCatgory() => showDefaultModal(
          context: context,
          content: ModalCreateProductUnit(
            onDone: (category) {
              widget.product.setUnitCat(category);
              setState(() {});
            },
            productUnitCatPattern: widget.product.productUnitCatPattern.clone(),
          ),
        );
    return DefaultPaddingContainer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Phân loại',
              style: headStyleXLarge,
            ),
            if (isHaveMultiCategory)
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      final listUnit = widget.product.clone().listUnit;
                      if (listUnit == null) {
                        return;
                      }
                      showDefaultModal(
                        context: context,
                        content: ModalEditPriceWarehouseProductUnit(
                          onDone: (listU) {
                            widget.product.setListUnit(listU);
                            setState(() {});
                          },
                          listBeerUnit: listUnit,
                        ),
                      );
                    },
                    child: LoadSvg(
                      assetPath: 'svg/edit_pencil_line_01.svg',
                      color: Black,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: updateCatgory,
                    child: LoadSvg(
                        assetPath: 'svg/setting.svg',
                        color: Black,
                        width: 20,
                        height: 20),
                  ),
                ],
              ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        if (!isHaveMultiCategory) ...[
          Text(
            'Tạo phân loại cho sản phẩm như kích thước, màu sắc,...',
            style: subStyleMediumNormalLight,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: RoundBtn(
                  isSelected: true,
                  icon: LoadSvg(
                      assetPath: 'svg/plus_large.svg', width: 20, height: 20),
                  txt: 'Thêm phân loại',
                  onPressed: updateCatgory,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ],
          ),
        ] else
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = widget.product.listUnit?[index];
                if (item == null) {
                  return SizedBox();
                }
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductUnitInfo(
                          product: widget.product
                              .cloneMainDataWithoutUnitCatConfig(item.clone()),
                          onAdded: (unit) {
                            widget.product.updateUnit(unit.firstOrNull);
                            setState(() {});
                          },
                        ),
                      ),
                    );
                  },
                  child: _ProductUnit(
                    key: ValueKey(
                        '${item.beerUnitSecondId}-${item.price}-${item.buyPrice}'),
                    item: item,
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(
                    color: Black40,
                    height: 1,
                    thickness: 0.5,
                  ),
              itemCount: widget.product.listUnit?.length ?? 0)
      ],
    ));
  }
}

class _ProductUnit extends StatefulWidget {
  const _ProductUnit({
    super.key,
    required this.item,
  });

  final BeerUnit item;

  @override
  State<_ProductUnit> createState() => _ProductUnitState();
}

class _ProductUnitState extends State<_ProductUnit> {
  late BeerUnit item = widget.item;
  static const double max_height = 85;
  double _container_edit_height = 0;

  late final TextEditingController unitPrice =
      TextEditingController(text: MoneyFormater.format(widget.item.price));

  final FocusNode priceFocus = FocusNode();
  final FocusNode buyPriceFocus = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    priceFocus.dispose();
    buyPriceFocus.dispose();
    unitPrice.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: White,
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.name,
                    style: headStyleSemiLarge400,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.item.sku ?? 'SP00001',
                    style: subStyleMediumNormalLight,
                  ),
                ],
              ),
              Row(
                children: [
                  if (item.isHide)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 4,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: defaultBorderRadius,
                          color: BackgroundColor),
                      child: const Text(
                        'Tạm ẩn',
                        style: subStatusInfoStyMedium600,
                      ),
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          item.isAvariable ? 'Còn hàng' : 'hết hàng',
                          style: subStyleMediumNormalLight,
                        ),
                        GestureDetector(
                          onTap: () {
                            _container_edit_height = max_height;
                            setState(() {});
                          },
                          child: TextUnderlineCustome(
                            totalPriceFormat: unitPrice.text,
                          ),
                        ),
                      ],
                    ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      item.changeTohide(!item.isHide);
                      setState(() {});
                    },
                    child: LoadSvg(
                        assetPath:
                            item.isHide ? 'svg/eye_slash.svg' : 'svg/eye.svg'),
                  ),
                ],
              )
            ],
          ),
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
                      height: 1,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  controller: unitPrice,
                                  focusNode: priceFocus,
                                  textAlign: TextAlign.right,
                                  keyboardType: TextInputType.number,
                                  spaceBetween: 10,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
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
                                    item.price = tryParseMoney(value);
                                    setState(() {});
                                  },
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    'Giá vốn',
                                    style: headStyleSemiLargeLigh500,
                                  ),
                                ],
                              ),
                              Expanded(
                                child: EditAbleTextFormField(
                                  focusNode: buyPriceFocus,
                                  initialValue:
                                      MoneyFormater.format(item.buyPrice),
                                  textAlign: TextAlign.right,
                                  keyboardType: TextInputType.number,
                                  spaceBetween: 10,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
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
                                    buyPriceFocus.unfocus();
                                  },
                                  onChanged: (value) {
                                    item.buyPrice = tryParseMoney(value);
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
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
