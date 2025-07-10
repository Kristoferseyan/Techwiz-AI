class UserSession {
  final String email;
  final List<int> roleIds;
  final String token;
  final String username;

  UserSession({
    required this.email,
    required this.roleIds,
    required this.token,
    required this.username,
  });
}
