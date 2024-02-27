import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/component/btn/round_btn.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/component/layout/default_padding_container.dart';
import 'package:sales_management/component/modal/simple_modal.dart';
import 'package:sales_management/page/product_info/component/modal_create_product_unit.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class ProductCreateCategory extends StatelessWidget {
  final BeerSubmitData product;
  const ProductCreateCategory({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultPaddingContainer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phân loại',
          style: headStyleXLarge,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Tạo phân loại cho sản phẩm như kích thước, màu sắc,...',
          style: subStyleMediumNormalLight,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: RoundBtn(
                  isSelected: true,
                  icon: LoadSvg(
                      assetPath: 'svg/plus_large.svg', width: 20, height: 20),
                  txt: 'Thêm phân loại',
                  onPressed: () async {
                    showDefaultModal(
                      context: context,
                      content: ModalCreateProductUnit(
                          onDone: (category) {}, product: product),
                    );
                    // await Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ProductSelectorPage(
                    //       packageDataResponse: data.clone(),
                    //       onUpdated: (PackageDataResponse) {
                    //         data.updateListProductItem(PackageDataResponse);
                    //       },
                    //     ),
                    //   ),
                    // );
                    // context.read<ProductProvider>().justRefresh();
                    // setState(() {});
                  },
                  padding: const EdgeInsets.symmetric(vertical: 10)),
            ),
          ],
        )
      ],
    ));
  }
}
