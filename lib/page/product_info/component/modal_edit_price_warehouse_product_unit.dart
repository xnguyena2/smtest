import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/api/model/product_unit_cat_pattern.dart';
import 'package:sales_management/component/bottom_bar.dart';
import 'package:sales_management/component/btn/round_btn.dart';
import 'package:sales_management/component/input_field_with_header.dart';
import 'package:sales_management/component/modal/modal_base.dart';
import 'package:sales_management/component/textfield/editable_text_form_field.dart';
import 'package:sales_management/utils/alter_dialog.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';
import 'package:sales_management/utils/utils.dart';

class ModalEditPriceWarehouseProductUnit extends StatefulWidget {
  final List<BeerUnit> listBeerUnit;
  final VoidCallbackArg<List<BeerUnit>> onDone;
  const ModalEditPriceWarehouseProductUnit({
    super.key,
    required this.onDone,
    required this.listBeerUnit,
  });

  @override
  State<ModalEditPriceWarehouseProductUnit> createState() =>
      _ModalEditPriceWarehouseProductUnitState();
}

class _ModalEditPriceWarehouseProductUnitState
    extends State<ModalEditPriceWarehouseProductUnit> {
  late List<BeerUnit> listBeerUnit = widget.listBeerUnit;

  @override
  Widget build(BuildContext context) {
    return ModalBase(
      headerTxt: 'Thông tin phân loại',
      child: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 400),
            child: SingleChildScrollView(
              child: ColoredBox(
                color: BackgroundColor,
                child: Column(
                  children: [
                    ColoredBox(
                      color: White,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        child: RoundBtn(
                          backgroundColor: White,
                          isSelected: true,
                          txt: 'Sửa hàng loạt giá, tồn kho',
                          onPressed: () {
                            setState(() {});
                          },
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _EditableTable(
                      listBeerUnit: listBeerUnit,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          BottomBar(
            done: () {
              widget.onDone(listBeerUnit);
              Navigator.pop(context);
            },
            cancel: () {
              Navigator.pop(context);
            },
            okBtnTxt: 'Tạo',
          ),
        ],
      ),
    );
  }
}

class _EditableTable extends StatelessWidget {
  final List<BeerUnit> listBeerUnit;
  const _EditableTable({
    super.key,
    required this.listBeerUnit,
  });

  List<List<Widget>> generateGridData() {
    final listRow = listBeerUnit
        .map((e) => [
              header(e.name, MainAxisAlignment.start,
                  padding_left: 12, isHeader: false),
              value(
                e.price,
                (value) {
                  e.price = tryParseMoney(value);
                },
              ),
              value(
                e.buyPrice,
                (value) {
                  e.buyPrice = tryParseMoney(value);
                },
              ),
              SizedBox(),
            ])
        .toList();
    listRow.insert(
      0,
      [
        header('PHÂ LOẠI', MainAxisAlignment.start, padding_left: 12),
        header('GIÁ BÁN', MainAxisAlignment.center),
        header('GÁI VỐN', MainAxisAlignment.center),
        header('TỒN KHO', MainAxisAlignment.end, padding_right: 12)
      ],
    );
    return listRow;
  }

  Widget header(String txt, MainAxisAlignment alignment,
          {double padding_left = 0,
          double padding_right = 0,
          bool isHeader = true}) =>
      Container(
        height: 50,
        color: White,
        margin: const EdgeInsets.all(0.5),
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: alignment,
              children: [
                SizedBox(
                  width: padding_left,
                ),
                Text(
                  txt,
                  style: isHeader
                      ? headStyleBigMediumBlackLight
                      : headStyleBigMedium,
                ),
                SizedBox(
                  width: padding_right,
                ),
              ],
            ),
          ],
        ),
      );

  Widget value(double intValue, VoidCallbackArg<String> onUpdate) {
    TextEditingController textEditingController =
        TextEditingController(text: MoneyFormater.format(intValue));
    return Container(
      height: 50,
      color: White,
      margin: const EdgeInsets.all(0.5),
      padding: const EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: textEditingController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CurrencyInputFormatter(),
            ],
            textInputAction: TextInputAction.done,
            maxLines: 1,
            style: headStyleBigMedium,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.zero,
              isDense: true,
              border: InputBorder.none,
            ),
            onChanged: onUpdate,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = generateGridData();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [for (var row in data) row[0]],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [for (var row in data) row[1]],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [for (var row in data) row[2]],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [for (var row in data) row[3]],
          ),
        )
      ],
    );
  }
}
