import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/component/bottom_bar.dart';
import 'package:sales_management/page/create_store/api/model/store.dart';
import 'package:sales_management/page/print/component/print_bar.dart';
import 'package:sales_management/page/print/component/print_content.dart';
import 'package:sales_management/page/printer/printer_page.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/helper.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class PrintPage extends StatelessWidget {
  const PrintPage({super.key, required this.data});

  final PackageDataResponse data;

  @override
  Widget build(BuildContext context) {
    Widget? printPageContent;
    createPrintPage(VoidCallbackArg<Uint8List> onCapture) {
      ScreenshotController screenshotController = ScreenshotController();
      screenshotController
          .captureFromLongWidget(
        pixelRatio: 1.5,
        InheritedTheme.captureAll(
          context,
          Material(
            child: SizedBox(
              width: 400,
              child: ColoredBox(
                color: White,
                child: printPageContent,
              ),
            ),
          ),
        ),
        delay: Duration(milliseconds: 100),
        context: context,
      )
          .then((capturedImage) {
        // Handle captured image
        onCapture(capturedImage);
      });
    }

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: White,
        appBar: const PrintPageBar(),
        body: FetchAPI<Store?>(
          future: getStoreInfo(),
          successBuilder: (store) {
            printPageContent = PrintContent(
              data: data,
              store: store,
            );
            return SingleChildScrollView(
              child: printPageContent,
            );
          },
        ),
        bottomNavigationBar: BottomBar(
          headCancelbtn: LoadSvg(assetPath: 'svg/send.svg'),
          headOkbtn: LoadSvg(assetPath: 'svg/print_white.svg'),
          cancelBtnTxt: 'Gửi hóa đơn',
          okBtnTxt: 'In hóa đơn',
          isCancelMode: false,
          done: () {
            createPrintPage((capturedImage) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrinterPage(
                    capturedImage: capturedImage,
                  ),
                ),
              );
            });
          },
          cancel: () {
            createPrintPage((capturedImage) {
              SnackBar getResultSnackBar(ShareResult result) {
                return SnackBar(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Share result: ${result.status}"),
                      if (result.status == ShareResultStatus.success)
                        Text("Shared to: ${result.raw}")
                    ],
                  ),
                );
              }

              void _onShareXFileFromAssets(
                  BuildContext context, Uint8List capturedImage) async {
                final box = context.findRenderObject() as RenderBox?;
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                final shareResult = await Share.shareXFiles(
                  [
                    XFile.fromData(
                      capturedImage,
                      name: 'reciepts.png',
                      mimeType: 'image/png',
                    ),
                  ],
                  sharePositionOrigin:
                      box!.localToGlobal(Offset.zero) & box.size,
                );

                scaffoldMessenger.showSnackBar(getResultSnackBar(shareResult));
              }

              _onShareXFileFromAssets(context, capturedImage);
            });
          },
        ),
      ),
    );
  }
}
