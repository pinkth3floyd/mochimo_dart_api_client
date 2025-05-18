class BalanceResponse {
  final List<Balance> balances;
  final BlockIdentifier blockIdentifier;

  BalanceResponse({required this.balances, required this.blockIdentifier});

  factory BalanceResponse.fromJson(Map<String, dynamic> json) {
    return BalanceResponse(
      balances: (json['balances'] as List<dynamic>)
          .map((e) => Balance.fromJson(e as Map<String, dynamic>))
          .toList(),
      blockIdentifier: BlockIdentifier.fromJson(json['block_identifier'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'balances': balances.map((e) => e.toJson()).toList(),
      'block_identifier': blockIdentifier.toJson(),
    };
  }
}