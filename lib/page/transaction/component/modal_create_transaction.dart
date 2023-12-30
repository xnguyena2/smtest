import 'package:flutter/material.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/btn/cancel_btn.dart';
import 'package:sales_management/component/btn/round_btn.dart';
import 'package:sales_management/component/loading_overlay_alt.dart';
import 'package:sales_management/page/create_order/create_order_page.dart';
import 'package:sales_management/component/modal/modal_base.dart';
import 'package:sales_management/page/transaction/api/model/payment_transaction.dart';
import 'package:sales_management/page/transaction/api/transaction_api.dart';
import 'package:sales_management/page/transaction_create/transaction_create.dart';
import 'package:sales_management/utils/alter_dialog.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/snack_bar.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';
import 'package:sales_management/utils/utils.dart';

class ModalTransactionDetail extends StatefulWidget {
  final VoidCallbackArg<PaymentTransaction> onUpdated;
  final VoidCallbackArg<PaymentTransaction> onDeleted;
  final PaymentTransaction data;
  final bool isIncome;
  const ModalTransactionDetail({
    super.key,
    required this.isIncome,
    required this.data,
    required this.onUpdated,
    required this.onDeleted,
  });

  @override
  State<ModalTransactionDetail> createState() => _ModalTransactionDetailState();
}

class _ModalTransactionDetailState extends State<ModalTransactionDetail> {
  late bool isIncome = widget.isIncome;
  late PaymentTransaction data = widget.data;
  late final isOfPackage = widget.data.packageSecondId != null;
  @override
  Widget build(BuildContext context) {
    return LoadingOverlayAlt(
      child: Builder(builder: (context) {
        return ModalBase(
          headerTxt: widget.isIncome
              ? 'Chi Tiết khoảng thu'
              : 'Chi tiết khoảng chi',
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                                  assetPath: isIncome
                                      ? 'svg/income.svg'
                                      : 'svg/outcome.svg'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getDateinWeekofTimeStampToLocal(
                                      data.createat),
                                  style: headStyleXLargeSemiBold,
                                ),
                                Text(
                                  formatLocalDateTime(data.createat),
                                  style: headStyleSemiLargeLigh400,
                                ),
                              ],
                            )
                          ],
                        ),
                        Text(
                          MoneyFormater.format(data.amount),
                          style: widget.isIncome
                              ? totalMoneyHeaderStylexXLargeHigh
                              : totalMoneyHeaderStylexXLargeRed,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    const SizedBox(
                      height: 5,
                    ),
                    if (data.category != null)
                      _TransactionDetail(
                        header: 'Mục đích',
                        info: data.category!,
                      ),
                    if (data.money_source != null) ...[
                      const SizedBox(
                        height: 5,
                      ),
                      _TransactionDetail(
                        header: 'Nguồn tiền',
                        info: data.money_source!,
                      ),
                    ],
                    if (data.note != null) ...[
                      const SizedBox(
                        height: 5,
                      ),
                      _TransactionDetail(
                        header: 'Ghi chú',
                        info: data.note!,
                      ),
                    ]
                  ],
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: CancelBtn(
                          headIcon: LoadSvg(assetPath: 'svg/delete.svg'),
                          txt: 'Xóa',
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          onPressed: () {
                            showDefaultDialog(context, 'Xác nhận xóa',
                                'Bạn có chắc muốn xóa', onOk: () {
                              LoadingOverlayAlt.of(context).show();
                              deleteTransaction(data).then((value) {
                                LoadingOverlayAlt.of(context).hide();
                                widget.onDeleted(data);
                                Navigator.pop(context);
                              }).onError((error, stackTrace) {
                                LoadingOverlayAlt.of(context).hide();
                                showAlert(context,
                                    'lỗi hệ thống không thể thực hiện bây giờ!');
                              });
                            }, onCancel: () {});
                          }),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: RoundBtn(
                        isSelected: true,
                        icon: LoadSvg(assetPath: 'svg/edit_pencil_line_01.svg'),
                        txt: isOfPackage ? 'Xêm chi tiết' : 'Chỉnh sửa',
                        onPressed: () async {
                          if (isOfPackage) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateOrderPage(
                                  packageID: data.packageSecondId,
                                  data: PackageDataResponse(
                                      items: [], buyer: null),
                                  onUpdated: (package) {},
                                  onDelete: (PackageDataResponse) {},
                                ),
                              ),
                            );
                            return;
                          }

                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TransactionCreate(
                                transaction: data.clone(),
                                onUpdated: (PaymentTransaction) {
                                  data = PaymentTransaction;
                                  widget.onUpdated(PaymentTransaction);
                                  setState(() {});
                                },
                              ),
                            ),
                          );
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

class _TransactionDetail extends StatelessWidget {
  final String header;
  final String info;
  const _TransactionDetail({
    super.key,
    required this.header,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: headStyleSemiLargeVeryLigh500,
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          info,
          style: headStyleSemiLarge400,
        ),
      ],
    );
  }
}
