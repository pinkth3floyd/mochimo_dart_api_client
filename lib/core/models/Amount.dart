

class Amount {
  final String value;
  final Currency currency;

  Amount({required this.value, required this.currency});

  factory Amount.fromJson(Map<String, dynamic> json) {
    return Amount(
      value: json['value'] as String,
      currency: Currency.fromJson(json['currency'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'currency': currency.toJson(),
    };
  }
}