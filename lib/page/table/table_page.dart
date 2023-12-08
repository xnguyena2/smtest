import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/component/modal/simple_modal.dart';
import 'package:sales_management/page/table/api/model/area_table.dart';
import 'package:sales_management/page/table/api/table_api.dart';
import 'package:sales_management/page/table/component/modal_create_area.dart';
import 'package:sales_management/page/table/component/table_body.dart';
import 'package:sales_management/utils/snack_bar.dart';
import 'package:sales_management/utils/storage_provider.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';

import '../../utils/constants.dart';
import 'component/table_selector_bar.dart';

typedef onTableSelected = VoidCallbackArg<TableDetailData>;

class TablePage extends StatefulWidget {
  final VoidCallbackArg<TableDetailData> done;
  const TablePage({super.key, required this.done});

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  bool isEditting = false;
  late Future<ListAreDataResult> loadingListArea;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadingListArea = getAllTable(groupID);
  }

  @override
  Widget build(BuildContext context) {
    final addNewArea = () {
      final areaData = AreaData(
          id: 0, groupId: groupID, createat: null, areaId: '', listTable: []);
      showDefaultModal(
        context: context,
        content: ModalCreateArea(
          area: areaData,
          onDone: (newArea) {
            updateAreaData(areaData).then(
              (value) {
                context.read<StorageProvider>().listAreaData?.add(value);
                showNotification(context, 'Thêm vùng thành công!');
                setState(() {});
              },
            ).onError(
              (error, stackTrace) {
                showAlert(context, 'Không thể cập nhật!');
              },
            );
          },
        ),
      );
    };

    return SafeArea(
      child: Scaffold(
        appBar: TableSelectorBar(
          onBackPressed: () {
            if (isEditting) {
              isEditting = false;
              setState(() {});
              return;
            }
            Navigator.pop(context);
          },
          onEditting: isEditting,
          onEdit: () {
            isEditting = true;
            setState(() {});
          },
        ),
        body: FetchAPI<ListAreDataResult>(
          future: loadingListArea,
          successBuilder: (data) {
            context.read<StorageProvider>().setListArea = data.listResult;
            return TableBody(
              data: data,
              done: widget.done,
              isEditting: isEditting,
              createNewArea: addNewArea,
            );
          },
        ),
        floatingActionButton: isEditting
            ? FloatingActionButton.extended(
                elevation: 2,
                backgroundColor: MainHighColor,
                shape: RoundedRectangleBorder(
                  borderRadius: floatBottomBorderRadius,
                ),
                onPressed: addNewArea,
                icon: LoadSvg(
                  assetPath: 'svg/plus_large_width_2.svg',
                  color: White,
                ),
                label: Text(
                  'Thêm khu vực',
                  style: customerNameBigWhite600,
                ),
              )
            : null,
      ),
    );
  }
}
