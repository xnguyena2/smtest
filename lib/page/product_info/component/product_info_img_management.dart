import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sales_management/api/http.dart';
import 'package:sales_management/component/high_border_container.dart';
import 'package:sales_management/component/rounded_img.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class ImgManagement extends StatelessWidget {
  const ImgManagement({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      height: 127,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
// Pick an image.
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        uploadFile(
                            '/beer/admin/${groupID}/${'hello'}/img/upload',
                            image);
                      }
                    },
                    child: HighBorderContainer(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          LoadSvg(assetPath: 'svg/add_picture.svg'),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Tải ảnh lên',
                            style: headStyleXLargeHigh,
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
// Capture a photo.
                      final XFile? photo =
                          await picker.pickImage(source: ImageSource.camera);
                      if (photo != null) {
                        uploadFile(
                            '/beer/admin/${groupID}/${'hello'}/img/upload',
                            photo);
                      }
                    },
                    child: HighBorderContainer(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          LoadSvg(assetPath: 'svg/camera_add.svg'),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Chụp ảnh   ',
                            style: headStyleXLargeHigh,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
            return Stack(children: [
              Rounded_Img(),
              Positioned(
                right: 5,
                top: 5,
                child: LoadSvg(
                  assetPath: 'svg/close_circle.svg',
                  color: White,
                ),
              )
            ]);
          },
          separatorBuilder: (context, index) => SizedBox(
                width: 10,
              ),
          itemCount: 2),
    );
  }
}
