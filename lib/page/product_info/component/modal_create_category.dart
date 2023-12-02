import 'package:flutter/material.dart';
import 'package:sales_management/component/bottom_bar.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/component/modal/modal_base.dart';
import 'package:sales_management/page/product_info/api/model/category_container.dart';
import 'package:sales_management/utils/typedef.dart';

class ModalCreateCategory extends StatelessWidget {
  final CategoryContainer config;
  final VoidCallbackArg<CategoryContainer> onDone;
  const ModalCreateCategory({
    super.key,
    required this.onDone,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return ModalBase(
      headerTxt: 'Tạo danh mục',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: InputFiledWithHeader(
              isAutoFocus: true,
              header: 'Tên danh mục',
              hint: 'Nhập tên danh mục',
              onChanged: (category) {
                config.category = category;
              },
            ),
          ),
          SizedBox(
            height: 4,
          ),
          BottomBar(
            done: () {
              onDone(config);
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
