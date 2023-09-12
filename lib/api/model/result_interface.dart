import 'beer_submit_data.dart';

abstract class ResultInterface {
  // ResultInterface fromJson(Map<String, dynamic> json);

  // Not DRY, but this works.
  static T fromJson<T extends ResultInterface>(Map<String, dynamic> json) {
    switch (T) {
      case BeerSubmitData:
        return BeerSubmitData.fromJson(json) as T;
      default:
        throw UnimplementedError();
    }
  }

  Map<String, dynamic> toJson();
}
