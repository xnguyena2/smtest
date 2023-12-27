import 'package:flutter/material.dart';
import 'package:sales_management/component/bottom_bar.dart';
import 'package:sales_management/component/expand/app_expansion_panel.dart';
import 'package:sales_management/component/modal/simple_modal.dart';
import 'package:sales_management/page/transaction/component/income_outcome_bar.dart';
import 'package:sales_management/page/transaction/component/modal_create_transaction.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class IncomeOutComme extends StatelessWidget {
  const IncomeOutComme({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: IncomeOutComeBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MainCard(),
              _ListTransaction(),
            ],
          ),
        ),
        bottomNavigationBar: BottomBar(
          headOkbtn: LoadSvg(assetPath: 'svg/plus_circle.svg'),
          okBtnTxt: 'Khoảng thu',
          headCancelbtn: LoadSvg(assetPath: 'svg/minus_circle.svg'),
          cancelBtnTxt: 'Khoảng chi',
          enableDelete: true,
          done: () {},
          cancel: () {},
        ),
      ),
    );
  }
}

class _ListTransaction extends StatefulWidget {
  const _ListTransaction({
    super.key,
  });

  @override
  State<_ListTransaction> createState() => _ListTransactionState();
}

class _ListTransactionState extends State<_ListTransaction> {
  bool expaned = false;
  @override
  Widget build(BuildContext context) {
    return AppExpansionPanelList(
      expandedHeaderPadding: EdgeInsets.zero,
      dividerColor: White,
      expansionCallback: (panelIndex, isExpanded) {
        expaned = !expaned;
        setState(() {});
      },
      children: [
        ExpansionPanel(
          isExpanded: expaned,
          canTapOnHeader: true,
          headerBuilder: (context, isExpanded) {
            return TransactionByDate();
          },
          body: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return TransactionDetail(
                isIncome: true,
              );
            },
            scrollDirection: Axis.vertical,
            itemCount: 5,
            separatorBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Divider(
                color: Black40,
              ),
            ),
          ),
        ),
        ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return TransactionByDate();
            },
            body: Container(
              height: 200,
            )),
      ],
    );
  }
}

class TransactionDetail extends StatelessWidget {
  final bool isIncome;
  const TransactionDetail({
    super.key,
    required this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDefaultModal(
          context: context,
          content: ModalTransactionDetail(
            isIncome: isIncome,
          ),
        );
      },
      child: Container(
        color: White,
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bán hàng',
                  style: headStyleBigMediumBlackLight,
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  '23/12/2023',
                  style: headStyleSemiLarge500,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '+1.000.000',
                  style:
                      isIncome ? customerNameBigHigh600 : customerNameBigRed600,
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'Tiền mặt',
                  style: subInfoStyLargeLigh400,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionByDate extends StatelessWidget {
  const TransactionByDate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 16),
      color: Color(0xFFE0E0E0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Thứ hai',
                style: headStyleXLargeSemiBold,
              ),
              Text(
                '23/12/2023',
                style: headStyleMedium,
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: defaultBorderRadius,
                  color: Red,
                ),
                child: Text(
                  '1.000.000',
                  style: customerNameBigWhite600,
                ),
              ),
              SizedBox(
                width: 14,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: defaultBorderRadius,
                  color: TableHighColor,
                ),
                child: Text(
                  '1.000.000',
                  style: customerNameBigWhite600,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class MainCard extends StatelessWidget {
  const MainCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 196,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: defaultBorderRadius,
        gradient: LinearGradient(
          colors: [
            Color(0xFF42224A),
            Color(0xCE42224A),
          ],
          begin: Alignment.centerLeft,
          end: Alignment(1.2, -1.0),
          transform: GradientRotation(1.48353),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 11,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: defaultBorderRadius,
              color: Color(0xFF42224A),
            ),
            child: Text(
              'Số dư',
              style: headStyleLargeWhiteLigh,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '60.000.000',
            style: totalMoneyStylexXXLargeWhite,
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InOutTotal(
                  isIncome: false,
                  txt: '60.000.000',
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: InOutTotal(
                  isIncome: true,
                  txt: '60.000.000',
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class InOutTotal extends StatelessWidget {
  final bool isIncome;
  final String txt;
  const InOutTotal({
    super.key,
    required this.isIncome,
    required this.txt,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: isIncome ? TableHighColor : Red,
          radius: 22.5,
          child: LoadSvg(
              assetPath: isIncome ? 'svg/income.svg' : 'svg/outcome.svg'),
        ),
        SizedBox(
          width: 6,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isIncome ? 'Tổng thu:' : 'Tổng chi:',
                style: headStyleMediumWhiteLigh500,
              ),
              SizedBox(
                height: 3,
              ),
              Tooltip(
                message: txt,
                triggerMode: TooltipTriggerMode.tap,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  txt,
                  style: totalMoneyStylexxXLarge,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
