import 'package:flutter/material.dart';
import 'package:sales_management/component/btn/approve_btn.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class CreateStorePage extends StatelessWidget {
  const CreateStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: White,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: -250,
                    child: Column(
                      children: [
                        LoadSvg(assetPath: 'svg/logo.svg'),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'Sổ Bán Hàng Điện Tử',
                          style: totalMoneyStylexXLargeBlack,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Form(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Tên cửa hàng',
                              enabledBorder: OutlineInputBorder(
                                  // borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                  // borderSide: BorderSide(color: Colors.grey, width: 0.0),
                                  ),
                              border: OutlineInputBorder(),
                            ),
                            onFieldSubmitted: (value) {},
                            onChanged: (value) {},
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 3) {
                                return 'First Name must contain at least 3 characters';
                              } else if (value
                                  .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                                return 'First Name cannot contain special characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Số điện thoại',
                              enabledBorder: OutlineInputBorder(
                                  // borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                  // borderSide: BorderSide(color: Colors.grey, width: 0.0),
                                  ),
                              border: OutlineInputBorder(),
                            ),
                            onFieldSubmitted: (value) {},
                            onChanged: (value) {},
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 3) {
                                return 'First Name must contain at least 3 characters';
                              } else if (value
                                  .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                                return 'First Name cannot contain special characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ApproveBtn(
                                  isActiveOk: true,
                                  txt: 'Tạo cửa hàng',
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
