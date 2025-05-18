class SuggestedFee {
  final String value;
  final Currency currency;

  SuggestedFee({required this.value, required this.currency});

  factory SuggestedFee.fromJson(Map<String, dynamic> json) {
    return SuggestedFee(
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