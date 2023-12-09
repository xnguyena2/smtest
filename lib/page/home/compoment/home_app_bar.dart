import 'package:flutter/material.dart';
import 'package:sales_management/component/bar/bar_medium.dart';
import 'package:sales_management/utils/constants.dart';

class HomeAppBar extends BarMedium {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Container(
      height: 60 + topPadding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF227CAE),
            Color(0xFF1F6C98),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.black,
              foregroundImage: AssetImage(
                "assets/images/shop_logo_big.png",
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deviceID,
                  style: headStyleLargeWhite,
                ),
                Text(
                  'Thông tin cửa hàng >',
                  style: subInfoStyWhiteMedium,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
