import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/api/model/package/buyer.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/api/model/package/product_package.dart';
import 'package:sales_management/api/model/package/user_package.dart';
import 'package:sales_management/page/product_selector/api/product_selector_api.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class ProductSelectorItem extends StatefulWidget {
  final BeerSubmitData productData;
  final ProductInPackageResponse? productInPackageResponse;
  const ProductSelectorItem({
    super.key,
    required this.productData,
    required this.productInPackageResponse,
  });

  @override
  State<ProductSelectorItem> createState() => _ProductSelectorItemState();
}

class _ProductSelectorItemState extends State<ProductSelectorItem> {
  late final String? imgUrl;
  late final String name;
  late final double price;
  bool processing = false;
  late BeerUnit? unit;
  late ProductInPackageResponse? productInPackage;
  late int unitNo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    unit = widget.productData.listUnit?.firstOrNull;
    imgUrl = widget.productData.getFristLargeImg;
    name = widget.productData.name;
    price = widget.productData.getRealPrice;
    productInPackage = widget.productInPackageResponse;
    unitNo = productInPackage?.numberUnit ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: White,
        boxShadow: unitNo > 0 ? [highShadow] : null,
        borderRadius: defaultBorderRadius,
        border: unitNo > 0 ? tableHighBorder : defaultBorder,
        image: DecorationImage(
          image: (imgUrl == null
              ? const AssetImage(
                  'assets/images/shop_logo.png',
                )
              : NetworkImage(imgUrl!)) as ImageProvider,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
            margin: const EdgeInsets.only(top: 12, left: 6, right: 6),
            decoration: BoxDecoration(
                color: White,
                borderRadius: defaultSquareBorderRadius,
                border: defaultBorder),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: LoadSvg(assetPath: 'svg/minus.svg'),
                  onTap: () => unit != null ? changePackage(unit!, -1) : null,
                ),
                SizedBox(
                  width: 18,
                  child: TextFormField(
                    initialValue: unitNo.toString(),
                    maxLines: 1,
                    style: headStyleLarge,
                    onEditingComplete: () {
                      print('onEditingComplete');
                    },
                    onFieldSubmitted: (value) {
                      print('onFieldSubmitted');
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => unit != null ? changePackage(unit!, 1) : null,
                  child: LoadSvg(
                    assetPath: 'svg/plus.svg',
                    color: MainHighColor,
                  ),
                )
              ],
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 4.0,
                sigmaY: 4.0,
              ),
              child: Container(
                color: Color.fromRGBO(214, 214, 214, 0.40),
                child: Column(
                  children: [
                    Text(
                      name,
                      style: subInfoStyLarge400,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          MoneyFormater.format(price),
                          style: subInfoStyLarge600,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void changePackage(BeerUnit unit, int diff) {
    setState(() {
      processing = true;
    });
    addToPackage(
      ProductPackage(
        id: 0,
        groupId: '',
        buyer: Buyer(
            id: 0,
            regionId: 0,
            districtId: 0,
            wardId: 0,
            realPrice: 0,
            totalPrice: 0,
            shipPrice: 0,
            pointsDiscount: 0,
            groupId: '',
            createat: '',
            deviceId: ''),
        productUnits: [
          UserPackage(
              id: 0,
              groupId: '',
              createat: '',
              packageSecondId: '',
              deviceId: '',
              productSecondId: unit.beer,
              productUnitSecondId: unit.beerUnitSecondId,
              numberUnit: diff,
              price: 0,
              discountAmount: 0,
              discountPercent: 0)
        ],
      ),
    ).then((value) {
      processing = false;
      // widget.item.numberUnit += diff;
      // widget.updateItemCount.call();
    }).catchError(
      (error, stackTrace) {
        setState(() {
          processing = false;
        });
        print("Error: $error");
      },
    );
  }
}
