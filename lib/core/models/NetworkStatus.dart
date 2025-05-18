import 'package:mochimo_api_client/core/models/BlockIdentifier.dart';


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


