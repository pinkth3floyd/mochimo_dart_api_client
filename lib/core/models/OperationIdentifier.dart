
class OperationIdentifier {
  final int index;

  OperationIdentifier({required this.index});

  factory OperationIdentifier.fromJson(Map<String, dynamic> json) {
    return OperationIdentifier(
      index: json['index'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
    };
  }
}