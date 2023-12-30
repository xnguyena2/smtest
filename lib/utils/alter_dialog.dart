import 'package:flutter/material.dart';
import 'package:sales_management/component/btn/approve_btn.dart';
import 'package:sales_management/component/btn/cancel_btn.dart';
import 'package:sales_management/utils/constants.dart';

showDefaultDialog(BuildContext context, String title, String messanger,
        {required VoidCallback onOk, required VoidCallback onCancel}) =>
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: White,
        shape: RoundedRectangleBorder(
          borderRadius: defaultBorderRadius,
        ),
        title: Text(
          title,
          style: totalMoneyHeaderStylexXLarge,
        ),
        content: Text(
          messanger,
          style: headStyleSemiLarge,
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CancelBtn(
                txt: 'Hủy',
                padding: EdgeInsets.all(16),
                onPressed: () {
                  Navigator.pop(context);
                  onCancel();
                },
              ),
              SizedBox(
                width: 15,
              ),
              ApproveBtn(
                isActiveOk: true,
                txt: 'OK',
                padding: EdgeInsets.all(16),
                onPressed: () {
                  Navigator.pop(context);
                  onOk();
                },
              ),
            ],
          ),
        ],
      ),
    );
