
class ResolveTagResult {
  final String address;
  final String amount;

  ResolveTagResult({required this.address, required this.amount});

  factory ResolveTagResult.fromJson(Map<String, dynamic> json) {
    return ResolveTagResult(
      address: json['address'] as String,
      amount: json['amount'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'amount': amount,
    };
  }
}