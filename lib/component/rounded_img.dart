import 'package:flutter/material.dart';
import 'package:sales_management/api/model/beer_submit_data.dart';
import 'package:sales_management/page/product_info/api/product_info_api.dart';
import 'package:sales_management/utils/constants.dart';
import 'package:sales_management/utils/svg_loader.dart';
import 'package:sales_management/utils/typedef.dart';

class Rounded_Img extends StatefulWidget {
  final Images images;
  final VoidCallbackArg<Images> onUploadDone;
  const Rounded_Img({
    super.key,
    required this.images,
    required this.onUploadDone,
  });

  @override
  State<Rounded_Img> createState() => _Rounded_ImgState();
}

class _Rounded_ImgState extends State<Rounded_Img> {
  bool isUploading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isUploading = widget.images.upload == true && widget.images.content != null;
    if (isUploading) {
      uploadFile('/beer/admin/${groupID}/${'hello'}/img/upload',
              widget.images.content!,
              onUploadProgress: onUploadProgress)
          .then((value) {
        value.content = widget.images.content;
        widget.onUploadDone(value);
        isUploading = false;
        widget.images.upload = false;
        setState(() {});
      });
    }
  }

  double progress = 0;
  void onUploadProgress(double value) {
    progress = value / 1.5;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    late final ImageProvider<Object> img;
    if (widget.images.thumbnail.isNotEmpty) {
      img = NetworkImage(widget.images.thumbnail);
    } else if (widget.images.content != null) {
      img = MemoryImage(widget.images.content!);
    } else {
      img = AssetImage("assets/images/shop_logo.png");
    }
    return Stack(alignment: Alignment.center, children: [
      Container(
        width: 100.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: img,
          ),
          borderRadius: defaultBorderRadius,
        ),
      ),
      Positioned(
        right: 5,
        top: 5,
        child: LoadSvg(
          assetPath: 'svg/close_circle.svg',
          color: White,
        ),
      ),
      if (isUploading)
        CircularProgressIndicator(
          value: progress,
        ),
    ]);
  }
}
