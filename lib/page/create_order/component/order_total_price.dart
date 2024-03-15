import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/btn/round_btn.dart';
import 'package:sales_management/component/btn/switch_btn.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/component/loading_overlay_alt.dart';
import 'package:sales_management/component/modal/simple_modal.dart';
import 'package:sales_management/component/textfield/editable_text_form_field.dart';
import 'package:sales_management/page/create_order/component/modal_payment.dart';
import 'package:sales_management/page/order_list/bussiness/order_bussiness.dart';
import 'package:sales_management/page/product_selector/component/provider_discount.dart';
import 'package:sales_management/page/product_selector/component/provider_product.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/snack_bar.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/utils.dart';

class TotalPrice extends StatefulWidget {
  final VoidCallback onUpdate;
  final PackageDataResponse data;
  final bool isTempOrder;
  const TotalPrice({
    super.key,
    required this.data,
    required this.onUpdate,
    required this.isTempOrder,
  });

  @override
  State<TotalPrice> createState() => _TotalPriceState();
}

class _TotalPriceState extends State<TotalPrice> {
  bool isDiscountPercent = false;
  late final PackageDataResponse data;
  final TextEditingController discountTxtController = TextEditingController();
  final FocusNode discountFocus = FocusNode();
  final TextEditingController shipTxtController = TextEditingController();
  final FocusNode shipFocus = FocusNode();
  late bool isEditting = !data.isDone;

  late bool isAdditionalFeeDiscountPercent = widget.data.isAdditionalFeePercent;
  final TextEditingController additionalFeeTxtController =
      TextEditingController();
  final FocusNode additionalFeeFocus = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    discountTxtController.dispose();
    discountFocus.dispose();
    shipTxtController.dispose();
    shipFocus.dispose();
    additionalFeeTxtController.dispose();
    additionalFeeFocus.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.data;

    setDiscount();

    additionalFeeTxtController.text =
        MoneyFormater.format(widget.data.getAdditionalFeeValue);

    shipTxtController.text = MoneyFormater.format(data.shipPrice);

    additionalFeeFocus.addListener(() {
      if (additionalFeeFocus.hasFocus) {
        additionalFeeTxtController.selection = TextSelection(
            baseOffset: 0,
            extentOffset: additionalFeeTxtController.text.length);
      }
    });

    discountFocus.addListener(() {
      if (discountFocus.hasFocus) {
        discountTxtController.selection = TextSelection(
            baseOffset: 0, extentOffset: discountTxtController.text.length);
      }
    });

