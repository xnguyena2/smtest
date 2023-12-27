import 'package:flutter/material.dart';
import 'package:sales_management/component/bottom_bar.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/page/table/api/model/area_table.dart';
import 'package:sales_management/component/modal/modal_base.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';

class ModalTransactionDetail extends StatefulWidget {
  final bool isIncome;
  const ModalTransactionDetail({
    super.key,
    required this.isIncome,
  });

  @override
  State<ModalTransactionDetail> createState() => _ModalTransactionDetailState();
}

class _ModalTransactionDetailState extends State<ModalTransactionDetail> {
  late bool isIncome = widget.isIncome;
  @override
  Widget build(BuildContext context) {
    return ModalBase(
      headerTxt:
          widget.isIncome ? 'Chi Tiết khoảng thu' : 'Chi tiết khoảng chi',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: isIncome ? TableHighColor : Red,
                      child: LoadSvg(
                          width: 20,
                          height: 20,
                          assetPath:
                              isIncome ? 'svg/income.svg' : 'svg/outcome.svg'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Thứ hai'),
                        Text('10:14 - 22/12/2023'),
                      ],
                    )
                  ],
                ),
                Text('2.000.000'),
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          BottomBar(
            done: () {},
            cancel: () {
              Navigator.pop(context);
            },
            okBtnTxt: 'Tạo',
          ),
        ],
      ),
    );
  }
}
