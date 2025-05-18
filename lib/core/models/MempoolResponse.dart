import 'package:mochimo_api_client/core/models/TransactionIdentifier.dart';

class MempoolResponse {
  final List<TransactionIdentifier> transactionIdentifiers;

  MempoolResponse({required this.transactionIdentifiers});

  factory MempoolResponse.fromJson(Map<String, dynamic> json) {
    return MempoolResponse(
      transactionIdentifiers: (json['transaction_identifiers'] as List<dynamic>)
          .map((e) => TransactionIdentifier.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction_identifiers': transactionIdentifiers.map((e) => e.toJson()).toList(),
    };
  }
}