import 'package:flutter/material.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/bar/bar_medium.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class BuyerDetailBar extends BarMedium {
  const BuyerDetailBar({
    super.key,
    required this.buyer,
  });

  final BuyerData buyer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
        color: White,
        boxShadow: [defaultShadow],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 47,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 0, top: 0, right: 15, bottom: 0),
                      decoration: const BoxDecoration(color: White),
                      child: LoadSvg(assetPath: 'svg/back.svg'),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        buyer.reciverFullname ?? 'Khách lẻ',
                        style: headStyleXLarge,
                      ),
                      Text(
                        buyer.phoneNumber ?? 'unknow',
                        style: headStyleSemiLargeLigh500,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
