class MetadataResponse {
  final Metadata metadata;
  final List<SuggestedFee> suggestedFee;

  MetadataResponse({required this.metadata, required this.suggestedFee});

  factory MetadataResponse.fromJson(Map<String, dynamic> json) {
    return MetadataResponse(
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      suggestedFee: (json['suggested_fee'] as List<dynamic>)
          .map((e) => SuggestedFee.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'metadata': metadata.toJson(),
      'suggested_fee': suggestedFee.map((e) => e.toJson()).toList(),
    };
  }
}
