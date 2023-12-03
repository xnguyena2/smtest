import 'package:flutter/material.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class OrderNote extends StatelessWidget {
  final PackageDataResponse data;
  const OrderNote({
    super.key,
    required this.data,
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
                enabled: !data.isDone,
                textAlign: TextAlign.left,
                initialValue: data.note,
                maxLines: 1,
                style: headStyleSemiLarge,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  border: InputBorder.none,
                  hintText: 'Ghi chú',
                ),
                onChanged: (value) {
                  data.note = value;
                },
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
