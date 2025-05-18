import 'package:mochimo_api_client/core/models/Currency.dart';

class NetworkIdentifier {
  final String blockchain;
  final String network;

  NetworkIdentifier({required this.blockchain, required this.network});

  factory NetworkIdentifier.fromJson(Map<String, dynamic> json) {
    return NetworkIdentifier(
      blockchain: json['blockchain'] as String,
      network: json['network'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'blockchain': blockchain,
      'network': network,
    };
  }
}


const Map<String, dynamic> mCMCurrencyJson = {
  'symbol': "MCM",
  'decimals': 9,
};

Currency mCMCurrency = Currency.fromJson(mCMCurrencyJson);

const Map<String, dynamic> networkIdentifierJson = {
  'blockchain': "mochimo",
  'network': "mainnet",
};

NetworkIdentifier networkIdentifier = NetworkIdentifier.fromJson(networkIdentifierJson);

