import 'package:mochimo_api_client/core/models/BlockIdentifier.dart';
import 'package:mochimo_api_client/core/models/Currency.dart';
import 'package:mochimo_api_client/core/models/NetworkIdentifier.dart';

class NetworkStatus {
  final BlockIdentifier currentBlockIdentifier;
  final BlockIdentifier genesisBlockIdentifier;
  final int currentBlockTimestamp;

  NetworkStatus({
    required this.currentBlockIdentifier,
    required this.genesisBlockIdentifier,
    required this.currentBlockTimestamp,
  });

  factory NetworkStatus.fromJson(Map<String, dynamic> json) {
    return NetworkStatus(
      currentBlockIdentifier: BlockIdentifier.fromJson(json['current_block_identifier'] as Map<String, dynamic>),
      genesisBlockIdentifier: BlockIdentifier.fromJson(json['genesis_block_identifier'] as Map<String, dynamic>),
      currentBlockTimestamp: json['current_block_timestamp'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_block_identifier': currentBlockIdentifier.toJson(),
      'genesis_block_identifier': genesisBlockIdentifier.toJson(),
      'current_block_timestamp': currentBlockTimestamp,
    };
  }
}


// const Map<String, dynamic> mCMCurrencyJson = {
//   'symbol': "MCM",
//   'decimals': 9,
// };

// const Currency mCMCurrency = Currency.fromJson(mCMCurrencyJson);

// const Map<String, dynamic> networkIdentifierJson = {
//   'blockchain': "mochimo",
//   'network': "mainnet",
// };

// const NetworkIdentifier networkIdentifier = NetworkIdentifier.fromJson(networkIdentifierJson);

