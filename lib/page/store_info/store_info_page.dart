import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/component/btn/approve_btn.dart';
import 'package:sales_management/component/btn/round_btn.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/component/loading_overlay_alt.dart';
import 'package:sales_management/page/create_store/api/model/store.dart';
import 'package:sales_management/page/create_store/create_store_page.dart';
import 'package:sales_management/page/home/api/model/bootstrap.dart';
import 'package:sales_management/page/store_info/api/store_info_api.dart';
import 'package:sales_management/page/store_info/component/store_info_bar.dart';
import 'package:sales_management/utils/alter_dialog.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/snack_bar.dart';
import 'package:sales_management/utils/svg_loader.dart';

class StoreInfoPage extends StatelessWidget {
  const StoreInfoPage({super.key});

  Future<Store?> getBenifitOfMonth() async {
    var box = Hive.box(hiveSettingBox);
    BootStrapData? config = box.get(hiveConfigKey);
    if (config == null) {
      return null;
    }

    return config.store;
  }

  void updateStoreData(Store store) {
    var box = Hive.box(hiveSettingBox);
    BootStrapData? config = box.get(hiveConfigKey);
    config?.store = store;
    box.put(hiveConfigKey, config);
    setGlobalValue(
        store_ame: store.name,
        groupId: groupID,
        phoneNumber: store.phone ?? '',
        device_id: deviceID);
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlayAlt(
      child: Builder(builder: (context) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            appBar: StoreInfoBar(),
            body: FetchAPI<Store?>(
              future: getBenifitOfMonth(),
              successBuilder: (store) {
                return Container(
                  color: BackgroundColor,
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(top: 12),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      color: White,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputFiledWithHeader(
                            initValue: store?.name,
                            header: 'Tên cửa hàng',
                            hint: 'Ví dụ: Shop bán chuối',
                            isImportance: false,
                            onChanged: (value) {
                              store?.name = value;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InputFiledWithHeader(
                            initValue: store?.phone,
                            header: 'Số điện thoại',
                            hint: 'Ví dụ: 087654321',
                            isImportance: false,
                            onChanged: (value) {
                              store?.phone = value;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InputFiledWithHeader(
                            initValue: store?.address,
                            header: 'Địa chỉ',
                            hint: 'Địa chỉ shop của bạn',
                            isImportance: false,
                            onChanged: (value) {
                              store?.address = value;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ApproveBtn(
                                  isActiveOk: true,
                                  txt: 'Cập Nhật',
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  onPressed: () async {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    if (store == null) {
                                      showAlert(
                                          context, 'Không thể cập nhật!');
                                      return;
                                    }
                                    LoadingOverlayAlt.of(context).show();

                                    updateStore(store).then((value) {
                                      LoadingOverlayAlt.of(context).hide();
                                      updateStoreData(store);
                                      showNotification(
                                          context, 'Cập nhật thành công!');
                                    }).onError((error, stackTrace) {
                                      LoadingOverlayAlt.of(context).hide();
                                      showAlert(
                                          context, 'Không thể cập nhật!');
                                    });
                                  },
                                ),
                              ),
                            ],
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
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
