class User {
  final String login;
  final String avatarUrl;

  User({required this.login, required this.avatarUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json['login'],
      avatarUrl: json['avatar_url'],
    );
  }
}
