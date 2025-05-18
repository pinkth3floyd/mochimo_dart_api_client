class PreprocessOptions {
  final int blockToLive;
  final String changePk;
  final String sourceAddr;

  PreprocessOptions({required this.blockToLive, required this.changePk, required this.sourceAddr});

  factory PreprocessOptions.fromJson(Map<String, dynamic> json) {
    return PreprocessOptions(
      blockToLive: json['block_to_live'] as int,
      changePk: json['change_pk'] as String,
      sourceAddr: json['source_addr'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'block_to_live': blockToLive,
      'change_pk': changePk,
      'source_addr': sourceAddr,
    };
  }
}
