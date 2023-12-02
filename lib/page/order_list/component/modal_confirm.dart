import 'package:flutter/material.dart';
import 'package:sales_management/component/bottom_bar.dart';
import 'package:sales_management/component/modal/modal_base.dart';

class ModalConfirm extends StatelessWidget {
  final VoidCallback onOk;
  const ModalConfirm({
    super.key,
    required this.onOk,
  });

  @override
  Widget build(BuildContext context) {
    return ModalBase(
      headerTxt: 'Tạo danh mục',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Text('Bạn có chắc muốn thực hiện!'),
          ),
          SizedBox(
            height: 4,
          ),
          BottomBar(
            done: () {
              onOk();
              Navigator.pop(context);
            },
            cancel: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
