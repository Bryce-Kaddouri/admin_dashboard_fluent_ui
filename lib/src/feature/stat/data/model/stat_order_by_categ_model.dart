class StatOrderByDayModel {
  final String day;
  final int orderCount;
  final double amountTotal;

  StatOrderByDayModel({
    required this.day,
    required this.orderCount,
    required this.amountTotal,
  });

  factory StatOrderByDayModel.fromJson(Map<String, dynamic> json) {
    return StatOrderByDayModel(
      day: json['week_day'],
      orderCount: json['order_count'],
      amountTotal: json['amount_total'],
    );
  }
}
