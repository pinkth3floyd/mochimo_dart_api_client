import 'package:mochimo_api_client/core/models/BlockIdentifier.dart';
import 'package:mochimo_api_client/core/models/Transaction.dart';

class Block {
  final BlockIdentifier blockIdentifier;
  final BlockIdentifier parentBlockIdentifier;
  final int timestamp;
  final List<Transaction> transactions;

  Block({
    required this.blockIdentifier,
    required this.parentBlockIdentifier,
    required this.timestamp,
    required this.transactions,
  });

  factory Block.fromJson(Map<String, dynamic> json) {
    return Block(
      blockIdentifier: BlockIdentifier.fromJson(json['block_identifier'] as Map<String, dynamic>),
      parentBlockIdentifier: BlockIdentifier.fromJson(json['parent_block_identifier'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as int,
      transactions: (json['transactions'] as List<dynamic      >)
          .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'block_identifier': blockIdentifier.toJson(),
      'parent_block_identifier': parentBlockIdentifier.toJson(),
      'timestamp': timestamp,
      'transactions': transactions.map((e) => e.toJson()).toList(),
    };
  }
}
