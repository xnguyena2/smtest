import 'package:flutter/material.dart';
import 'package:sales_management/component/bottom_bar.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/component/modal/modal_base.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/typedef.dart';

class ModalPayment extends StatefulWidget {
  final double finalPrice;
  final VoidCallbackArg<double> onDone;
  const ModalPayment({
    super.key,
    required this.finalPrice,
    required this.onDone,
  });

  @override
  State<ModalPayment> createState() => _ModalModalPaymentState();
}

class _ModalModalPaymentState extends State<ModalPayment> {
  late bool isActiveOk = widget.finalPrice > 0;
  late double value = widget.finalPrice;

  @override
  Widget build(BuildContext context) {
    double own = widget.finalPrice - value;
    return ModalBase(
      headerTxt: 'Thanh toán trước',
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Black15,
            height: 1,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            MoneyFormater.format(widget.finalPrice),
            style: totalMoneyStylexXXLarge,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 0),
            child: InputFiledWithHeader(
              isAutoFocus: true,
              initValue: widget.finalPrice.toString(),
              header: 'Khách trả',
              hint: 'số tiền khách trả',
              isNumberOnly: true,
              isMoneyFormat: true,
              onChanged: (v) {
                value = double.tryParse(v) ?? 0;
                isActiveOk = value > 0;
                setState(() {});
              },
            ),
          ),
          if (own > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 16,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Khách còn nợ: ',
                    style: subInfoStyLargeLigh400,
                    children: [
                      TextSpan(text: '$own', style: subInfoStyLargeRed400)
                    ],
                  ),
                ),
              ],
            ),
          SizedBox(
            height: 10,
          ),
          BottomBar(
            done: () {
              Navigator.pop(context);
              widget.onDone(value);
            },
            cancel: () {
              Navigator.pop(context);
            },
            okBtnTxt: 'Thanh toán',
            isActiveOk: isActiveOk,
            hideDeleteBtn: true,
          ),
        ],
      ),
    );
  }
}
