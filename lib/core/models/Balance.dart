class Balance {
  final Currency currency;
  final String value;

  Balance({required this.currency, required this.value});

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      currency: Currency.fromJson(json['currency'] as Map<String, dynamic>),
      value: json['value'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currency': currency.toJson(),
      'value': value,
    };
  }
}