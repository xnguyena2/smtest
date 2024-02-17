import 'package:flutter/material.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/api/model/package/package_detail.dart';
import 'package:sales_management/api/model/package/product_package.dart';
import 'package:sales_management/component/btn/approve_btn.dart';
import 'package:sales_management/component/btn/cancel_btn.dart';
import 'package:sales_management/component/loading_overlay_alt.dart';
import 'package:sales_management/component/modal/simple_modal.dart';
import 'package:sales_management/component/text_round.dart';
import 'package:sales_management/page/create_order/create_order_page.dart';
import 'package:sales_management/page/order_list/api/model/package_id.dart';
import 'package:sales_management/page/order_list/api/order_list_api.dart';
import 'package:sales_management/page/order_list/bussiness/order_bussiness.dart';
import 'package:sales_management/page/order_list/component/modal_confirm.dart';
import 'package:sales_management/utils/alter_dialog.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/helper.dart';
import 'package:sales_management/utils/snack_bar.dart';
import 'package:sales_management/utils/typedef.dart';

class PackageItemDetail extends StatelessWidget {
  final PackageDataResponse data;
  final VoidCallbackArg<PackageDataResponse> onUpdated;
  final VoidCallbackArg<PackageDataResponse> onDelete;
  const PackageItemDetail({
    super.key,
    required this.data,
    required this.onUpdated,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    BuyerData? buyer = data.buyer;
    bool isTable = data.packageType == DeliverType.table;
    PaymentStatus status = data.paymentStatus();

    bool isDone = data.isDone;

    String headerTxt = '';
    if (isTable) {
      if (data.areaName == null && data.tableName == null) {
        headerTxt = 'Chưa chọn bàn';
      } else {
        headerTxt = ('${data.areaName ?? ''} - ') + (data.tableName ?? '');
      }
    } else {
      headerTxt = buyer?.reciverFullname ?? 'Khách lẻ';
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateOrderPage(
              data: data.clone(),
              onUpdated: onUpdated,
              onDelete: onDelete,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: data.isLocal ? BackgroundColor : White,
          borderRadius: defaultBorderRadius,
          boxShadow: const [defaultShadow],
          border: data.isLocal ? defaultBorder : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      headerTxt,
                      style: headStyleMedium500,
                    ),
                    if (isTable) ...[
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        buyer?.reciverFullname ?? 'Khách lẻ',
                        style: subInfoStyLargeLigh400,
                      ),
                    ],
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      '${data.localTimeTxt} - ${data.getID}',
                      style: subInfoStyLargeLigh400,
                    ),
                  ],
                ),
                TextRound(
                  txt: isDone ? 'Đã giao' : 'Đang xử lý',
                  isHigh: isDone,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 9,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tổng cộng',
                  style: subInfoStyLarge400,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      data.finalPriceFormat,
                      style: headStyleMedium500,
                    ),
                    Text(
                      data.getStatusTxt(),
                      style: isDone
                          ? subInfoStyMediumHigh400
                          : subInfoStyMediumAlert400,
                    )
                  ],
                )
              ],
            ),
            if (data.isLocal) ...[
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Đơn hàng chưa đồng bộ?'),
                  Row(
                    children: [
                      CancelBtn(
                        txt: 'Hủy',
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        isSmallTxt: true,
                        onPressed: () {
                          showDefaultDialog(
                            context,
                            'Xác nhận hủy!',
                            'Bạn có chắc muốn hủy đơn?',
                            onOk: () {
                              // LoadingOverlayAlt.of(context).show();
                              // cancelPackage(
                              //         PackageID.fromPackageDataResponse(data))
                              //     .then((value) {
                              //   data.deletedOrder();
                              //   onDelete(data);
                              //   LoadingOverlayAlt.of(context).hide();
                              // }).catchError(
                              //   (error, stackTrace) {
                              //     showAlert(context, 'Lỗi hệ thống!');
                              //     LoadingOverlayAlt.of(context).hide();
                              //   },
                              // );
                            },
                            onCancel: () {},
                          );
                        },
                      ),
                      if (haveInteret) ...[
                        const SizedBox(
                          width: 10,
                        ),
                        ApproveBtn(
                          isActiveOk: true,
                          backgroundColor: MainHighColor,
                          txt: 'Đồng bộ',
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          isSmallTxt: true,
                          onPressed: () {
                            print('update package: ${data.packageSecondId}');

                            showDefaultDialog(
                              context,
                              'Xác nhận đồng bộ!',
                              'Bạn có chắc muốn đồng bộ đơn?',
                              onOk: () {
                                // LoadingOverlayAlt.of(context).show();
                                // final transaction = data.makeDone();
                                // final productWithPackge =
                                //     ProductPackage.fromPackageDataResponse(data);

                                // doneOrder(productWithPackge,
                                //         paymentTransaction: transaction)
                                //     .then((value) {
                                //   onUpdated(data);
                                //   LoadingOverlayAlt.of(context).hide();
                                // }).catchError(
                                //   (error, stackTrace) {
                                //     showAlert(context, 'Lỗi hệ thống!');
                                //     LoadingOverlayAlt.of(context).hide();
                                //   },
                                // );
                              },
                              onCancel: () {},
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                ],
              )
            ] else if (!isDone) ...[
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CancelBtn(
                      txt: 'Hủy bỏ',
                      padding: EdgeInsets.symmetric(vertical: 10),
                      isSmallTxt: true,
                      onPressed: () {
                        showDefaultDialog(
                          context,
                          'Xác nhận hủy!',
                          'Bạn có chắc muốn hủy đơn?',
                          onOk: () {
                            LoadingOverlayAlt.of(context).show();
                            cancelOrderPackage(data, false).then((value) {
                              onDelete(data);
                              LoadingOverlayAlt.of(context).hide();
                            }).catchError(
                              (error, stackTrace) {
                                showAlert(context, 'Lỗi hệ thống!');
                                LoadingOverlayAlt.of(context).hide();
                              },
                            );
                          },
                          onCancel: () {},
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ApproveBtn(
                      isActiveOk: true,
                      txt: 'Đã giao',
                      padding: EdgeInsets.symmetric(vertical: 10),
                      isSmallTxt: true,
                      onPressed: () {
                        print('update package: ${data.packageSecondId}');

                        showDefaultDialog(
                          context,
                          'Xác nhận hoàn thành!',
                          'Bạn có chắc muốn đóng đơn?',
                          onOk: () {
                            LoadingOverlayAlt.of(context).show();

                            doneOrder(data, false).then((value) {
                              onUpdated(data);
                              LoadingOverlayAlt.of(context).hide();
                            }).catchError(
                              (error, stackTrace) {
                                showAlert(context, 'Lỗi hệ thống!');
                                LoadingOverlayAlt.of(context).hide();
                              },
                            );
                          },
                          onCancel: () {},
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ],
        ),
      ),
    );
  }
}
