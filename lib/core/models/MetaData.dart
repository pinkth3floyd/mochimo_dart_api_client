class Metadata {
  final int blockToLive;
  final String changePk;
  final int sourceBalance;

  Metadata({required this.blockToLive, required this.changePk, required this.sourceBalance});

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      blockToLive: json['block_to_live'] as int,
      changePk: json['change_pk'] as String,
      sourceBalance: json['source_balance'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'block_to_live': blockToLive,
      'change_pk': changePk,
      'source_balance': sourceBalance,
    };
  }
}