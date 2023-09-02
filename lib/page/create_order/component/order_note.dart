import 'package:flutter/material.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class OrderNote extends StatelessWidget {
  const OrderNote({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultPaddingContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: borderColor),
                ),
              ),
              child: TextFormField(
                textAlign: TextAlign.left,
                initialValue: 'ghi chu',
                maxLines: 1,
                style: headStyleSemiLarge,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: defaultBorderRadius, border: mainHighBorder),
            child: LoadSvg(assetPath: 'svg/picture_o.svg'),
          )
        ],
      ),
    );
  }
}
