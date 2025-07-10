class LoginResponseModel {
  final String email;
  final List<int> roles;
  final String token;
  final String username;

  LoginResponseModel({
    required this.email,
    required this.roles,
    required this.token,
    required this.username,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      email: json['email'],
      roles: (json['roleIds'] as List<dynamic>? ?? [])
          .map((e) => e as int)
          .toList(),
      token: json['token'],
      username: json['username'],
    );
  }
}
