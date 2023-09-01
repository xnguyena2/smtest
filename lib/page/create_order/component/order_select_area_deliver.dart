import 'package:flutter/material.dart';
import 'package:sales_management/component/check_radio_item.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class SelectAreaAndDeliver extends StatelessWidget {
  const SelectAreaAndDeliver({
    super.key,
  });

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
              CheckRadioItem(
                isCheck: false,
                txt: 'Ăn tại bàn',
              ),
              CheckRadioItem(
                isCheck: false,
                txt: 'Mang về',
              ),
              CheckRadioItem(
                isCheck: true,
                txt: 'Giao hàng',
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
