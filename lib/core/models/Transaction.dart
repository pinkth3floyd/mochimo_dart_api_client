
import 'package:mochimo_api_client/core/models/Operation.dart';
import 'package:mochimo_api_client/core/models/TransactionIdentifier.dart';

class Transaction {
  final TransactionIdentifier transactionIdentifier;
  final List<Operation> operations;

  Transaction({required this.transactionIdentifier, required this.operations});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      transactionIdentifier: TransactionIdentifier.fromJson(json['transaction_identifier'] as Map<String, dynamic>),
      operations: (json['operations'] as List<dynamic>)
          .map((e) => Operation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction_identifier': transactionIdentifier.toJson(),
      'operations': operations.map((e) => e.toJson()).toList(),
    };
  }
}