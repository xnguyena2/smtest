import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_management/api/local_storage/local_storage.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/api/model/package/product_package.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/component/btn/approve_btn.dart';
import 'package:sales_management/component/loading_overlay_alt.dart';
import 'package:sales_management/page/create_order/component/create_order_bar.dart';
import 'package:sales_management/page/create_order/component/order_progress.dart';
import 'package:sales_management/component/bottom_bar.dart';
import 'package:sales_management/page/create_order/component/order_customoer_info.dart';
import 'package:sales_management/page/create_order/component/order_list_product.dart';
import 'package:sales_management/page/create_order/component/order_main_info.dart';
import 'package:sales_management/page/create_order/component/order_note.dart';
import 'package:sales_management/page/create_order/component/order_select_area_deliver.dart';
import 'package:sales_management/page/create_order/component/order_total_price.dart';
import 'package:sales_management/page/create_order/component/order_transaction.dart';
import 'package:sales_management/page/order_list/api/model/package_id.dart';
import 'package:sales_management/page/order_list/api/order_list_api.dart';
import 'package:sales_management/page/order_list/bussiness/order_bussiness.dart';
import 'package:sales_management/page/print/print_page.dart';
import 'package:sales_management/page/product_selector/component/provider_discount.dart';
import 'package:sales_management/page/product_selector/component/provider_product.dart';
import 'package:sales_management/utils/alter_dialog.dart';
import 'package:sales_management/utils/helper.dart';
import 'package:sales_management/utils/snack_bar.dart';
import 'package:sales_management/utils/typedef.dart';

import '../../utils/constants.dart';

class CreateOrderPage extends StatelessWidget {
  final String? packageID;
  final PackageDataResponse data;
  final VoidCallbackArg<PackageDataResponse> onUpdated;
  final VoidCallbackArg<PackageDataResponse> onDelete;
  const CreateOrderPage(
      {super.key,
      required this.data,
      required this.onUpdated,
      required this.onDelete,
      this.packageID});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: BackgroundColor,
      child: FetchAPI<PackageDataResponse>(
        future: packageID != null
            ? getPackage(PackageID.fromPackageID(packageID!))
            : Future.value(data),
        successBuilder: (data) {
          return LoadingOverlayAlt(
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => ProductProvider(data),
                ),
                ChangeNotifierProvider(
                  create: (_) => DiscountProvider(0),
                ),
              ],
              child: SafeArea(
                top: false,
                bottom: false,
                child: Builder(builder: (context) {
                  return Scaffold(
                    appBar: CreateOrderBar(
                      onBackPressed: () {
                        Navigator.pop(context);
                      },
                      onReturn: data.isDone
                          ? () {
                              showDefaultDialog(
                                context,
                                'Xác nhận trả đơn!',
                                'Đơn này người mua trả lại?',
                                onOk: () {
                                  LoadingOverlayAlt.of(context).show();
                                  returnOrder(PackageID.fromPackageDataResponse(
                                          data))
                                      .then((value) {
                                    data.deletedOrder();
                                    onDelete(data);
                                    Navigator.pop(context);
                                    LoadingOverlayAlt.of(context).hide();
                                  }).onError((error, stackTrace) {
                                    showAlert(context, 'Không thể trả!');
                                    LoadingOverlayAlt.of(context).hide();
                                  });
                                },
                                onCancel: () {},
                              );
                            }
                          : null,
                    ),
                    body: CreateOrderBody(
                      data: data,
                      onUpdated: () => onUpdated(data),
                    ),
                    bottomNavigationBar: data.isDone
                        ? null
                        : BottomBar(
                            done: () {
                              LoadingOverlayAlt.of(context).show();
                              data.runPendingAction();
                              final transaction = data.makeDone();
                              final productWithPackge =
                                  ProductPackage.fromPackageDataResponse(data);

                              doneOrder(productWithPackge,
                                      paymentTransaction: transaction)
                                  .then((value) {
                                onUpdated(data);
                                context.read<ProductProvider>().justRefresh();
                                LoadingOverlayAlt.of(context).hide();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PrintPage(
                                      data: data,
                                    ),
                                  ),
                                );
                              }).onError((error, stackTrace) {
                                showAlert(context, 'Không thể cập nhật!');
                                LoadingOverlayAlt.of(context).hide();
                              });
                            },
                            cancel: () {
                              showDefaultDialog(
                                context,
                                'Xác nhận hủy!',
                                'Bạn có chắc muốn hủy đơn?',
                                onOk: () {
                                  LoadingOverlayAlt.of(context).show();
                                  cancelPackage(
                                          PackageID.fromPackageDataResponse(
                                              data))
                                      .then((value) {
                                    data.deletedOrder();
                                    onDelete(data);
                                    Navigator.pop(context);
                                    LoadingOverlayAlt.of(context).hide();
                                  }).onError((error, stackTrace) {
                                    showAlert(context, 'Không thể hủy!');
                                    LoadingOverlayAlt.of(context).hide();
                                  });
                                },
                                onCancel: () {},
                              );
                            },
                            midleWidget: ApproveBtn(
                              isActiveOk: true,
                              txt: 'Lưu đơn',
                              padding: EdgeInsets.symmetric(vertical: 12),
                              backgroundColor: HighColor,
                              onPressed: () {
                                LoadingOverlayAlt.of(context).show();
                                data.runPendingAction();
                                updatePackage(
                                        ProductPackage.fromPackageDataResponse(
                                            data))
                                    .then((value) {
                                  onUpdated(data);
                                  context.read<ProductProvider>().justRefresh();
                                  LoadingOverlayAlt.of(context).hide();
                                  Navigator.pop(context);
                                }).onError((error, stackTrace) {
                                  showAlert(context, 'Không thể cập nhật!');
                                  LoadingOverlayAlt.of(context).hide();
                                });
                              },
                            ),
                          ),
                  );
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CreateOrderBody extends StatelessWidget {
  final VoidCallback onUpdated;
  const CreateOrderBody({
    super.key,
    required this.data,
    required this.onUpdated,
  });

  final PackageDataResponse data;

  @override
  Widget build(BuildContext context) {
    final bool isDone = data.isDone;
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 10),
      color: BackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SelectAreaAndDeliver(
              data: data,
            ),
            SizedBox(
              height: 10,
            ),
            if (isDone) ...[
              OrderMainInfo(),
              SizedBox(
                height: 15,
              ),
            ],
            ListProduct(
              data: data,
            ),
            SizedBox(
              height: 15,
            ),
            CustomerInfo(
              data: data,
            ),
            SizedBox(
              height: 15,
            ),
            TotalPrice(
              data: data,
              onUpdate: () {
                onUpdated();
              },
            ),
            Transaction(),
            if (isDone) ...[
              SizedBox(
                height: 15,
              ),
              Progress(
                data: data,
              ),
            ],
            SizedBox(
              height: 15,
            ),
            OrderNote(
              data: data,
            ),
          ],
        ),
      ),
    );
  }
}
