import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sales_management/page/home/compoment/header.dart';
import 'package:sales_management/page/report/report_page.dart';
import 'package:sales_management/utils/snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/constants.dart';
import '../../../utils/svg_loader.dart';

class Guide extends StatelessWidget {
  const Guide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> futures = [
      'Thêm website cho shop bán hàng online!',
      'Sửa lỗi máy in, sao không shop nào report lỗi này hết vậy?????',
      'Sửa một số lỗi khi thay đổi sản phẩm trong giỏ hàng,..'
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: TableHighColor15,
                    borderRadius: defaultBorderRadius,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      LoadSvg(assetPath: 'svg/web.svg'),
                      Column(
                        children: [
                          Text(
                            'Bạn cần một website???',
                            style: headStyleLargeHigh,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final Uri _url =
                                  Uri.parse('https://0935871569.sodientu.com/');

                              if (!await launchUrl(_url)) {
                                showAlert(context, 'Could not launch $_url');
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 12),
                              decoration: BoxDecoration(
                                  border: lightBorder,
                                  borderRadius: defaultBorderRadius),
                              child: Row(
                                children: [
                                  LoadSvg(assetPath: 'svg/web_link.svg'),
                                  Text(
                                    'https://0935871569.sodientu.com/',
                                    style: headStyleLargeMainHigh,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Đây là trang web của một shop trong hệ thống.\nHãy liên hệ với chúng tôi để có một trang như vậy!!',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.visible,
                            softWrap: true,
                            style: subInfoStyLarge400,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 18,
          ),
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
                    padding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: White,
                      borderRadius: defaultBorderRadius,
                      boxShadow: [lightShadow],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Bạn chưa biết tháng này lãi hay lỗ????',
                              style: headStyleSmallLarge,
                            ),
                            LoadSvg(assetPath: 'svg/close.svg'),
                          ],
                        ),
                        Divider(
                          color: Black15,
                        ),
                        Row(
                          children: [
                            Text(
                              'Xem báo cáo lãi/lỗ thật chi tiết nào!!!',
                              style: headStyleSmallLargeMainHigh,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            LoadSvg(assetPath: 'svg/small_chart.svg'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Có gì mới trong bản cập nhật?',
                    style: headStyleSmallLarge,
                  ),
                  LoadSvg(assetPath: 'svg/guide.svg'),
                ],
              ),
              LoadSvg(assetPath: 'svg/close.svg'),
            ],
          ),
          SizedBox(
            height: 2,
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
