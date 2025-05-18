
import 'package:mochimo_api_client/core/models/AccountIdentifier.dart';
import 'package:mochimo_api_client/core/models/Amount.dart';
import 'package:mochimo_api_client/core/models/OperationIdentifier.dart';

class Operation {
  final OperationIdentifier operationIdentifier;
  final String type;
  final String status;
  final AccountIdentifier account;
  final Amount? amount;
  final Map<String, dynamic>? metadata;

  Operation({
    required this.operationIdentifier,
    required this.type,
    required this.status,
    required this.account,
    this.amount,
    this.metadata,
  });

  factory Operation.fromJson(Map<String, dynamic> json) {
    return Operation(
      operationIdentifier: OperationIdentifier.fromJson(json['operation_identifier'] as Map<String, dynamic>),
      type: json['type'] as String,
      status: json['status'] as String,
      account: AccountIdentifier.fromJson(json['account'] as Map<String, dynamic>),
      amount: json['amount'] == null ? null : Amount.fromJson(json['amount'] as Map<String, dynamic>),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'operation_identifier': operationIdentifier.toJson(),
      'type': type,
      'status': status,
      'account': account.toJson(),
      'amount': amount?.toJson(),
      'metadata': metadata,
    };
  }
}