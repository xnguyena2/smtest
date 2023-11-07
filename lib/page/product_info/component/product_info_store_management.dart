import 'package:flutter/material.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/component/btn/switch_big_btn.dart';
import 'package:sales_management/component/btn/switch_circle_btn.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/utils/constants.dart';

class StoreManagement extends StatelessWidget {
  final BeerSubmitData product;
  const StoreManagement({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultPaddingContainer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quảng lý tồn kho',
          style: headStyleXLarge,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tình trạng sản phẩm',
                style: customerNameBig400,
              ),
              SwitchBigBtn(
                firstTxt: 'Còn hàng',
                secondTxt: 'Hết hàng',
                isDisable: true,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Theo dõi số lượng tồn kho',
                style: customerNameBig400,
              ),
              SwitchCircleBtn(
                isDisable: true,
              )
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        InputFiledWithHeader(
          header: 'Mã SKU',
          hint: 'Nhập/Quét',
          initValue: product.sku,
          isImportance: false,
          onChanged: (value) {
            product.sku = value;
          },
        ),
      ],
    ));
  }
}
