import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/btn/approve_btn.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/component/text_round.dart';
import 'package:sales_management/page/address/api/address_api.dart';
import 'package:sales_management/page/address/api/model/address_data.dart';
import 'package:sales_management/page/address/api/model/list_buyer.dart';
import 'package:sales_management/page/address/reciver_info.dart';
import 'package:sales_management/page/product_selector/component/provider_discount.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/debouncer.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';

class CustomerInfo extends StatefulWidget {
  final PackageDataResponse data;
  const CustomerInfo({
    super.key,
    required this.data,
  });

  @override
  State<CustomerInfo> createState() => _CustomerInfoState();
}

class _CustomerInfoState extends State<CustomerInfo> {
  late bool isDone = widget.data.isDone;
  @override
  Widget build(BuildContext context) {
    BuyerData? buyer = widget.data.buyer;
    String? regionTextFormat = buyer?.getAddressFormat();
    int point = isDone
        ? 0
        : widget.data.point != 0
            ? 0
            : buyer?.getTotalPoint ?? 0;

    return DefaultPaddingContainer(
      child: Column(
        children: [
          SizedBox(
            height: 11,
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: borderColor,
                child: CircleAvatar(
                  backgroundColor: White,
                  radius: 24,
                  child: LoadSvg(assetPath: 'svg/profile_round.svg'),
                ),
              ),
              SizedBox(
                width: 7,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              buyer?.reciverFullname ?? 'Khách lẻ',
                              style: customerNameBig,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            if (buyer != null) ...[
                              TextRound(
                                txt: '${buyer.getTotalPoint} điểm',
                                isHigh: true,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                            ],
                            LoadSvg(
                                assetPath: 'svg/copy.svg',
                                width: 15,
                                height: 15),
                          ],
                        ),
                        if (!isDone && buyer != null)
                          GestureDetector(
                            onTap: () {
                              widget.data.cleanBuyer();
                              setState(() {});
                            },
                            child: LoadSvg(assetPath: 'svg/close_circle.svg'),
                          ),
                      ],
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      buyer?.phoneNumber ?? '',
                      style: headStyleSemiLargeLigh500,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: isDone
                ? null
                : () async {
                    if (widget.data.buyer == null) {
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: 'Đóng',
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return FindBuyerDialog(
                            onSelected: (addressData) {
                              widget.data.updateBuyer(addressData);
                              setState(() {});
                            },
                          );
                        },
                        transitionBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(0.0, 1.0);
                          const end = Offset.zero;
                          final tween = Tween(begin: begin, end: end);
                          final offsetAnimation = animation.drive(tween);
                          // return child;
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      );
                      return;
                    }
                    AddressData addressData =
                        AddressData.fromBuyerData(widget.data.buyer);
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReciverInfo(
                          addressData: addressData,
                          done: (data) {
                            addressData = data;
                            widget.data.updateBuyer(addressData);
                          },
                          delete: () {},
                          isEdit: false,
                        ),
                      ),
                    );
                    setState(() {});
                  },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: borderColor),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      regionTextFormat ?? 'Chọn khách hàng',
                      style: customerNameBigLigh,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (point > 0) ...[
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Đổi ${point} điểm thành: ${point * 10}k chiết khấu?',
                  style: headStyleSemiLargeHigh500,
                ),
                ApproveBtn(
                  isActiveOk: true,
                  txt: 'Áp dụng',
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  onPressed: () {
                    widget.data.applyPoint(point, point * 10000);
                    context.read<DiscountProvider>().updateValue =
                        point * 10000;
                    setState(() {});
                  },
                )
              ],
            ),
          ],
          SizedBox(
            height: 11,
          ),
        ],
      ),
    );
  }
}

class FindBuyerDialog extends StatefulWidget {
  const FindBuyerDialog({
    super.key,
    required this.onSelected,
  });

  final VoidCallbackArg<AddressData> onSelected;

  @override
  State<FindBuyerDialog> createState() => _FindBuyerDialogState();
}

class _FindBuyerDialogState extends State<FindBuyerDialog> {
  final TextEditingController txtControler = TextEditingController();
  bool isEmpty = true;
  late Debouncer searchDebouncer = Debouncer(milliseconds: 300);
  ListBuyerResult? loadingListBuyer = null;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: White,
      surfaceTintColor: White,
      title: Text(
        'Tìm kiếm khách hàng',
        textAlign: TextAlign.center,
      ),
      titlePadding: EdgeInsets.only(
        top: 16,
      ),
      titleTextStyle: headStyleXLargeSemiBold,
      content: SizedBox(
        width: 200,
        child: ListView(
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Black40),
                ),
              ),
              child: TextFormField(
                autofocus: true,
                controller: txtControler,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (text) {
                  isEmpty = text.isEmpty;
                  if (isEmpty) {
                    loadingListBuyer?.listResult.clear();
                    setState(() {});
                    return;
                  }
                  searchDebouncer.run(() {
                    searchUser(text).then((value) {
                      loadingListBuyer = value;
                      setState(() {});
                    });
                  });
                  setState(() {});
                },
                maxLines: 1,
                style: customerNameBig400,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  border: InputBorder.none,
                  hintStyle: customerNameBigLight400,
                  hintText: 'Số điện thoại',
                  suffixIconConstraints: BoxConstraints(
                    maxWidth: 20,
                    maxHeight: 20,
                  ),
                  suffixIcon: isEmpty
                      ? null
                      : GestureDetector(
                          onTap: () {
                            txtControler.text = '';
                            isEmpty = true;
                            loadingListBuyer?.listResult.clear();
                            setState(() {});
                          },
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: LoadSvg(assetPath: 'svg/close_circle.svg'),
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                // FocusManager.instance.primaryFocus?.unfocus();
                Navigator.pop(context);
                AddressData addressData = AddressData.fromBuyerData(null);
                addressData.phoneNumber = txtControler.text;
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReciverInfo(
                      addressData: addressData,
                      done: (data) {
                        widget.onSelected(data);
                      },
                      delete: () {},
                      isEdit: false,
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tạo mới${isEmpty ? '' : ' "${txtControler.text}"'}',
                    style: headStyleSmallLargeHigh,
                  ),
                  LoadSvg(
                    assetPath: 'svg/plus_circle_fill.svg',
                  ),
                ],
              ),
            ),
            if (loadingListBuyer != null &&
                loadingListBuyer!.listResult.isNotEmpty) ...[
              SizedBox(
                height: 15,
              ),
              Divider(),
              SizedBox(
                height: 6,
              ),
              ...loadingListBuyer!.listResult.map(
                (buyer) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: GestureDetector(
                    onTap: () {
                      final addressData = AddressData.fromBuyerData(buyer);
                      widget.onSelected(addressData);
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.black,
                          foregroundImage: AssetImage(
                            "assets/images/shop_logo.png",
                          ),
                        ),
                        SizedBox(
                          width: 9,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  buyer.reciverFullname ?? 'Khách lẻ',
                                  style: headStyleSemiLarge500,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                TextRound(
                                  txt: '${buyer.getTotalPoint} điểm',
                                  isHigh: true,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              buyer.phoneNumber ?? '',
                              style: headStyleSemiLargeLigh500,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
