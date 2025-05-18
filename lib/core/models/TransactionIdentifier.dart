class TransactionIdentifier {
  final String hash;

  TransactionIdentifier({required this.hash});

  factory TransactionIdentifier.fromJson(Map<String, dynamic> json) {
    return TransactionIdentifier(
      hash: json['hash'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hash': hash,
    };
  }
}
