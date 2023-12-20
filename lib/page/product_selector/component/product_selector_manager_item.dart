import 'package:flutter/material.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/utils/constants.dart';

class ProductManagerItem extends StatelessWidget {
  final BeerSubmitData productData;
  const ProductManagerItem({
    super.key,
    required this.productData,
  });

  @override
  Widget build(BuildContext context) {
    final imgUrl = productData.getFristLargeImg;
    final name = productData.get_show_name;
    final price = productData.getRealPrice;
    final isAvariable = productData.isAvariable;

    return Container(
      decoration: BoxDecoration(
        color: White,
        borderRadius: defaultBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ConstrainedBox(
          constraints: BoxConstraints.tight(Size.fromHeight(70)),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    border: defaultBorder,
                    color: BackgroundColor,
                    borderRadius: defaultBorderRadius,
                    image: DecorationImage(
                      image: (imgUrl == null
                          ? const AssetImage(
                              'assets/images/product.png',
                            )
                          : NetworkImage(imgUrl)) as ImageProvider,
                    ),
                  ),
                  child: !isAvariable
                      ? Container(
                          decoration: BoxDecoration(
                            color: White70,
                            borderRadius: defaultBorderRadius,
                          ),
                          child: Center(
                            child: Text(
                              'Hết hàng',
                              style: subInfoStyMedium400,
                            ),
                          ),
                        )
                      : null,
                ),
              ),
              SizedBox(
                width: 18,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      name,
                      style: headStyleSemiLarge500,
                    ),
                    Text(
                      MoneyFormater.format(price),
                      style: isAvariable
                          ? headStyleSemiLargeHigh500
                          : headStyleSemiLargeLigh500,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
