import 'package:sales_management/page/account/api/model/token.dart';

class ListTokensResult {
  ListTokensResult({
    required this.listResult,
  });
  late final List<Token> listResult;
  ListTokensResult.fromJson(Map<String, dynamic> json) {
    listResult =
        List.from(json['list_result']).map((e) => Token.fromJson(e)).toList();
  }

  Token? getActiveToken() {
    if (listResult.isEmpty) {
      return null;
    }
    int index = listResult.indexWhere((element) => element.status == 'ACTIVE');
    if (index < 0) {
      return null;
    }
    return listResult[index];
  }
}
