import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/btn/switch_btn.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/component/modal/simple_modal.dart';
import 'package:sales_management/page/create_order/component/modal_payment.dart';
import 'package:sales_management/page/create_order/component/order_list_product.dart';
import 'package:sales_management/page/create_order/state/state_aretable.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class TotalPrice extends StatefulWidget {
  final PackageDataResponse data;
  final bool isEditting;
  final VoidCallback onRefreshData;
  const TotalPrice({
    super.key,
    required this.isEditting,
    required this.data,
    required this.onRefreshData,
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    discountTxtController.dispose();
    discountFocus.dispose();
    shipTxtController.dispose();
    shipFocus.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.data;
    if (data.discountPercent != 0 || data.discountAmount != 0) {
      isDiscountPercent = data.discountPercent >= 0;
    }
    discountTxtController.text = isDiscountPercent
        ? data.discountPercent.toString()
        : data.discountAmount.toString();

    shipTxtController.text = data.shipPrice.toString();
  }

  @override
  Widget build(BuildContext context) {
    String totalPrice = StateAreaTable.of(context).totalPrice;
    double finalPrice = StateAreaTable.of(context).finalPrice;
    String finalPriceFormat = MoneyFormater.format(finalPrice);
    String numItems = StateAreaTable.of(context).numItems.toString();
    return DefaultPaddingContainer(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tổng ${numItems} sản phẩm',
              style: widget.isEditting
                  ? headStyleSemiLargeLigh500
                  : headStyleXLargeLigh,
            ),
            Text(
              totalPrice,
              style: widget.isEditting ? headStyleXLarge : headStyleXXLarge,
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
                  style: widget.isEditting
                      ? headStyleSemiLargeLigh500
                      : headStyleXLargeLigh,
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
                      data.discountPercent = 0;
                      data.discountAmount = 0;
                    } else {
                      isDiscountPercent = true;
                      data.discountAmount = 0;
                      data.discountPercent = 0;
                    }
                    discountTxtController.text = '0';
                    widget.onRefreshData();
                  },
                ),
              ],
            ),
            if (widget.isEditting)
              Row(
                children: [
                  SizedBox(
                    width: 60,
                    child: TextFormField(
                      textAlign: TextAlign.right,
                      controller: discountTxtController,
                      focusNode: discountFocus,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      maxLines: 1,
                      style: headStyleXLargeHigh,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        if (isDiscountPercent) {
                          data.discountPercent = double.tryParse(value) ?? 0;
                        } else {
                          data.discountAmount = double.tryParse(value) ?? 0;
                        }
                        widget.onRefreshData();
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () => discountFocus.requestFocus(),
                    child: LoadSvg(assetPath: 'svg/edit_pencil_line_01.svg'),
                  )
                ],
              )
            else
              Text(
                isDiscountPercent
                    ? data.discountPercent.toString()
                    : data.discountAmount.toString(),
                style: headStyleXXLarge,
              ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Phí vận chuyển',
              style: widget.isEditting
                  ? headStyleSemiLargeLigh500
                  : headStyleXLargeLigh,
            ),
            if (widget.isEditting)
              Row(
                children: [
                  SizedBox(
                    width: 60,
                    child: TextFormField(
                      textAlign: TextAlign.right,
                      controller: shipTxtController,
                      focusNode: shipFocus,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      maxLines: 1,
                      style: headStyleXLargeHigh,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        data.shipPrice = double.tryParse(value) ?? 0;
                        widget.onRefreshData();
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () => shipFocus.requestFocus(),
                    child: LoadSvg(assetPath: 'svg/edit_pencil_line_01.svg'),
                  )
                ],
              )
            else
              Text(
                data.shipPrice.toString(),
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
              'Tổng cộng',
              style: totalMoneyHeaderStylexXLarge,
            ),
            Text(
              finalPriceFormat,
              style: totalMoneyStylexXLarge,
            ),
          ],
        ),
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
                finalPrice: finalPrice,
                onDone: (value) {},
              ),
            );
          },
        )
      ],
    ));
  }
}