    shipFocus.addListener(() {
      if (shipFocus.hasFocus) {
        shipTxtController.selection = TextSelection(
            baseOffset: 0, extentOffset: shipTxtController.text.length);
      }
    });
  }

  void setDiscount() {
    if (data.discountPercent != 0 || data.discountAmount != 0) {
      isDiscountPercent = data.discountPercent > 0;
    }
    discountTxtController.text = isDiscountPercent
        ? data.discountPercent.toString()
        : MoneyFormater.format(data.discountAmount);
  }

  @override
  Widget build(BuildContext context) {
    PackageDataResponse data = context.watch<ProductProvider>().getPackage!;
    double discount = context.watch<DiscountProvider>().getDiscount!;
    if (discount != 0) {
      setDiscount();
      context.read<DiscountProvider>().clean();
    }
    String totalPrice = data.priceFormat;
    double finalPrice = data.finalPrice;
    double payment = data.payment;
    String finalPriceFormat = MoneyFormater.format(finalPrice);
    String profitExpectFormat = MoneyFormater.format(data.profitExpect);
    String costFormat = MoneyFormater.format(data.cost);
    String numItems = data.totalNumIems.toString();
    return DefaultPaddingContainer(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tổng ${numItems} sản phẩm',
              style:
                  isEditting ? headStyleSemiLargeLigh500 : headStyleXLargeLigh,
            ),
            Text(
              totalPrice,
              style: isEditting ? headStyleXLarge : headStyleXXLarge,
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Chiết khấu',
                  style: isEditting
                      ? headStyleSemiLargeLigh500
                      : headStyleXLargeLigh,
                ),
                SizedBox(
                  width: 18,
                ),
                SwitchBtn(
                  isEnable: isEditting,
                  firstTxt: 'VND',
                  secondTxt: '%',
                  enableIndex: isDiscountPercent ? 1 : 0,
                  onChanged: (index) {
                    if (index == 0) {
                      isDiscountPercent = false;
                      data.discountPercent = 0;
                      data.discountAmount = 0;
                    } else {
                      isDiscountPercent = true;
                      data.discountAmount = 0;
                      data.discountPercent = 0;
                    }
                    discountTxtController.text = '0';
                    context.read<ProductProvider>().justRefresh();
                    setState(() {});
                  },
                ),
              ],
            ),
            if (isEditting)
              Expanded(
                child: EditAbleTextFormField(
                  textAlign: TextAlign.right,
                  controller: discountTxtController,
                  focusNode: discountFocus,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    if (isDiscountPercent) ...[
                      LengthLimitingTextInputFormatter(2),
                      FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                    ] else
                      CurrencyInputFormatter(),
                  ],
                  maxLines: 1,
                  style: headStyleXLargeHigh,
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
                      data.discountPercent = double.tryParse(value) ?? 0;
                    } else {
                      data.discountAmount = tryParseMoney(value);
                    }
                    context.read<ProductProvider>().justRefresh();
                    setState(() {});
                  },
                ),
              )
            else
              Text(
                isDiscountPercent
                    ? '${MoneyFormater.format(data.discountPercent)}%'
                    : MoneyFormater.format(data.discountAmount),
                style: headStyleXXLarge,
              ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Phí vận chuyển',
              style:
                  isEditting ? headStyleSemiLargeLigh500 : headStyleXLargeLigh,
            ),
            if (isEditting)
              Expanded(
                child: EditAbleTextFormField(
                  textAlign: TextAlign.right,
                  controller: shipTxtController,
                  focusNode: shipFocus,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyInputFormatter(),
                  ],
                  maxLines: 1,
                  style: headStyleXLargeHigh,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    border: InputBorder.none,
                  ),
                  onTapOutside: (event) {
                    shipFocus.unfocus();
                  },
                  onChanged: (value) {
                    data.shipPrice = tryParseMoney(value);
                    context.read<ProductProvider>().justRefresh();
                    setState(() {});
                  },
                ),
              )
            else
              Text(
                MoneyFormater.format(data.shipPrice),
                style: headStyleXXLarge,
              ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Phụ phí',
                  style: isEditting
                      ? headStyleSemiLargeLigh500
                      : headStyleXLargeLigh,
                ),
                const SizedBox(
                  width: 18,
                ),
                SwitchBtn(
                  isEnable: isEditting,
                  firstTxt: 'VND',
                  secondTxt: '%',
                  enableIndex: isAdditionalFeeDiscountPercent ? 1 : 0,
                  onChanged: (index) {
                    if (index == 0) {
                      isAdditionalFeeDiscountPercent = false;
                    } else {
                      isAdditionalFeeDiscountPercent = true;
                    }
                    data.setAdditionalFee(0, isAdditionalFeeDiscountPercent);
                    additionalFeeTxtController.text = '0';
                    context.read<ProductProvider>().justRefresh();
                    setState(() {});
                  },
                ),
              ],
            ),
            if (isEditting)
              Expanded(
                child: EditAbleTextFormField(
                  textAlign: TextAlign.right,
                  controller: additionalFeeTxtController,
                  focusNode: additionalFeeFocus,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    if (isAdditionalFeeDiscountPercent) ...[
                      LengthLimitingTextInputFormatter(2),
                      FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                    ] else
                      CurrencyInputFormatter(),
                  ],
                  maxLines: 1,
                  style: headStyleXLargeHigh,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    border: InputBorder.none,
                  ),
                  onTapOutside: (event) {
                    additionalFeeFocus.unfocus();
                  },
                  onChanged: (value) {
                    if (isAdditionalFeeDiscountPercent) {
                      data.setAdditionalFee(double.tryParse(value) ?? 0,
                          isAdditionalFeeDiscountPercent);
                    } else {
                      data.setAdditionalFee(
                          tryParseMoney(value), isAdditionalFeeDiscountPercent);
                    }
                    context.read<ProductProvider>().justRefresh();
                    setState(() {});
                  },
                ),
              )
            else
              Text(
                isAdditionalFeeDiscountPercent
                    ? '${MoneyFormater.format(data.getAdditionalFeeValue)}%'
                    : MoneyFormater.format(data.getAdditionalFeeValue),
                style: headStyleXXLarge,
              ),
          ],
        ),
        SizedBox(
          height: 6,
        ),
        Divider(
          color: Black,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Giá vốn của đơn này',
              style: headStyleXLargeLigh,
            ),
            Text(
              costFormat,
              style: headStyleXLarge,
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Lợi nhuận dự kiến',
              style: headStyleXLargeLigh,
            ),
            Text(
              profitExpectFormat,
              style: headStyleXLargeHigh,
            ),
          ],
        ),
        SizedBox(
          height: 18,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tổng cộng',
              style: totalMoneyHeaderStylexXLarge,
            ),
            Text(
              finalPriceFormat,
              style: totalMoneyStylexXLarge,
            ),
          ],
        ),
        if (finalPrice - payment > 0 && !data.isLocal) ...[
          SizedBox(
            height: 12,
          ),
          RoundBtn(
            isSelected: true,
            icon: LoadSvg(assetPath: 'svg/wallet.svg', width: 20, height: 20),
            txt: 'Thanh toán trước',
            onPressed: () {
              showDefaultModal(
                context: context,
                content: ModalPayment(
                  finalPrice: finalPrice - payment,
                  onDone: (value) {
                    LoadingOverlayAlt.of(context).show();
                    prePayOrder(data, value, widget.isTempOrder).then((value) {
                      LoadingOverlayAlt.of(context).hide();
                      context.read<ProductProvider>().justRefresh();
                      widget.onUpdate();
                      if (value.isLocal) {
                        Navigator.pop(context);
                      }
                    }).catchError(
                      (error, stackTrace) {
                        LoadingOverlayAlt.of(context).hide();
                        context.read<ProductProvider>().justRefresh();
                        widget.onUpdate();
                        showAlert(context, error.toString());
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
      ],
    ));
  }
}
