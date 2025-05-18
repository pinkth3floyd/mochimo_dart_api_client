import 'package:mochimo_api_client/core/models/Operation.dart';
import 'package:mochimo_api_client/core/models/TransactionIdentifier.dart';

class MempoolTransaction {
  final TransactionIdentifier transactionIdentifier;
  final List<Operation> operations;
  final Map<String, dynamic>? metadata;

  MempoolTransaction({required this.transactionIdentifier, required this.operations, this.metadata});

  factory MempoolTransaction.fromJson(Map<String, dynamic> json) {
    return MempoolTransaction(
      transactionIdentifier: TransactionIdentifier.fromJson(json['transaction_identifier'] as Map<String, dynamic>),
      operations: (json['operations'] as List<dynamic>)
          .map((e) => Operation.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction_identifier': transactionIdentifier.toJson(),
      'operations': operations.map((e) => e.toJson()).toList(),
      'metadata': metadata,
    };
  }
}
