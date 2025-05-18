class NetworkIdentifier {
  final String blockchain;
  final String network;

  NetworkIdentifier({required this.blockchain, required this.network});

  factory NetworkIdentifier.fromJson(Map<String, dynamic> json) {
    return NetworkIdentifier(
      blockchain: json['blockchain'] as String,
      network: json['network'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'blockchain': blockchain,
      'network': network,
    };
  }
}
