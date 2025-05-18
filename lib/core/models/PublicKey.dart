class PublicKey {
  final String hexBytes;
  final String curveType;

  PublicKey({required this.hexBytes, required this.curveType});

  factory PublicKey.fromJson(Map<String, dynamic> json) {
    return PublicKey(
      hexBytes: json['hex_bytes'] as String,
      curveType: json['curve_type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hex_bytes': hexBytes,
      'curve_type': curveType,
    };
  }
}