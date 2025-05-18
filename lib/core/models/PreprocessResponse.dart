class PreprocessResponse {
  final PreprocessOptions options;
  final List<RequiredPublicKey> requiredPublicKeys;

  PreprocessResponse({required this.options, required this.requiredPublicKeys});

  factory PreprocessResponse.fromJson(Map<String, dynamic> json) {
    return PreprocessResponse(
      options: PreprocessOptions.fromJson(json['options'] as Map<String, dynamic>),
      requiredPublicKeys: (json['required_public_keys'] as List<dynamic>)
          .map((e) => RequiredPublicKey.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'options': options.toJson(),
      'required_public_keys': requiredPublicKeys.map((e) => e.toJson()).toList(),
    };
  }
}