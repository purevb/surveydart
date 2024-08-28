import 'dart:convert';

class User {
  final String id;
  final String email;
  final String password;
  final String v;
  final List<String>? particatedSurveys;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.v,
    this.particatedSurveys,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      v: json['v'] ?? '',
      particatedSurveys: json['particatedSurveys'] != null
          ? List<String>.from(json['particatedSurveys'])
          : [],
    );
  }
}

List<User> userFromJson(String str) {
  final jsonData = json.decode(str);
  print(jsonData);
  return List<User>.from(jsonData["user"].map((x) => User.fromJson(x)));
}
