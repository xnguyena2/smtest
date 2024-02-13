class CountOrderByDate {
  CountOrderByDate({
    required this.count_return,
    required this.revenue_return,
    required this.count_cancel,
    required this.revenue_cancel,
  });

  late final int count_return;
  late final double revenue_return;

  late final int count_cancel;
  late final double revenue_cancel;

  CountOrderByDate.fromJson(Map<String, dynamic> json) {
    count_return = json['count_return'] as int;
    revenue_return = json['revenue_return'] as double;
    count_cancel = json['count_cancel'] as int;
    revenue_cancel = json['revenue_cancel'] as double;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['count_return'] = count_return;
    _data['revenue_return'] = revenue_return;
    _data['count_cancel'] = count_cancel;
    _data['revenue_cancel'] = revenue_cancel;
    return _data;
  }
}
