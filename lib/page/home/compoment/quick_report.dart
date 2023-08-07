import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants.dart';
import '../model/report.dart';

class QuickReport extends StatelessWidget {
  const QuickReport({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 300),
      child: SizedBox(
        height: 140,
        width: screenWidth,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              bottom: 0,
              child: Transform.translate(
                offset: Offset(0, screenWidth * 0.28 - 145),
                child: ClipOval(
                  child: Container(
                    height: screenWidth,
                    width: screenWidth * 1.5,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 72, 188, 255),
                            Color(0xFF184863),
                          ]),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              child: Transform.translate(
                offset: Offset(0, 1),
                child: Container(
                  width: screenWidth,
                  height: 40,
                  color: White,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 120,
                width: screenWidth - 30,
                margin: const EdgeInsets.all(5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.5, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: defaultBorder,
                  color: White,
                  boxShadow: const [
                    BoxShadow(
                      color: ShowdownColor25,
                      blurRadius: 4,
                      offset: Offset(0, 1),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Text(
                              'Hôm nay',
                              style: subInfoStyMedium400,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'svg/small_chart.svg',
                              semanticsLabel: 'Quản lý',
                            ),
                            const Text(
                              'Báo cáo lãi lỗ',
                              style: subInfoStyMediumHight400,
                            ),
                            SvgPicture.asset(
                              'svg/navigate_next.svg',
                              semanticsLabel: 'Báo cáo',
                            ),
                          ],
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          report rp = exampleReport[index];

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(
                                    rp.iconHeader,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    rp.title,
                                    style: subInfoStyMedium400,
                                  ),
                                ],
                              ),
                              Text(
                                rp.content,
                                style: subInfoStyMedium600,
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                              child: VerticalDivider(
                                width: 50,
                              ),
                            ),
                          ],
                        ),
                        itemCount: exampleReport.length,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
