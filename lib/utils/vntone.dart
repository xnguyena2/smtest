String removeVNTones(String str) {
  str = str.replaceAll(RegExp(r'à|à|á|ạ|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ'), "a");
  str = str.replaceAll(RegExp(r'è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ'), "e");
  str = str.replaceAll(RegExp(r'ì|ì|í|ị|ỉ|ĩ'), "i");
  str = str.replaceAll(RegExp(r'ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ'), "o");
  str = str.replaceAll(RegExp(r'ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ'), "u");
  str = str.replaceAll(RegExp(r'ỳ|ý|ỵ|ỷ|ỹ'), "y");
  str = str.replaceAll(RegExp(r'đ'), "d");
  str = str.replaceAll(RegExp(r'À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ'), "A");
  str = str.replaceAll(RegExp(r'È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ'), "E");
  str = str.replaceAll(RegExp(r'Ì|Ì|Í|Ị|Ỉ|Ĩ'), "I");
  str = str.replaceAll(RegExp(r'Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ'), "O");
  str = str.replaceAll(RegExp(r'Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ'), "U");
  str = str.replaceAll(RegExp(r'Ỳ|Ý|Ỵ|Ỷ|Ỹ'), "Y");
  str = str.replaceAll(RegExp(r'Đ'), "D");
  // Some system encode vietnamese combining accent as individual utf-8 characters
  // Một vài bộ encode coi các dấu mũ, dấu chữ như một kí tự riêng biệt nên thêm hai dòng này
  str = str.replaceAll(RegExp(r'/\u0300|\u0301|\u0303|\u0309|\u0323/g'),
      ""); // ̀ ́ ̃ ̉ ̣  huyền, sắc, ngã, hỏi, nặng
  str = str.replaceAll(
      RegExp(r'/\u02C6|\u0306|\u031B/g'), ""); // ˆ ̆ ̛  Â, Ê, Ă, Ơ, Ư
  // Remove extra spaces
  // Bỏ các khoảng trắng liền nhau
  str = str.replaceAll(RegExp(r'/ + /g'), " ");
  str = str.trim();
  // Remove punctuations
  // Bỏ dấu câu, kí tự đặc biệt
  str = str.replaceAll(
      RegExp(
          r'''/!|@|%|\^|\*|\(|\)|\+|\=|\<|\>|\?|\/|,|\.|\:|\;|\'|\"|\&|\#|\[|\]|~|\$|_|`|-|{|}|\||\\/g'''),
      " ");
  return str;
}
