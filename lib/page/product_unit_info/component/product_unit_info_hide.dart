import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/component/btn/switch_circle_btn.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/utils/constants.dart';

class ProductUnitInfoHide extends StatefulWidget {
  final BeerSubmitData product;
  const ProductUnitInfoHide({
    super.key,
    required this.product,
  });

  @override
  State<ProductUnitInfoHide> createState() => _ProductUnitInfoHideState();
}

class _ProductUnitInfoHideState extends State<ProductUnitInfoHide> {
  @override
  Widget build(BuildContext context) {
    return DefaultPaddingContainer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quảng lý hiển thị',
          style: headStyleXLarge,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Hiển thị phân loại trong cửa hàng',
                style: customerNameBig400,
              ),
              SwitchCircleBtn(
                initStatus: !(widget.product.firstOrNull?.isHide ?? true),
                onChange: (bool) {
                  final item = widget.product.firstOrNull;
                  if (item == null) {
                    return;
                  }
                  item.changeTohide(!bool);
                  setState(() {});
                },
              )
            ],
          ),
        ),
      ],
    ));
  }
}
