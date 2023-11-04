import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/component/high_border_container.dart';
import 'package:sales_management/component/rounded_img.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';

class ImgManagement extends StatefulWidget {
  final BeerSubmitData product;
  const ImgManagement({
    super.key,
    required this.product,
  });

  @override
  State<ImgManagement> createState() => _ImgManagementState();
}

class _ImgManagementState extends State<ImgManagement> {
  late final BeerSubmitData product;
  late final List<Images> list_image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    product = widget.product;
    list_image = product.images;
  }

  @override
  Widget build(BuildContext context) {
    final showText = list_image.isEmpty;
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
                    onTap: showText
                        ? () async {
                            final ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(
                                source: ImageSource.gallery);
                            if (image != null) {
                              final img = Images.createEmpty(product);
                              img.content = await image.readAsBytes();
                              img.upload = true;
                              list_image.add(img);
                              setState(() {});
                            }
                          }
                        : null,
                    child: HighBorderContainer(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          LoadSvg(assetPath: 'svg/add_picture.svg'),
                          if (showText) ...[
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Tải ảnh lên',
                              style: headStyleXLargeHigh,
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: showText
                        ? () async {
                            final ImagePicker picker = ImagePicker();
                            final XFile? photo = await picker.pickImage(
                                source: ImageSource.camera,
                                maxWidth: 500,
                                maxHeight: 500);
                            if (photo != null) {
                              final img = Images.createEmpty(product);
                              img.content = await photo.readAsBytes();
                              img.upload = true;
                              list_image.add(img);
                              setState(() {});
                            }
                          }
                        : null,
                    child: HighBorderContainer(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          LoadSvg(assetPath: 'svg/camera_add.svg'),
                          if (showText) ...[
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Chụp ảnh   ',
                              style: headStyleXLargeHigh,
                            ),
                          ]
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
            final img = list_image[index - 1];
            return Rounded_Img(
              images: img,
              onUploadDone: (images) {
                product.replaceImg(img, images);
                setState(() {});
              },
              onDeleteDone: (images) {
                product.deleteImg(images);
                setState(() {});
              },
            );
          },
          separatorBuilder: (context, index) => SizedBox(
                width: 10,
              ),
          itemCount: list_image.length + 1),
    );
  }
}
