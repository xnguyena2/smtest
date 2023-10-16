import 'package:flutter/material.dart';
import 'package:sales_management/component/btn/approve_btn.dart';
import 'package:sales_management/component/btn/cancel_btn.dart';
import 'package:sales_management/component/btn/delete_btn.dart';
import 'package:sales_management/utils/constants.dart';

class BottomBar extends StatelessWidget {
  final VoidCallback done;
  final VoidCallback cancel;
  final String? cancelBtnTxt;
  final String? okBtnTxt;
  final bool isActiveOk;
  final bool enableDelete;
  const BottomBar({
    super.key,
    required this.done,
    required this.cancel,
    this.cancelBtnTxt,
    this.okBtnTxt,
    this.isActiveOk = true,
    this.enableDelete = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: White,
        boxShadow: [wholeShadow],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: enableDelete
                ? DeleteBtn(
                    txt: cancelBtnTxt ?? 'Xóa',
                    padding: EdgeInsets.symmetric(vertical: 18),
                    onPressed: cancel,
                  )
                : CancelBtn(
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
