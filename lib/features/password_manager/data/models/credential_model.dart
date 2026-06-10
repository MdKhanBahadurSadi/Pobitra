class CredentialModel {
  final String domain;
  final String username;
  final String password;
  final DateTime createdAt;

  CredentialModel({
    required this.domain,
    required this.username,
    required this.password,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'domain': domain,
      'username': username,
      'password': password,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory CredentialModel.fromJson(Map<String, dynamic> json) {
    return CredentialModel(
      domain: json['domain'],
      username: json['username'],
      password: json['password'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
