import 'package:flutter/material.dart';
import 'package:sales_management/component/btn/approve_btn.dart';
import 'package:sales_management/component/btn/cancel_btn.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/component/text_round.dart';
import 'package:sales_management/page/create_order/component/create_order_bar.dart';
import 'package:sales_management/page/create_order/component/orcer_progress.dart';
import 'package:sales_management/page/create_order/component/order_bottom_bar.dart';
import 'package:sales_management/page/create_order/component/order_customoer_info.dart';
import 'package:sales_management/page/create_order/component/order_list_product.dart';
import 'package:sales_management/page/create_order/component/order_main_info.dart';
import 'package:sales_management/page/create_order/component/order_note.dart';
import 'package:sales_management/page/create_order/component/order_select_area_deliver.dart';
import 'package:sales_management/page/create_order/component/order_total_price.dart';
import 'package:sales_management/page/create_order/component/order_transaction.dart';
import 'package:sales_management/utils/svg_loader.dart';

import '../../utils/constants.dart';

class CreateOrderPage extends StatelessWidget {
  const CreateOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CreateOrderBar(),
      body: Container(
        // padding: EdgeInsets.symmetric(vertical: 10),
        color: BackgroundColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SelectAreaAndDeliver(),
              SizedBox(
                height: 10,
              ),
              OrderMainInfo(),
              SizedBox(
                height: 15,
              ),
              CustomerInfo(),
              SizedBox(
                height: 15,
              ),
              ListProduct(),
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
