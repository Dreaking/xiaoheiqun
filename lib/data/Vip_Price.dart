class Price {
  final String money;
  final String month;

  final int type;

  Price({this.money, this.month, this.type});

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
        money: json['money'] as String,
        month: json['month'] as String,
        type: json["type"] as int);
  }
}
