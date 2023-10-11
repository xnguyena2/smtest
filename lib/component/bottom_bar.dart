import 'package:flutter/material.dart';
import 'package:sales_management/component/btn/approve_btn.dart';
import 'package:sales_management/component/btn/cancel_btn.dart';
import 'package:sales_management/utils/constants.dart';

class BottomBar extends StatelessWidget {
  final VoidCallback done;
  final VoidCallback cancel;
  final String? cancelBtnTxt;
  final String? okBtnTxt;
  final bool isActiveOk;
  const BottomBar({
    super.key,
    required this.done,
    required this.cancel,
    this.cancelBtnTxt,
    this.okBtnTxt,
    this.isActiveOk = false,
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
              txt: cancelBtnTxt ?? 'Hủy',
              padding: EdgeInsets.symmetric(vertical: 18),
              onPressed: cancel,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: ApproveBtn(
              isActiveOk: isActiveOk,
              txt: okBtnTxt ?? 'Đã giao',
              padding: EdgeInsets.symmetric(vertical: 18),
              onPressed: done,
            ),
          ),
        ],
      ),
    );
  }
}
