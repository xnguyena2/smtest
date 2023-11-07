import 'package:flutter/material.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/utils/constants.dart';

class CreateCombo extends StatelessWidget {
  const CreateCombo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultPaddingContainer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thông tin khác',
          style: headStyleXLarge,
        ),
        SizedBox(
          height: 10,
        ),
        InputFiledWithHeader(
          header: 'Nhóm bán kèm',
          hint: 'Chọn 1 hoặc nhiều nhóm bán kèm',
          isImportance: false,
          isDisable: true,
        ),
      ],
    ));
  }
}
