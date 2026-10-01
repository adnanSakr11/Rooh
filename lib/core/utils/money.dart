double roundMoney(double value) => (value * 100).roundToDouble() / 100;

extension MoneyFormat on double {
  String get asEgp {
    final text = this == roundToDouble()
        ? toStringAsFixed(0)
        : toStringAsFixed(2);
    return 'جنيه $text';
  }
}