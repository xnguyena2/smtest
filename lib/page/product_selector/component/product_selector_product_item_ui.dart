import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';

class ProductSelectorItemUI extends StatefulWidget {
  final int unitNo;
  final String? imgUrl;
  final String name;
  final String rangePrice;
  final ReturnCallback<int> addItemToPackage;
  final ReturnCallback<int> removeItemToPackage;
  final ReturnCallbackAsync<bool> switchToAvariable;
  final VoidCallback showSelectUnitModal;
  final VoidCallbackArg<String> onTxtChanged;
  final ReturnCallback<int> onTapOutside;
  final bool isHaveMultiCategory;
  final bool isAvariable;
  final bool isNullUnit;
  final int inventoryNum;

  const ProductSelectorItemUI({
    super.key,
    required this.unitNo,
    required this.imgUrl,
    required this.name,
    required this.rangePrice,
    required this.addItemToPackage,
    required this.isHaveMultiCategory,
    required this.removeItemToPackage,
    required this.switchToAvariable,
    required this.onTxtChanged,
    required this.onTapOutside,
    required this.isAvariable,
    required this.isNullUnit,
    required this.showSelectUnitModal,
    required this.inventoryNum,
  });

  @override
  State<ProductSelectorItemUI> createState() => _ProductSelectorItemUIState();
}

class _ProductSelectorItemUIState extends State<ProductSelectorItemUI> {
  final TextEditingController txtController = TextEditingController();
  final FocusNode txtFocus = FocusNode();
  late int unitNo = widget.unitNo;
  late bool isAvariable = widget.isAvariable;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    txtController.text = unitNo.toString();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    txtController.dispose();
    txtFocus.dispose();
  }

  late final onAddItem = widget.isHaveMultiCategory
      ? widget.showSelectUnitModal
      : () {
          unitNo = widget.addItemToPackage();
          txtController.text = unitNo.toString();
          setState(() {});
        };

  late final onRemoveItem = widget.isHaveMultiCategory
      ? widget.showSelectUnitModal
      : () {
          unitNo = widget.removeItemToPackage();
          txtController.text = unitNo.toString();
          setState(() {});
        };

  void removeIfEmpty() {
    unitNo = widget.onTapOutside();
    txtController.text = unitNo.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onAddItem,
          child: Container(
            decoration: BoxDecoration(
              color: White,
              boxShadow: unitNo > 0 ? [highShadow] : null,
              borderRadius: defaultBorderRadius,
              border: unitNo > 0 ? tableHighBorder : defaultBorder,
              image: DecorationImage(
                image: (widget.imgUrl == null
                    ? const AssetImage(
                        'assets/images/shop_logo.png',
                      )
                    : NetworkImage(widget.imgUrl!)) as ImageProvider,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                unitNo > 0 || txtFocus.hasFocus
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 6),
                        margin:
                            const EdgeInsets.only(top: 10, left: 6, right: 6),
                        decoration: BoxDecoration(
                            color: White,
                            borderRadius: defaultSquareBorderRadius,
                            border: defaultBorder),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: onRemoveItem,
                              child: LoadSvg(assetPath: 'svg/minus.svg'),
                            ),
                            SizedBox(
                              width: 18,
                              child: TextFormField(
                                controller: txtController,
                                focusNode: txtFocus,
                                readOnly: widget.isHaveMultiCategory,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                onTapOutside: (event) {
                                  txtFocus.unfocus();
                                  removeIfEmpty();
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                maxLines: 1,
                                style: headStyleLarge,
                                onChanged: widget.onTxtChanged,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: onAddItem,
                              child: LoadSvg(
                                assetPath: 'svg/plus.svg',
                                color: MainHighColor,
                              ),
                            )
                          ],
                        ),
                      )
                    : const SizedBox(),
                Column(
                  children: [
                    if (widget.inventoryNum > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 8),
                        margin: EdgeInsets.only(bottom: 2),
                        decoration: BoxDecoration(
                            color: wareHouseBoxBackground,
                            border: whiteBorder,
                            borderRadius: defaultBorderRadius),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LoadSvg(assetPath: 'svg/warehouse_small.svg'),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              '${widget.inventoryNum}',
                              overflow: TextOverflow.ellipsis,
                              style: subInfoStyMediumWhite400,
                            ),
                          ],
                        ),
                      ),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 4.0,
                          sigmaY: 4.0,
                        ),
                        child: Container(
                          color: Color.fromRGBO(214, 214, 214, 0.40),
                          child: Column(
                            children: [
                              Text(
                                widget.name,
                                style: subInfoStyLarge400,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.rangePrice,
                                    style: subInfoStyLarge600,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (!isAvariable || widget.isNullUnit)
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                widget.switchToAvariable().then((value) {
                  isAvariable = value;
                  setState(() {});
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: White70,
                  borderRadius: defaultBorderRadius,
                ),
                child: const Center(
                  child: Text('Hết hàng'),
                ),
              ),
            ),
          ),
      ],
    );
  }
}