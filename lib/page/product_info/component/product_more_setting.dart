import 'package:flutter/material.dart';
import 'package:sales_management/component/high_border_container.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class MoreSetting extends StatelessWidget {
  const MoreSetting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông tin thêm',
            style: headStyleXLarge,
          ),
          SizedBox(
            height: 67,
            child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 11),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return LoadSvg(
                      assetPath: 'svg/setting.svg',
                    );
                  }
                  return HighBorderContainer(
                    padding: EdgeInsets.symmetric(vertical: 11, horizontal: 18),
                    child: Text(
                      'Nguyên vật liệu',
                      style: headStyleSemiLargeHigh500,
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                      width: 10,
                    ),
                itemCount: 5),
          ),
        ],
      ),
    );
  }
}
