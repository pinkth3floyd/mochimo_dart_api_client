class MempoolTransactionResponse {
  final MempoolTransaction transaction;
  final Map<String, dynamic>? metadata;

  MempoolTransactionResponse({required this.transaction, this.metadata});

  factory MempoolTransactionResponse.fromJson(Map<String, dynamic> json) {
    return MempoolTransactionResponse(
      transaction: MempoolTransaction.fromJson(json['transaction'] as Map<String, dynamic>),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction': transaction.toJson(),
      'metadata': metadata,
    };
  }
}