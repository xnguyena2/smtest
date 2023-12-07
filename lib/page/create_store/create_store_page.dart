import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sales_management/component/btn/approve_btn.dart';
import 'package:sales_management/page/create_store/api/create_store_api.dart';
import 'package:sales_management/page/create_store/api/model/update_password.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class CreateStorePage extends StatelessWidget {
  const CreateStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    // createAccount(UpdatePassword(
    //     username: 'username',
    //     oldpassword: '',
    //     newpassword: 'newpassword',
    //     group_id: 'shop_ban_chuoi',
    //     roles: []));
    return SafeArea(
      child: Scaffold(
        backgroundColor: White,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  LoadSvg(assetPath: 'svg/logo.svg'),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Sổ Bán Hàng Điện Tử',
                    style: totalMoneyStylexXLargeBlack,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      child: Column(
                        children: [
                          TextFormField(
                            style: customerNameBig400,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              labelStyle: customerNameBigHardLight400,
                              labelText: 'Tên cửa hàng',
                              border: OutlineInputBorder(
                                borderRadius: defaultBorderRadius,
                                borderSide:
                                    BorderSide(color: Black40, width: 1.0),
                              ),
                            ),
                            onFieldSubmitted: (value) {},
                            onChanged: (value) {},
                            validator: (value) {},
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            style: customerNameBig400,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              labelStyle: customerNameBigHardLight400,
                              labelText: 'Số điện thoại',
                              border: OutlineInputBorder(
                                borderRadius: defaultBorderRadius,
                                borderSide:
                                    BorderSide(color: Black40, width: 1.0),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onFieldSubmitted: (value) {},
                            onChanged: (value) {},
                            validator: (value) {},
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
                  SizedBox(
                    height: 10,
                  ),
                  Text('Product of Nguyen Pong'),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
