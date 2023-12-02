import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/api/model/package/product_package.dart';
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
import 'package:sales_management/page/product_selector/component/provider_product.dart';
import 'package:sales_management/utils/snack_bar.dart';
import 'package:sales_management/utils/typedef.dart';

import '../../utils/constants.dart';

class CreateOrderPage extends StatelessWidget {
  final PackageDataResponse data;
  final VoidCallbackArg<PackageDataResponse> onUpdated;
  final VoidCallbackArg<PackageDataResponse> onDelete;
  const CreateOrderPage(
      {super.key,
      required this.data,
      required this.onUpdated,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductProvider(data),
        )
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: CreateOrderBar(
            onBackPressed: () {
              Navigator.pop(context);
            },
          ),
          body: CreateOrderBody(
            data: data,
            onUpdated: () => onUpdated(data),
          ),
          bottomNavigationBar: Builder(
            builder: (context) => BottomBar(
              done: () {
                data.runPendingAction();
                data.makeDone();
                updatePackage(ProductPackage.fromPackageDataResponse(data))
                    .then((value) {
                  onUpdated(data);
                  context.read<ProductProvider>().justRefresh();
                }).onError((error, stackTrace) {
                  showAlert(context, 'Không thể cập nhật!');
                });
              },
              cancel: () {
                deletePackage(PackageID.fromPackageDataResponse(data))
                    .then((value) {
                  onDelete(data);
                  Navigator.pop(context);
                }).onError((error, stackTrace) {
                  showAlert(context, 'Không thể hủy!');
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CreateOrderBody extends StatefulWidget {
  final VoidCallback onUpdated;
  const CreateOrderBody({
    super.key,
    required this.data,
    required this.onUpdated,
  });

  final PackageDataResponse data;

  @override
  State<CreateOrderBody> createState() => _CreateOrderBodyState();
}

class _CreateOrderBodyState extends State<CreateOrderBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUI();
  }

  void initUI() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 10),
      color: BackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SelectAreaAndDeliver(
              data: widget.data,
            ),
            SizedBox(
              height: 10,
            ),
            OrderMainInfo(),
            SizedBox(
              height: 15,
            ),
            CustomerInfo(
              data: widget.data,
            ),
            SizedBox(
              height: 15,
            ),
            ListProduct(
              data: widget.data,
            ),
            SizedBox(
              height: 15,
            ),
            TotalPrice(
              isEditting: true,
              data: widget.data,
              onUpdate: () {
                widget.onUpdated();
              },
            ),
            SizedBox(
              height: 15,
            ),
            Transaction(),
            SizedBox(
              height: 15,
            ),
            Progress(
              data: widget.data,
            ),
            SizedBox(
              height: 15,
            ),
            OrderNote(
              data: widget.data,
            ),
          ],
        ),
      ),
    );
  }
}
