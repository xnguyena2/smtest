import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/component/btn/switch_circle_btn.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/utils/constants.dart';

class WebSetting extends StatefulWidget {
  final BeerSubmitData product;
  const WebSetting({
    super.key,
    required this.product,
  });

  @override
  State<WebSetting> createState() => _WebSettingState();
}

class _WebSettingState extends State<WebSetting> {
  @override
  Widget build(BuildContext context) {
    return DefaultPaddingContainer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cài đặt trên web',
          style: headStyleXLarge,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Hiển thị trên web',
                style: customerNameBig400,
              ),
              SwitchCircleBtn(
                initStatus: widget.product.visible_web == true,
                onChange: (bool) {
                  widget.product.visible_web = bool;
                  setState(() {});
                },
              )
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            Expanded(
              child: InputFiledWithHeader(
                header: 'Mô tả',
                hint: 'Ví dụ: Mì hảo hảo chua chua cay cay!',
                initValue: widget.product.detail,
                isImportance: false,
                onChanged: (value) {
                  widget.product.detail = value;
                },
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
