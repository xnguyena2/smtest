import 'package:sales_management/component/btn/base_btn.dart';
import 'package:sales_management/utils/constants.dart';

class DeleteBtn extends BaseBtn {
  const DeleteBtn({
    super.key,
    required super.txt,
    required super.padding,
    required super.onPressed,
    super.backgroundColor = Red,
    super.isSmallTxt = false,
  });
}
