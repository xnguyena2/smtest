import 'package:flutter/material.dart';
import 'package:sales_management/component/btn/approve_btn.dart';
import 'package:sales_management/component/btn/cancel_btn.dart';
import 'package:sales_management/utils/constants.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      decoration: BoxDecoration(
        color: White,
        boxShadow: [wholeShadow],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CancelBtn(
              txt: 'Hủy',
              padding: EdgeInsets.symmetric(vertical: 18),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: ApproveBtn(
              txt: 'Đã giao',
              padding: EdgeInsets.symmetric(vertical: 18),
            ),
          ),
        ],
      ),
    );
  }
}
