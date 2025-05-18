class RequiredPublicKey {
  final String address;

  RequiredPublicKey({required this.address});

  factory RequiredPublicKey.fromJson(Map<String, dynamic> json) {
    return RequiredPublicKey(
      address: json['address'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
    };
  }
}