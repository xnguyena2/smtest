import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sales_management/api/model/product_unit_cat_pattern.dart';
import 'package:sales_management/component/bottom_bar.dart';
import 'package:sales_management/component/btn/round_btn.dart';
import 'package:sales_management/component/modal/modal_base.dart';
import 'package:sales_management/utils/alter_dialog.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';

class ModalCreateProductUnit extends StatefulWidget {
  final ProductUnitCatPattern productUnitCatPattern;
  final VoidCallbackArg<ProductUnitCatPattern> onDone;
  const ModalCreateProductUnit({
    super.key,
    required this.onDone,
    required this.productUnitCatPattern,
  });

  @override
  State<ModalCreateProductUnit> createState() => _ModalCreateProductUnitState();
}

class _ModalCreateProductUnitState extends State<ModalCreateProductUnit> {
  @override
  Widget build(BuildContext context) {
    final isListEmpty = widget.productUnitCatPattern.items.isEmpty;
    return ModalBase(
      headerTxt: 'Phân loại',
      child: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 400),
            child: SingleChildScrollView(
              child: ColoredBox(
                color: BackgroundColor,
                child: Column(
                  children: [
                    ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final e = widget.productUnitCatPattern.items[index];
                          return _ProductUnitPattern(
                            productUnitCatPatternItem: e,
                            onDelete: (item) {
                              widget.productUnitCatPattern.delteItem(item);
                              setState(() {});
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 8,
                          );
                        },
                        itemCount: widget.productUnitCatPattern.items.length),
                    SizedBox(
                      height: isListEmpty ? 50 : 8,
                    ),
                    if (widget.productUnitCatPattern.items.length < 2)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: RoundBtn(
                          backgroundColor: White,
                          isSelected: true,
                          icon: LoadSvg(
                              assetPath: 'svg/plus_large.svg',
                              width: 20,
                              height: 20),
                          txt: 'Thêm nhóm phân loại',
                          onPressed: () {
                            if (widget.productUnitCatPattern.items.length >=
                                2) {
                              return;
                            }
                            if (widget.productUnitCatPattern.items.isEmpty) {
                              widget.productUnitCatPattern.addItem(
                                  ProductUnitCatPatternItem.categorySample());
                            } else {
                              widget.productUnitCatPattern
                                  .addItem(ProductUnitCatPatternItem.empty());
                            }
                            setState(() {});
                          },
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    SizedBox(
                      height: isListEmpty ? 50 : 0,
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
              widget.onDone(widget.productUnitCatPattern);
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

class _ProductUnitPattern extends StatefulWidget {
  final VoidCallbackArg<ProductUnitCatPatternItem> onDelete;
  final ProductUnitCatPatternItem productUnitCatPatternItem;
  const _ProductUnitPattern({
    super.key,
    required this.productUnitCatPatternItem,
    required this.onDelete,
  });

  @override
  State<_ProductUnitPattern> createState() => _ProductUnitPatternState();
}

class _ProductUnitPatternState extends State<_ProductUnitPattern> {
  late final ProductUnitCatPatternItem productUnitCatPatternItem =
      widget.productUnitCatPatternItem;
  late final TextEditingController unitCateNameTxtController =
      TextEditingController(text: productUnitCatPatternItem.name);
  final FocusNode unitCatNameFocus = FocusNode();
  final TextEditingController unitNameTxtController = TextEditingController();
  final FocusNode unitNameFocus = FocusNode();
  bool isTextEmpty = false;
  bool isAddingNewItem = false;
  String keyEditting = '';

  void resetEditting() {
    isAddingNewItem = false;
    keyEditting = '';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (productUnitCatPatternItem.name.isEmpty) {
      unitCatNameFocus.requestFocus();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    unitCateNameTxtController.dispose();
    unitCatNameFocus.dispose();
    unitNameTxtController.dispose();
    unitNameFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: White,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    IntrinsicWidth(
                      child: TextFormField(
                        controller: unitCateNameTxtController,
                        focusNode: unitCatNameFocus,
                        maxLines: 1,
                        style: headStyleLargeHigh,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                          border: InputBorder.none,
                          hintText: 'Tên nhóm',
                          hintStyle: headStyleLargeBlackVLigh,
                        ),
                        onChanged: (value) {
                          productUnitCatPatternItem.name = value;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: () => unitCatNameFocus.requestFocus(),
                      child: LoadSvg(assetPath: 'svg/edit_pencil_line_01.svg'),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDefaultDialog(
                    context,
                    'Xác nhận xóa!',
                    'Bạn có chắc muốn xóa phân loại này không?',
                    onOk: () {
                      widget.onDelete(productUnitCatPatternItem);
                    },
                    onCancel: () {},
                  );
                },
                child: LoadSvg(assetPath: 'svg/delete.svg'),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Wrap(
            alignment: WrapAlignment.start,
            runSpacing: 12,
            spacing: 12,
            children: [
              ...productUnitCatPatternItem.items.entries.map(
                (e) => _CateNamePattern(
                  name: e.value,
                  onDelete: (name) {
                    productUnitCatPatternItem.removeItemByKey(e.key);
                    resetEditting();
                    setState(() {});
                  },
                  onUpdate: (name) {
                    keyEditting = e.key;
                    isAddingNewItem = true;
                    unitNameTxtController.text = name;
                    unitNameFocus.requestFocus();
                    setState(() {});
                  },
                  isHight: e.key == keyEditting,
                ),
              ),
              if (!isAddingNewItem)
                RoundBtn(
                  backgroundColor: White,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  isSelected: true,
                  isFitContent: true,
                  icon: LoadSvg(
                      assetPath: 'svg/plus_large.svg', width: 20, height: 20),
                  txt: 'Tạo mới',
                  onPressed: () {
                    unitNameFocus.requestFocus();
                    unitNameTxtController.clear();
                    isAddingNewItem = true;
                    keyEditting = '';
                    setState(() {});
                  },
                ),
            ],
          ),
          if (isAddingNewItem) ...[
            SizedBox(
              height: 12,
            ),
            Container(
              padding: EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: isTextEmpty ? Red : Black40),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      focusNode: unitNameFocus,
                      controller: unitNameTxtController,
                      autofocus: true,
                      onTapOutside: (event) {
                        // unitNameFocus.unfocus();
                        // setState(() {});
                      },
                      onChanged: (text) {
                        isTextEmpty = text.isEmpty;
                        String txt = text;
                        // widget.onChanged?.call(txt);
                        setState(() {});
                      },
                      maxLines: 1,
                      style: customerNameBig400,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                        border: InputBorder.none,
                        hintStyle: customerNameBigLight400,
                        hintText: 'Nhập tên loại',
                        suffixIconConstraints: BoxConstraints(
                          maxWidth: 20,
                          maxHeight: 20,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final name = unitNameTxtController.text;
                      if (name.isEmpty) {
                        return;
                      }
                      if (keyEditting.isEmpty) {
                        productUnitCatPatternItem.addItem(name);
                        unitNameTxtController.clear();
                        setState(() {});
                        return;
                      }
                      productUnitCatPatternItem.update(keyEditting, name);
                      resetEditting();
                      setState(() {});
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                          color: TableHighColor,
                          borderRadius: defaultBorderRadius),
                      child: Text(
                        'Lưu',
                        style: headStyleSmallLargeWhite,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CateNamePattern extends StatelessWidget {
  final bool isHight;
  final String name;
  final VoidCallbackArg<String> onDelete;
  final VoidCallbackArg<String> onUpdate;

  const _CateNamePattern({
    super.key,
    required this.name,
    required this.onDelete,
    required this.onUpdate,
    required this.isHight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: defaultBorderRadius,
        color: isHight ? BackgroundHigh : BackgroundColor,
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              onUpdate(name);
            },
            child: Text(
              name,
              style: headStyleBigMediumBlackLight,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          GestureDetector(
            onTap: () {
              onDelete(name);
            },
            child: LoadSvg(assetPath: 'svg/close_circle.svg'),
          ),
        ],
      ),
    );
  }
}
