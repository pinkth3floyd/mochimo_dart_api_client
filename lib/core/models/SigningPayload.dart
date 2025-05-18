import 'package:mochimo_api_client/core/models/AccountIdentifier.dart';

class SigningPayload {
  final AccountIdentifier accountIdentifier;
  final String hexBytes;
  final String signatureType;

  SigningPayload({required this.accountIdentifier, required this.hexBytes, required this.signatureType});

  factory SigningPayload.fromJson(Map<String, dynamic> json) {
    return SigningPayload(
      accountIdentifier: AccountIdentifier.fromJson(json['account_identifier'] as Map<String, dynamic>),
      hexBytes: json['hex_bytes'] as String,
      signatureType: json['signature_type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_identifier': accountIdentifier.toJson(),
      'hex_bytes': hexBytes,
      'signature_type': signatureType,
    };
  }
}
