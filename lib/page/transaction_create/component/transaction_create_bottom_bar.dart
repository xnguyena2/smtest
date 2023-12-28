import 'package:flutter/material.dart';
import 'package:sales_management/component/btn/approve_btn.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class TransactionCreateBottomBar extends StatelessWidget {
  final VoidCallback createAct;
  final VoidCallback takePhotoAct;
  const TransactionCreateBottomBar({
    super.key,
    required this.createAct,
    required this.takePhotoAct,
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
          GestureDetector(
            onTap: takePhotoAct,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: defaultBorderRadius, border: mainHighBorder),
              child: LoadSvg(assetPath: 'svg/picture_o.svg'),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: ApproveBtn(
              isActiveOk: true,
              txt: 'Tạo',
              padding: EdgeInsets.symmetric(vertical: 12),
              onPressed: createAct,
            ),
          ),
        ],
      ),
    );
  }
}
