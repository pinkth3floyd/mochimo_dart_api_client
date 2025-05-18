class BlockIdentifier {
  final int? index;
  final String? hash;

  BlockIdentifier({this.index, this.hash});

  factory BlockIdentifier.fromJson(Map<String, dynamic> json) {
    return BlockIdentifier(
      index: json['index'] as int?,
      hash: json['hash'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'hash': hash,
    };
  }
}