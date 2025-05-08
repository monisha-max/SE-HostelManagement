class User {
  final String loginId;
  final String password;
  User({required this.loginId, required this.password});
  Map<String, dynamic> toJson() => {
        'loginId': loginId,
        'password': password,
      };
}
