import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sales_management/page/home/compoment/header.dart';

import '../../../utils/constants.dart';
import '../../../utils/svg_loader.dart';

class Guide extends StatelessWidget {
  const Guide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          header(
            title: 'Hướng dẫn sử dụng',
            titleImg: 'svg/guide.svg',
            endChild: LoadSvg(assetPath: 'svg/close.svg'),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 250,
            decoration: BoxDecoration(
              borderRadius: defaultBorderRadius,
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/background_guide.png"),
              ),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return guideItem(index + 1, 'Thêm sản phẩm mới.');
              },
              itemCount: 3,
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container guideItem(int index, String header) {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(10),
      decoration:
          BoxDecoration(borderRadius: defaultBorderRadius, color: White),
      child: Row(
        children: [
          CircleAvatar(
            radius: 10,
            child: Text(
              index.toString(),
              style: subInfoStyLarge600,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              header,
              style: subInfoStyLarge400,
            ),
          ),
          LoadSvg(
            assetPath: 'svg/navigate_next.svg',
            width: 20,
            height: 20,
            color: Black,
          ),
        ],
      ),
    );
  }
}
