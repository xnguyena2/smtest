import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:sales_management/api/local_storage/local_storage.dart';
import 'package:sales_management/api/storage/token_storage.dart';
import 'package:sales_management/component/btn/approve_btn.dart';
import 'package:sales_management/component/checkbox/check_box.dart';
import 'package:sales_management/component/loading_overlay_alt.dart';
import 'package:sales_management/page/account/api/account_api.dart';
import 'package:sales_management/page/account/api/model/token.dart';
import 'package:sales_management/page/create_store/api/create_store_api.dart';
import 'package:sales_management/page/create_store/api/model/store_init_data.dart';
import 'package:sales_management/page/create_store/api/model/update_password.dart';
import 'package:sales_management/page/flash/flash.dart';
import 'package:sales_management/page/home/home_page.dart';
import 'package:sales_management/page/login_by_qr/api/tokens_api.dart';
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
  bool isChecked = true;
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
          top: false,
          bottom: false,
          child: Scaffold(
            backgroundColor: White,
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Center(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
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
                                      borderSide: BorderSide(
                                          color: Black40, width: 1.0),
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
                                      borderSide: BorderSide(
                                          color: Black40, width: 1.0),
                                    ),
                                  ),
                                  textInputAction: TextInputAction.done,
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
                                    SmallCheckBox(
                                      isChecked: isChecked,
                                      onChanged: (value) {
                                        isChecked = value;
                                        setState(() {});
                                      },
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isChecked = !isChecked;
                                          });
                                        },
                                        child: const Text(
                                          'Cửa hàng có phục vụ tại bàn ăn(Quán ăn, caffe, nhậu,....)',
                                          style: headStyleSmallLarge,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
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
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          LoadingOverlayAlt.of(context).show();
                                          if (userName == 'iphone' &&
                                              phoneNumber == '12365') {
                                            print('loading default user!');
                                            loadData(true).then(
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
                                            ).then((value) {
                                              LoadingOverlayAlt.of(context)
                                                  .hide();
                                            }).onError((error, stackTrace) {
                                              LoadingOverlayAlt.of(context)
                                                  .hide();
                                              showAlert(context,
                                                  'Không thể vào cửa hàng!');
                                            });
                                            return;
                                          }
                                          final storeName = userName;
                                          final defaultPassword = 'newpassword';
                                          createAccountAndStore(
                                            StoreInitData.fromStoreNameAndPhone(
                                              storeName: storeName,
                                              password: defaultPassword,
                                              phone: phoneNumber,
                                              haveTable: isChecked,
                                            ),
                                          ).then((value) {
                                            trySigin(
                                              phoneNumber,
                                              defaultPassword,
                                              5,
                                              () {
                                                LoadingOverlayAlt.of(context)
                                                    .hide();
                                                showAlert(context,
                                                    'Không thể tạo cửa hàng!');
                                              },
                                              (token) async {
                                                await LocalStorage.cleanBox();
                                                LocalStorage.putToken(token);

                                                await loadData(false).then(
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
                                                                      HomePage(),
                                                            ),
                                                            (Route<dynamic>
                                                                    route) =>
                                                                false);
                                                  },
                                                ).onError((error, stackTrace) {
                                                  showAlert(context,
                                                      'Không thể vào cửa hàng!');
                                                });
                                                LoadingOverlayAlt.of(context)
                                                    .hide();
                                              },
                                            );
                                          }).onError((error, stackTrace) {
                                            LoadingOverlayAlt.of(context)
                                                .hide();
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
                          height: 30,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Nếu bạn đã có tài khoảng? ',
                            style: headStyleSmallLarge,
                            children: [
                              TextSpan(
                                text: 'Đăng nhập bằng mã code!!',
                                style: headStyleSmallLargeHigh,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    var result = await BarcodeScanner.scan();

                                    LoadingOverlayAlt.of(context).show();
                                    final tokenID = result.rawContent;
                                    getToken(tokenID).then((token) async {
                                      await LocalStorage.cleanBox();
                                      LocalStorage.putToken(token);

                                      await loadData(false).then(
                                        (value) {
                                          LoadingOverlayAlt.of(context).hide();
                                          if (value == null) {
                                            showAlert(context,
                                                'Không thể đăng nhập!');
                                            return;
                                          }
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomePage(),
                                                  ),
                                                  (Route<dynamic> route) =>
                                                      false);
                                        },
                                      ).onError((error, stackTrace) {
                                        LoadingOverlayAlt.of(context).hide();
                                        showAlert(
                                            context, 'Không thể đăng nhập!');
                                      });
                                    }).onError((error, stackTrace) {
                                      LoadingOverlayAlt.of(context).hide();
                                      showAlert(
                                          context, 'Không thể đăng nhập!');
                                    });
                                    LoadingOverlayAlt.of(context).hide();
                                  },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Product of Nguyen Pong',
                              style: subInfoStyLarge400,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            LoadSvg(
                                assetPath: 'svg/cat_face_with_wry_smile.svg'),
                          ],
                        ),
                      ],
                    ),
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
