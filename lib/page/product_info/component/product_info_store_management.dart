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
  const StoreManagement({
    super.key,
    required this.product,
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
                selectedIndex: this.widget.product.isAvariable ? 1 : 0,
                onChanged: (status) {
                  widget.product.changeStatus(status);
                },
              )
            ],
          ),
        ),
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
        if (!isHaveMultiCategory) ...[
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
          if (widget.product.isEnableWarehouse) ...[
            const SizedBox(
              height: 10,
            ),
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
          ],
        ],
      ],
    ));
  }
}
