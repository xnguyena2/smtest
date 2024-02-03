import 'package:flutter/material.dart';
import 'package:sales_management/api/local_storage/local_storage.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/component/btn/approve_btn.dart';
import 'package:sales_management/component/btn/cancel_btn.dart';
import 'package:sales_management/component/btn/round_btn.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/component/loading_overlay_alt.dart';
import 'package:sales_management/page/create_store/api/model/store.dart';
import 'package:sales_management/page/create_store/create_store_page.dart';
import 'package:sales_management/page/flash/flash.dart';
import 'package:sales_management/page/store_info/api/store_info_api.dart';
import 'package:sales_management/page/store_info/component/store_info_bar.dart';
import 'package:sales_management/utils/alter_dialog.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/helper.dart';
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
            body: FetchAPI<Store?>(
              future: getStoreInfo(),
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
                          _TableChecker(store: store),
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
                          CancelBtn(
                            txt: 'Đăng xuất',
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            onPressed: () async {
                              await LocalStorage.cleanBox();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => FlashPage(),
                                  ),
                                  (Route<dynamic> route) => false);
                            },
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
                                  deleteStore().then((value) async {
                                    await LocalStorage.cleanBox();
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

class _TableChecker extends StatefulWidget {
  final Store? store;
  const _TableChecker({
    super.key,
    this.store,
  });

  @override
  State<_TableChecker> createState() => _TableCheckerState();
}

class _TableCheckerState extends State<_TableChecker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 24.0,
          width: 24.0,
          child: Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith((states) {
              const Set<MaterialState> interactiveStates = <MaterialState>{
                MaterialState.selected,
              };
              if (states.any(interactiveStates.contains)) {
                return TableHighColor;
              }
              return White;
            }),
            value: widget.store?.haveTable() ?? false,
            onChanged: (bool? value) {
              widget.store?.togleTable();
              setState(() {});
            },
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              widget.store?.togleTable();
              setState(() {});
            },
            child: const Text(
              'Cửa hàng có phục vụ tại bàn ăn(Quán ăn, caffe, nhậu,....)',
              style: headStyleSmallLarge,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
