import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/component/btn/switch_big_btn.dart';
import 'package:sales_management/component/btn/switch_circle_btn.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/utils.dart';

class StoreManagement extends StatefulWidget {
  final BeerSubmitData product;
  final bool isForProductUnit;
  const StoreManagement({
    super.key,
    required this.product,
    this.isForProductUnit = false,
  });

  @override
  State<StoreManagement> createState() => _StoreManagementState();
}

class _StoreManagementState extends State<StoreManagement> {
  @override
  Widget build(BuildContext context) {
    bool isHaveMultiCategory = widget.product.isHaveMultiCategory;
    return DefaultPaddingContainer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quảng lý tồn kho',
          style: headStyleXLarge,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tình trạng sản phẩm',
                style: customerNameBig400,
              ),
              SwitchBigBtn(
                secondTxt: 'Còn hàng',
                firstTxt: 'Hết hàng',
                selectedIndex: (widget.isForProductUnit
                        ? widget.product.firstOrNull?.isAvariable ?? false
                        : widget.product.isAvariable)
                    ? 1
                    : 0,
                onChanged: (status) {
                  if (widget.isForProductUnit) {
                    widget.product
                        .changeUnitStatus(widget.product.firstOrNull, status);
                    return;
                  }
                  widget.product.changeStatus(status);
                },
              )
            ],
          ),
        ),
        if (!isHaveMultiCategory) ...[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Theo dõi số lượng tồn kho',
                  style: customerNameBig400,
                ),
                SwitchCircleBtn(
                  initStatus: widget.product.isEnableWarehouse,
                  onChange: (bool) {
                    widget.product.switcEnableWareHouse(bool);
                    setState(() {});
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Expanded(
                child: InputFiledWithHeader(
                  header: 'Mã SKU',
                  hint: 'Nhập/Quét',
                  initValue: widget.product.getSku,
                  isImportance: false,
                  onChanged: (value) {
                    widget.product.setSku = value;
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: InputFiledWithHeader(
                  isNumberOnly: true,
                  header: 'Mã vạch sản xuất',
                  hint: 'Nhập/Quét',
                  initValue: widget.product.getUpc,
                  isImportance: false,
                  onChanged: (value) {
                    widget.product.setUPC = value;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Stack(children: [
            InputFiledWithHeader(
              isNumberOnly: true,
              isMoneyFormat: true,
              header: 'Tồn kho',
              hint: 'Nhập/Quét',
              initValue: widget.product.getInventory.toString(),
              isImportance: false,
              onChanged: (value) {
                widget.product.setInventory = tryParseNumber(value);
              },
            ),
            if (!widget.product.isEnableWarehouse)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: White70,
                    borderRadius: defaultBorderRadius,
                  ),
                ),
              )
          ]),
        ],
      ],
    ));
  }
}
