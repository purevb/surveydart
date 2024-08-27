import 'dart:convert';

class User {
  final String id;
  final String email;
  final String password;
  final List<String>? participatedSurveys;

  User(
      {required this.id,
      required this.email,
      required this.password,
      this.participatedSurveys});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      email: json['email'],
      password: json['password'],
      participatedSurveys: json['participatedSurveys'] != null
          ? List<String>.from(json['participatedSurveys'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'password': password,
      'participatedSurveys': participatedSurveys,
    };
  }
}

List<User> userFromJson(String str) {
  final jsonData = json.decode(str);
  return List<User>.from(jsonData["user"].map((x) => User.fromJson(x)));
}

String userToJson(List<User> data) =>
    json.encode({"user": List<dynamic>.from(data.map((x) => x.toJson()))});
