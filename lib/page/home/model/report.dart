const List<report> exampleReport = [
  report(
    title: 'Doanh thu',
    iconHeader: 'svg/income_amount.svg',
    content: '100000000',
  ),
  report(
    title: 'Lợi nhuận',
    iconHeader: 'svg/currency_revenue.svg',
    content: '100000000',
  ),
  report(
    title: 'Đơn hàng',
    iconHeader: 'svg/order_repo.svg',
    content: '100000',
  ),
  report(
    title: 'Đơn hàng',
    iconHeader: 'svg/order_repo.svg',
    content: '100000',
  ),
  report(
    title: 'Đơn hàng',
    iconHeader: 'svg/order_repo.svg',
    content: '100000',
  ),
  report(
    title: 'Đơn hàng',
    iconHeader: 'svg/order_repo.svg',
    content: '100000',
  ),
  report(
    title: 'Đơn hàng',
    iconHeader: 'svg/order_repo.svg',
    content: '100000',
  ),
];

class report {
  final String title;
  final String iconHeader;
  final String content;

  const report(
      {required this.title, required this.iconHeader, required this.content});
}
