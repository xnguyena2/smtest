import 'package:flutter/material.dart';
import 'package:sales_management/component/btn/approve_btn.dart';
import 'package:sales_management/component/btn/cancel_btn.dart';
import 'package:sales_management/component/btn/delete_btn.dart';
import 'package:sales_management/component/btn/round_btn.dart';
import 'package:sales_management/utils/constants.dart';

class BottomBar extends StatelessWidget {
  final VoidCallback done;
  final VoidCallback cancel;
  final String? cancelBtnTxt;
  final String? okBtnTxt;
  final bool isActiveOk;
  final bool enableDelete;
  final bool hideDeleteBtn;
  final Widget? midleWidget;
  final Widget? headOkbtn;
  final Widget? headCancelbtn;
  final bool isCancelMode;
  final bool isShowOkBtn;
  final Color okBtnColor;
  const BottomBar({
    super.key,
    required this.done,
    required this.cancel,
    this.cancelBtnTxt,
    this.okBtnTxt,
    this.isActiveOk = true,
    this.enableDelete = false,
    this.hideDeleteBtn = false,
    this.midleWidget,
    this.headOkbtn,
    this.headCancelbtn,
    this.isCancelMode = true,
    this.isShowOkBtn = true,
    this.okBtnColor = TableHighColor,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      height: 60 + bottomPadding,
      padding: EdgeInsets.only(right: 15, left: 15, bottom: bottomPadding),
      decoration: BoxDecoration(
        color: White,
        boxShadow: [wholeShadow],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (hideDeleteBtn == false) ...[
            Expanded(
              child: isCancelMode
                  ? (enableDelete
                      ? DeleteBtn(
                          txt: cancelBtnTxt ?? 'Xóa',
                          padding: EdgeInsets.symmetric(vertical: 12),
                          onPressed: cancel,
                          headIcon: headCancelbtn,
                        )
                      : CancelBtn(
                          txt: cancelBtnTxt ?? 'Hủy',
                          padding: EdgeInsets.symmetric(vertical: 12),
                          onPressed: cancel,
                          headIcon: headCancelbtn,
                        ))
                  : RoundBtn(
                      txt: cancelBtnTxt ?? 'Xóa',
                      icon: headCancelbtn ?? SizedBox(),
                      onPressed: cancel,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      isSelected: true,
                    ),
            ),
            SizedBox(
              width: 10,
            )
          ],
          if (midleWidget != null) ...[
            Expanded(child: midleWidget!),
            SizedBox(
              width: 10,
            ),
          ],
          if (isShowOkBtn)
            Expanded(
              child: ApproveBtn(
                isActiveOk: isActiveOk,
                txt: okBtnTxt ?? 'Đã giao',
                padding: EdgeInsets.symmetric(vertical: 12),
                onPressed: done,
                headIcon: headOkbtn,
                backgroundColor: okBtnColor,
              ),
            ),
        ],
      ),
    );
  }
}
