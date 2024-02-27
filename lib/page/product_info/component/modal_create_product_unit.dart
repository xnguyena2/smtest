import 'package:flutter/material.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/component/bottom_bar.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/component/modal/modal_base.dart';
import 'package:sales_management/page/product_info/api/model/category_container.dart';
import 'package:sales_management/utils/typedef.dart';

class ModalCreateProductUnit extends StatelessWidget {
  final BeerSubmitData product;
  final VoidCallbackArg<CategoryContainer> onDone;
  const ModalCreateProductUnit({
    super.key,
    required this.onDone,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return ModalBase(
      headerTxt: 'Phân loại',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: InputFiledWithHeader(
              isAutoFocus: true,
              header: 'Tên danh mục',
              hint: 'Nhập tên danh mục',
              onChanged: (category) {},
            ),
          ),
          SizedBox(
            height: 4,
          ),
          BottomBar(
            done: () {
              Navigator.pop(context);
            },
            cancel: () {
              Navigator.pop(context);
            },
            okBtnTxt: 'Tạo',
          ),
        ],
      ),
    );
  }
}
