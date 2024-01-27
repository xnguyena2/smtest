import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/page/address/api/address_api.dart';
import 'package:sales_management/page/address/api/model/address_data.dart';
import 'package:sales_management/page/address/api/model/list_buyer.dart';
import 'package:sales_management/page/address/component/address_list_buyer.dart';
import 'package:sales_management/page/address/component/location_select_bar.dart';
import 'package:sales_management/page/buyer/api/buyer_api.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/debouncer.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';

import 'location_select.dart';

class ReciverInfo extends StatefulWidget {
  final AddressData addressData;
  final VoidCallbackArg<AddressData> done;
  final VoidCallback delete;
  final bool isEdit;
  final bool isEnableFindBuyer;
  const ReciverInfo({
    super.key,
    required this.addressData,
    required this.done,
    required this.isEdit,
    required this.delete,
    this.isEnableFindBuyer = false,
  });

  @override
  State<ReciverInfo> createState() => _ReciverInfoState();
}

class _ReciverInfoState extends State<ReciverInfo> {
  late bool enableDone;
  late AddressData addressData = widget.addressData;
  late Debouncer searchDebouncer = Debouncer(milliseconds: 300);
  late Future<ListBuyerResult> loadingListBuyer;
  late Key phoneNumbeKey;
  bool validData() {
    return true;
    // if (addressData.reciverFullName.isEmpty) {
    //   return false;
    // }
    // if (addressData.houseNumber.isEmpty) {
    //   return false;
    // }
    // if (addressData.phoneNumber.isEmpty) {
    //   return false;
    // }
    // if (addressData.regionTextFormat.isEmpty) {
    //   return false;
    // }
    // return true;
  }

  void checkValid() {
    enableDone = validData();
  }

  void initialValue() {
    phoneNumbeKey = ValueKey('phoneNumber');
  }

  @override
  void initState() {
    super.initState();
    checkValid();
    loadingListBuyer =
        Future.value(ListBuyerResult(listResult: [])); //searchUser(''); //
    initialValue();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: AddressSelectBar(
          onBackPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: BackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleHeader("Liên hệ"),
              InputText(
                key: ValueKey('reciverFullName ${addressData.reciverFullName}'),
                hint: "Họ và tên",
                textInputType: TextInputType.name,
                onChanged: (value) {
                  addressData.reciverFullName = value;
                },
                initialValue: addressData.reciverFullName,
              ),
              const Divider(height: 1),
              InputText(
                key: phoneNumbeKey,
                isAutoFocus: true,
                hint: "Số điện thoại",
                initialValue: addressData.phoneNumber,
                onChanged: (String value) {
                  addressData.phoneNumber = value;
                  if (widget.isEnableFindBuyer) {
                    searchDebouncer.run(() {
                      loadingListBuyer = searchUser(value);
                      setState(() {});
                    });
                  }
                },
                textInputType: TextInputType.number,
              ),
              TitleHeader("Địa chỉ"),
              TextButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationSelect(
                        addressData: addressData,
                      ),
                    ),
                  );
                  setState(() {});
                },
                style: TextButton.styleFrom(
                  backgroundColor: BackgroundColorLigh,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: const EdgeInsets.all(15),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.zero)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      addressData.regionTextFormat.isEmpty
                          ? "Tỉnh/Thành phố, Quận/Huyện, Phường/Xã"
                          : addressData.regionTextFormat,
                      style: headStyleBigMediumBlackLight,
                    ),
                    LoadSvg(assetPath: 'svg/next.svg', width: 15, height: 15)
                  ],
                ),
              ),
              const Divider(height: 1),
              InputText(
                key: ValueKey('houseNumber ${addressData.houseNumber}'),
                hint: "Tên đường, Tòa nhà, Số nhà.",
                initialValue: addressData.houseNumber,
                textInputType: TextInputType.text,
                onChanged: (String value) {
                  addressData.houseNumber = value;
                },
              ),
              if (widget.isEdit) ...[
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          backgroundColor: White,
                        ),
                        onPressed: () {
                          print(addressData.toJson().toString());
                          widget.delete();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Xóa",
                          style: headStyleLargeAlert,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                )
              ],
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: TableHighColor,
                          disabledBackgroundColor: Black40),
                      onPressed: enableDone
                          ? () {
                              // print(addressData.toJson().toString());
                              final buyer = addressData.getBuyerData ??
                                  BuyerData(region: '', district: '', ward: '');
                              buyer.updateData(addressData);
                              buyer.updateDeviceID(addressData);
                              createBuyer(buyer);
                              widget.done(addressData);
                              Navigator.pop(context);
                            }
                          : null,
                      child: const Text(
                        "Hoàng Thành",
                        style: subInfoStyLargeWhite400,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              ),
              ListBuyer(
                loadingListBuyer: loadingListBuyer,
                onSelected: (buyerData) {
                  addressData = buyerData;
                  phoneNumbeKey =
                      ValueKey('phoneNumber ${addressData.phoneNumber}');
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container TitleHeader(String txt) {
    return Container(
      child: Text(txt),
      padding: EdgeInsets.all(15),
    );
  }
}

class InputText extends StatelessWidget {
  final String hint;
  final TextInputType textInputType;
  final ValueChanged<String> onChanged;
  final String initialValue;
  final bool isAutoFocus;
  const InputText({
    super.key,
    required this.hint,
    required this.textInputType,
    required this.onChanged,
    required this.initialValue,
    this.isAutoFocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: isAutoFocus,
      initialValue: initialValue,
      onChanged: (value) => onChanged(value),
      keyboardType: textInputType,
      inputFormatters: textInputType == TextInputType.number
          ? [FilteringTextInputFormatter.digitsOnly]
          : null,
      style: const TextStyle(
        decoration: TextDecoration.none,
        decorationThickness: 0,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: headStyleBigMediumBlackLight,
        filled: true,
        fillColor: BackgroundColorLigh,
        hoverColor: BackgroundColorLigh,
        contentPadding: const EdgeInsets.all(15),
        isDense: true,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    );
  }
}
