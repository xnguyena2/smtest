import 'package:flutter/material.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/component/loading_overlay_alt.dart';
import 'package:sales_management/page/transaction/api/model/payment_transaction.dart';
import 'package:sales_management/page/transaction/api/transaction_api.dart';
import 'package:sales_management/page/transaction_create/component/transaction_create_bar.dart';
import 'package:sales_management/page/transaction_create/component/transaction_create_bottom_bar.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/snack_bar.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';
import 'package:sales_management/utils/utils.dart';

class TransactionCreate extends StatefulWidget {
  final PaymentTransaction transaction;
  final VoidCallbackArg<PaymentTransaction> onUpdated;
  const TransactionCreate(
      {super.key, required this.transaction, required this.onUpdated});

  @override
  State<TransactionCreate> createState() => _TransactionCreateState();
}

class _TransactionCreateState extends State<TransactionCreate> {
  late final PaymentTransaction transaction = widget.transaction;
  late final bool isIncome =
      widget.transaction.transaction_type == TType.INCOME;
  @override
  Widget build(BuildContext context) {
    return LoadingOverlayAlt(
      child: Builder(builder: (context) {
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
                      onTap: () async {
                        DateTime? dt = await showDatePicker(
                            context: context,
                            locale: const Locale("vi", "VN"),
                            initialDate:
                                stringToLocalDateTime(transaction.createat),
                            firstDate: DateTime(DateTime.now().year - 1),
                            lastDate: DateTime(DateTime.now().year + 1),
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light(),
                                child: child!,
                              );
                            });
                        if (dt != null) {
                          var now = DateTime.now();
                          var offsetDt = dt.add(Duration(
                              hours: now.hour,
                              minutes: now.minute,
                              seconds: now.second));
                          transaction.createat =
                              localDateTime2ServerToDateTime(offsetDt);
                          print(transaction.createat);
                          setState(() {});
                        }
                      },
                      child: Row(
                        children: [
                          LoadSvg(assetPath: 'svg/calendar_date.svg'),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${getDateinWeekofTimeStampToLocal(transaction.createat)}, ${formatLocalDateTimeOnlyDateSplash(transaction.createat)}',
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
                          isNumberOnly: true,
                          isMoneyFormat: true,
                          header: 'Số tiền',
                          hint: 'ví dụ: 1,000,000',
                          initValue: transaction.amount.toString(),
                          onChanged: (value) {
                            transaction.amount = double.tryParse(value) ?? 0;
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        InputFiledWithHeader(
                          header: 'Mục đích',
                          hint: 'ví dụ: nhập hàng hóa,...',
                          initValue: transaction.category,
                          onChanged: (value) {
                            transaction.category = value;
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        InputFiledWithHeader(
                          header: 'Nguồn tiền',
                          hint: 'ví dụ: tiền mặt',
                          initValue: transaction.money_source,
                          onChanged: (value) {
                            transaction.money_source = value;
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        InputFiledWithHeader(
                          header: 'Ghi chú',
                          hint: 'ghi chú',
                          initValue: transaction.note,
                          onChanged: (value) {
                            transaction.note = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: TransactionCreateBottomBar(
              createAct: () {
                LoadingOverlayAlt.of(context).show();
                createTransaction(transaction).then((value) {
                  LoadingOverlayAlt.of(context).hide();
                  widget.onUpdated(transaction);
                  Navigator.pop(context);
                }).onError((error, stackTrace) {
                  LoadingOverlayAlt.of(context).hide();
                  showAlert(context,
                      'lỗi hệ thống không thể thực hiện bây giờ!');
                });
              },
              takePhotoAct: () {},
            ),
          ),
        );
      }),
    );
  }
}
