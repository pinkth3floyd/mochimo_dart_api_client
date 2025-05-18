
class Currency {
  final String symbol;
  final int decimals;

  Currency({required this.symbol, required this.decimals});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      symbol: json['symbol'] as String,
      decimals: json['decimals'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'decimals': decimals,
    };
  }
}