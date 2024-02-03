import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sales_management/api/model/package/package_data_response.dart';
import 'package:sales_management/component/adapt/fetch_api.dart';
import 'package:sales_management/component/bottom_bar.dart';
import 'package:sales_management/page/create_store/api/model/store.dart';
import 'package:sales_management/page/print/component/print_bar.dart';
import 'package:sales_management/page/print/component/print_content.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/helper.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:screenshot/screenshot.dart';

class PrintPage extends StatelessWidget {
  const PrintPage({super.key, required this.data});

  final PackageDataResponse data;

  @override
  Widget build(BuildContext context) {
    Widget? printPageContent;
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

              Future<dynamic> ShowCapturedWidget(
                  BuildContext context, Uint8List capturedImage) {
                return showDialog(
                  useSafeArea: false,
                  context: context,
                  builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: Text("Captured widget screenshot"),
                    ),
                    body: Center(child: Image.memory(capturedImage)),
                  ),
                );
              }

              ShowCapturedWidget(context, capturedImage);
            });
          },
          cancel: () {},
        ),
      ),
    );
  }
}
