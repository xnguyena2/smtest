import 'package:flutter/material.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/page/create_order/component/create_order_bar.dart';
import 'package:sales_management/page/create_order/component/order_progress.dart';
import 'package:sales_management/page/create_order/component/order_bottom_bar.dart';
import 'package:sales_management/page/create_order/component/order_customoer_info.dart';
import 'package:sales_management/page/create_order/component/order_list_product.dart';
import 'package:sales_management/page/create_order/component/order_main_info.dart';
import 'package:sales_management/page/create_order/component/order_note.dart';
import 'package:sales_management/page/create_order/component/order_select_area_deliver.dart';
import 'package:sales_management/page/create_order/component/order_total_price.dart';
import 'package:sales_management/page/create_order/component/order_transaction.dart';

import '../../utils/constants.dart';

class CreateOrderPage extends StatelessWidget {
  final PackageDataResponse data;
  const CreateOrderPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CreateOrderBar(
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Container(
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
              OrderMainInfo(
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
              ListProduct(
                data: data,
              ),
              SizedBox(
                height: 15,
              ),
              TotalPrice(
                isEditting: true,
              ),
              SizedBox(
                height: 15,
              ),
              Transaction(),
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
      bottomNavigationBar: BottomBar(),
    ));
  }
}
