import 'package:flutter/material.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/page/transaction_create/component/transaction_create_bar.dart';
import 'package:sales_management/page/transaction_create/component/transaction_create_bottom_bar.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class TransactionCreate extends StatelessWidget {
  final bool isIncome;
  const TransactionCreate({super.key, required this.isIncome});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: TransactionCreateBar(
          isIncome: isIncome,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      LoadSvg(assetPath: 'svg/calendar_date.svg'),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '24/12/2023',
                        style: headStyleXLargeHighTable,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      LoadSvg(assetPath: 'svg/down_chevron.svg')
                    ],
                  ),
                ),
              ),
              Container(
                color: White,
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                child: Column(
                  children: [
                    InputFiledWithHeader(
                        header: 'Số tiền', hint: 'ví dụ: 1,000,000'),
                    SizedBox(
                      height: 16,
                    ),
                    InputFiledWithHeader(
                        header: 'Mục đích',
                        hint: 'ví dụ: nhập hàng hóa,...'),
                    SizedBox(
                      height: 16,
                    ),
                    InputFiledWithHeader(
                        header: 'Nguồn tiền', hint: 'ví dụ: tiền mặt'),
                    SizedBox(
                      height: 16,
                    ),
                    InputFiledWithHeader(header: 'Ghi chú', hint: 'ghi chú'),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: TransactionCreateBottomBar(
          createAct: () {},
          takePhotoAct: () {},
        ),
      ),
    );
  }
}
