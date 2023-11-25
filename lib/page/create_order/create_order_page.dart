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
import 'package:sales_management/page/create_order/provider/price_provider.dart';
import 'package:sales_management/page/create_order/state/state_aretable.dart';
import 'package:sales_management/page/order_list/api/order_list_api.dart';
import 'package:sales_management/utils/typedef.dart';

import '../../utils/constants.dart';

class CreateOrderPage extends StatelessWidget {
  final PackageDataResponse data;
  final VoidCallbackArg<PackageDataResponse> onUpdated;
  const CreateOrderPage(
      {super.key, required this.data, required this.onUpdated});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CreateOrderBar(
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: CreateOrderBody(data: data),
      bottomNavigationBar: BottomBar(
        done: () {
          data.runPendingAction();
          updatePackage(ProductPackage.fromPackageDataResponse(data));
          onUpdated(data);
        },
        cancel: () {},
      ),
    ));
  }
}

class CreateOrderBody extends StatefulWidget {
  const CreateOrderBody({
    super.key,
    required this.data,
  });

  final PackageDataResponse data;

  @override
  State<CreateOrderBody> createState() => _CreateOrderBodyState();
}

class _CreateOrderBodyState extends State<CreateOrderBody> {
  late final OrderMainInfo orderMainInfo;
  late final TotalPrice totalPrice;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUI();
  }

  void initUI() {
    orderMainInfo = OrderMainInfo(
      data: widget.data,
    );
    totalPrice = TotalPrice(
      isEditting: true,
      data: widget.data,
      onRefreshData: () {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PriceProvider(widget.data),
        )
      ],
      child: Container(
        // padding: EdgeInsets.symmetric(vertical: 10),
        color: BackgroundColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SelectAreaAndDeliver(
                data: widget.data,
                onRefreshData: () {
                  setState(() {});
                },
              ),
              SizedBox(
                height: 10,
              ),
              StateAreaTable(
                data: widget.data.areAndTable,
                totalPrice: widget.data.priceFormat,
                numItems: widget.data.totalNumIems,
                finalPrice: widget.data.finalPrice,
                payment: widget.data.payment,
                child: orderMainInfo,
              ),
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
                updateData: () {
                  setState(() {});
                },
              ),
              SizedBox(
                height: 15,
              ),
              StateAreaTable(
                data: widget.data.areAndTable,
                totalPrice: widget.data.priceFormat,
                numItems: widget.data.totalNumIems,
                finalPrice: widget.data.finalPrice,
                payment: widget.data.payment,
                child: totalPrice,
              ),
              SizedBox(
                height: 15,
              ),
              Transaction(
                data: widget.data,
              ),
              SizedBox(
                height: 15,
              ),
              Progress(),
              SizedBox(
                height: 15,
              ),
              OrderNote(),
            ],
          ),
        ),
      ),
    );
  }
}
