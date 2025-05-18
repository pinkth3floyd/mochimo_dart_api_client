class ResolveTagResponse {
  final ResolveTagResult result;
  final bool idempotent;

  ResolveTagResponse({required this.result, required this.idempotent});

  factory ResolveTagResponse.fromJson(Map<String, dynamic> json) {
    return ResolveTagResponse(
      result: ResolveTagResult.fromJson(json['result'] as Map<String, dynamic>),
      idempotent: json['idempotent'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result.toJson(),
      'idempotent': idempotent,
    };
  }
}