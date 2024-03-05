import 'package:flutter/material.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/component/bottom_bar.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/component/modal/modal_base.dart';
import 'package:sales_management/utils/typedef.dart';
import 'package:sales_management/utils/utils.dart';

class ModalUpdateAllProductUnitWIthSame extends StatelessWidget {
  final BeerUnit productUnit;
  final VoidCallbackArg<BeerUnit> onDone;
  const ModalUpdateAllProductUnitWIthSame({
    super.key,
    required this.onDone,
    required this.productUnit,
  });

  @override
  Widget build(BuildContext context) {
    return ModalBase(
      headerTxt: 'Sửa hàng loạt',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InputFiledWithHeader(
                        isNumberOnly: true,
                        isMoneyFormat: true,
                        initValue: productUnit.price.toString(),
                        header: 'Giá bán',
                        hint: '0.000',
                        isImportance: true,
                        onChanged: (value) {
                          productUnit.price = tryParseMoney(value);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: InputFiledWithHeader(
                        isNumberOnly: true,
                        isMoneyFormat: true,
                        initValue: productUnit.buyPrice.toString(),
                        header: 'Giá vốn',
                        hint: '0.000',
                        isImportance: true,
                        onChanged: (value) {
                          productUnit.buyPrice = tryParseMoney(value);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                InputFiledWithHeader(
                  isNumberOnly: true,
                  isMoneyFormat: true,
                  initValue: productUnit.inventory_number.toString(),
                  header: 'Tồn kho',
                  hint: '0',
                  isImportance: true,
                  onChanged: (value) {
                    productUnit.inventory_number = tryParseNumber(value);
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          BottomBar(
            done: () {
              onDone(productUnit);
              Navigator.pop(context);
            },
            cancel: () {
              Navigator.pop(context);
            },
            okBtnTxt: 'Cập nhật',
          ),
        ],
      ),
    );
  }
}
