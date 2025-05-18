
import 'package:mochimo_api_client/core/models/TransactionIdentifier.dart';

class TransactionSubmitResponse {
  final TransactionIdentifier transactionIdentifier;

  TransactionSubmitResponse({required this.transactionIdentifier});

  factory TransactionSubmitResponse.fromJson(Map<String, dynamic> json) {
    return TransactionSubmitResponse(
      transactionIdentifier: TransactionIdentifier.fromJson(json['transaction_identifier'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction_identifier': transactionIdentifier.toJson(),
    };
  }
}