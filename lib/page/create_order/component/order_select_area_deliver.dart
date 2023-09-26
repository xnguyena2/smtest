import 'package:flutter/material.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/check_radio_item.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class SelectAreaAndDeliver extends StatefulWidget {
  final PackageDataResponse data;
  const SelectAreaAndDeliver({
    super.key,
    required this.data,
  });

  @override
  State<SelectAreaAndDeliver> createState() => _SelectAreaAndDeliverState();
}

class _SelectAreaAndDeliverState extends State<SelectAreaAndDeliver> {
  String? currentPackgeType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPackgeType = widget.data.packageType;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultPaddingContainer(
      child: Column(
        children: [
          SizedBox(
            height: 7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CheckRadioItem<String>(
                txt: 'Ăn tại bàn',
                groupValue: currentPackgeType,
                value: 'eat_here',
                onChanged: (value) {
                  print(value);
                  setState(() {
                    currentPackgeType = value;
                  });
                },
              ),
              CheckRadioItem<String>(
                txt: 'Mang về',
                groupValue: currentPackgeType,
                value: 'bringtohome',
                onChanged: (value) {
                  print(value);
                  setState(() {
                    currentPackgeType = value;
                  });
                },
              ),
              CheckRadioItem<String>(
                txt: 'Giao hàng',
                groupValue: currentPackgeType,
                value: 'deliver',
                onChanged: (value) {
                  print(value);
                  setState(() {
                    currentPackgeType = value;
                  });
                },
              )
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
                color: Color(0x1980A91A),
                borderRadius: defaultSquareBorderRadius),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Chọn bàn:',
                  style: subStyleMediumNormalLight,
                ),
                Row(
                  children: [
                    Text(
                      'Khu vực 1 - Bàn 1',
                      style: headStyleMedium,
                    ),
                    LoadSvg(
                      assetPath: 'svg/navigate_next.svg',
                      colorFilter: const ColorFilter.mode(
                        Black,
                        BlendMode.srcIn,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
