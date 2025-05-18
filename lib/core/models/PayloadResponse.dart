import 'package:mochimo_api_client/core/models/SigningPayload.dart';

class PayloadsResponse {
  final String unsignedTransaction;
  final List<SigningPayload> payloads;

  PayloadsResponse({required this.unsignedTransaction, required this.payloads});

  factory PayloadsResponse.fromJson(Map<String, dynamic> json) {
    return PayloadsResponse(
      unsignedTransaction: json['unsigned_transaction'] as String,
      payloads: (json['payloads'] as List<dynamic>)
          .map((e) => SigningPayload.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unsigned_transaction': unsignedTransaction,
      'payloads': payloads.map((e) => e.toJson()).toList(),
    };
  }
}