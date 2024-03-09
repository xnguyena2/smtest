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
    final List<String> futures = [
      'Thêm phân loại(ví dụ kích thước, màu sắc,..) cho sản từng sản phẩm. Đẽ dàng lựa chọn khi bán hàng!',
      'Thêm số lượng hàng hóa trong kho và tự động kiểm kê khi bán hàng!',
      'Sửa một số lỗi khi chọn bàn, tạo đơn hàng,..'
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          header(
            title: 'Có gì mới trong bản cập nhật?',
            titleImg: 'svg/guide.svg',
            endChild: LoadSvg(assetPath: 'svg/close.svg'),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(bottom: 30),
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
                return guideItem(index + 1, futures[index]);
              },
              itemCount: futures.length,
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
              overflow: TextOverflow.visible,
              softWrap: true,
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
