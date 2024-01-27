import 'package:flutter/material.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/component/bottom_bar.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/component/modal/modal_base.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/typedef.dart';
import 'package:sales_management/utils/utils.dart';

class ModalWholesaleSetting extends StatelessWidget {
  final BeerSubmitData product;
  final VoidCallbackArg<BeerSubmitData> onDone;
  const ModalWholesaleSetting({
    super.key,
    required this.onDone,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final wholesaleprice = product.getWholesalePrice;
    final initValuePrice =
        wholesaleprice <= 0 ? product.getPrice : wholesaleprice;
    final wholesaleno = product.getWholesaleNumber;
    final initValueNo = wholesaleno <= 0 ? 10 : wholesaleno;
    return ModalBase(
      headerTxt: 'Cài đặt giá sỉ',
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: InputFiledWithHeader(
                    header: 'Giá sỉ',
                    hint: 'ví dụ: 10.000',
                    initValue: initValuePrice.toString(),
                    isNumberOnly: true,
                    isMoneyFormat: true,
                    onChanged: (value) {
                      final price = tryParseMoney(value);
                      product.setWholesalePrice(price);
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: InputFiledWithHeader(
                    header: 'Số lượng',
                    hint: 'ví dụ: 10',
                    initValue: '${initValueNo}',
                    isNumberOnly: true,
                    onChanged: (value) {
                      final no = int.tryParse(value) ?? 0;
                      product.setWholesaleNumber(no);
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          BottomBar(
            done: () {
              onDone(product);
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
