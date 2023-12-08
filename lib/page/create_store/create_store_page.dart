import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:sales_management/api/storage/token_storage.dart';
import 'package:sales_management/component/btn/approve_btn.dart';
import 'package:sales_management/component/loading_overlay_alt.dart';
import 'package:sales_management/page/account/api/account_api.dart';
import 'package:sales_management/page/account/api/model/token.dart';
import 'package:sales_management/page/create_store/api/create_store_api.dart';
import 'package:sales_management/page/create_store/api/model/update_password.dart';
import 'package:sales_management/page/flash/flash.dart';
import 'package:sales_management/page/home/home_page.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/snack_bar.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';
import 'package:sales_management/utils/vntone.dart';

class CreateStorePage extends StatefulWidget {
  const CreateStorePage({super.key});

  @override
  State<CreateStorePage> createState() => _CreateStorePageState();
}

class _CreateStorePageState extends State<CreateStorePage> {
  String userName = '';
  String phoneNumber = '';
  bool isActiveOk = false;
  void validAllField() {
    if (userName.isEmpty || phoneNumber.isEmpty) {
      isActiveOk = false;
      return;
    }
    isActiveOk = true;
    setState(() {});
  }

  void trySigin(String userName, String password, int tryTimes,
      VoidCallback onError, VoidCallbackArg<Token> onSuccess) {
    if (tryTimes <= 0) {
      onError();
      return;
    }
    signin(userName, password).then((value) {
      onSuccess(value);
    }).onError((error, stackTrace) {
      trySigin(userName, password, --tryTimes, onError, onSuccess);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlayAlt(
      child: Builder(builder: (context) {
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
                                onChanged: (value) {
                                  userName = value;
                                  validAllField();
                                },
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
                                onChanged: (value) {
                                  phoneNumber = value;
                                  validAllField();
                                },
                                validator: (value) {},
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ApproveBtn(
                                      isActiveOk: isActiveOk,
                                      txt: 'Tạo cửa hàng',
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12),
                                      onPressed: () {
                                        LoadingOverlayAlt.of(context).show();
                                        createAccount(
                                          UpdatePassword(
                                              username: userName,
                                              oldpassword: '',
                                              newpassword: 'newpassword',
                                              group_id:
                                                  '${removeVNTones(userName).replaceAll(' ', '_')}_$phoneNumber',
                                              roles: [],
                                              phone_number: phoneNumber),
                                        ).then((value) {
                                          trySigin(
                                            userName,
                                            'newpassword',
                                            5,
                                            () {
                                              LoadingOverlayAlt.of(context)
                                                  .hide();
                                              showAlert(context,
                                                  'Không thể tạo cửa hàng!');
                                            },
                                            (token) {
                                              LoadingOverlayAlt.of(context)
                                                  .hide();
                                              var box =
                                                  Hive.box(hiveSettingBox);
                                              box.put(
                                                hiveTokenKey,
                                                TokenStorage(
                                                    token: token.token),
                                              );

                                              loadData().then(
                                                (value) {
                                                  if (value == null) {
                                                    showAlert(context,
                                                        'Không thể vào cửa hàng!');
                                                    return;
                                                  }
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      HomePage()),
                                                          (Route<dynamic>
                                                                  route) =>
                                                              false);
                                                },
                                              );
                                            },
                                          );
                                        }).onError((error, stackTrace) {
                                          LoadingOverlayAlt.of(context).hide();
                                          showAlert(context,
                                              'Không thể tạo cửa hàng!');
                                        });
                                      },
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
      }),
    );
  }
}
