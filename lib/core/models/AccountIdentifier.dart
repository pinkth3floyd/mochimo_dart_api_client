class AccountIdentifier {
  final String address;

  AccountIdentifier({required this.address});

  factory AccountIdentifier.fromJson(Map<String, dynamic> json) {
    return AccountIdentifier(
      address: json['address'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
    };
  }
}