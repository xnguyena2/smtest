import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sales_management/component/btn/round_btn.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/component/loading_overlay_alt.dart';
import 'package:sales_management/page/create_store/create_store_page.dart';
import 'package:sales_management/page/store_info/api/store_info_api.dart';
import 'package:sales_management/page/store_info/component/store_info_bar.dart';
import 'package:sales_management/utils/alter_dialog.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/snack_bar.dart';
import 'package:sales_management/utils/svg_loader.dart';

class StoreInfoPage extends StatelessWidget {
  const StoreInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingOverlayAlt(
      child: Builder(builder: (context) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            appBar: StoreInfoBar(),
            body: Container(
              color: BackgroundColor,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 12),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  color: White,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputFiledWithHeader(
                        initValue: deviceID,
                        header: 'Tên cửa hàng',
                        hint: 'Ví dụ: Shop bán chuối',
                        isImportance: false,
                        onChanged: (value) {},
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InputFiledWithHeader(
                        initValue: userPhoneNumber,
                        header: 'Số điện thoại',
                        hint: 'Ví dụ: 087654321',
                        isImportance: false,
                        onChanged: (value) {},
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RoundBtn(
                        isDelete: true,
                        icon: LoadSvg(assetPath: 'svg/delete.svg'),
                        txt: 'Xóa cửa hàng',
                        onPressed: () async {
                          showDefaultDialog(
                            context,
                            'Xác nhận xóa!',
                            'Bạn có chắc muốn xóa cửa hàng?',
                            onOk: () {
                              LoadingOverlayAlt.of(context).show();
                              deleteStore().then((value) {
                                var box = Hive.box(hiveSettingBox);
                                box.delete(hiveTokenKey);
                                LoadingOverlayAlt.of(context).hide();

                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CreateStorePage()),
                                    (Route<dynamic> route) => false);
                              }).onError((error, stackTrace) {
                                showAlert(
                                    context, 'Không thể xóa cửa hàng!');
                                LoadingOverlayAlt.of(context).hide();
                              });
                            },
                            onCancel: () {},
                          );
                        },
                      )
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
