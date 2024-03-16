import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sales_management/page/home/compoment/header.dart';
import 'package:sales_management/page/report/report_page.dart';

import '../../../utils/constants.dart';
import '../../../utils/svg_loader.dart';

class Guide extends StatelessWidget {
  const Guide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> futures = [
      'Thêm báo cáo LÃI LỖ giúp bạn biết được lợi nhuận thực tế báo nhiêu!!!!. Báo cáo lãi lỗ cực kỳ chi tiết!',
      'Thêm khoảng phụ phí cho đơn ví dụ VAT,...',
      'Sửa một số lỗi khi thay đổi sản phẩm trong giỏ hàng,..'
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportPage(
                          initialIndex: 1,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 38, 176, 116),
                      borderRadius: bigRoundBorderRadius,
                      boxShadow: [defaultShadow],
                    ),
                    child: const Center(
                      child: Text(
                        'Bạn chưa biết tháng này lãi hay lỗ????',
                        style: headStyleSemiLargeWhite500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
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
