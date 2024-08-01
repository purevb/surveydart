// Dart side
import 'dart:convert';

class AnswerOptionModel {
  final String id;
  final String questoinId;
  final String responseId;
  final String userChoice;
  final String userId;

  AnswerOptionModel(
      {required this.id,
      required this.questoinId,
      required this.responseId,
      required this.userChoice,
      required this.userId});

  factory AnswerOptionModel.fromJson(Map<String, dynamic> json) {
    return AnswerOptionModel(
        id: json['_id'],
        questoinId: json['question_id'],
        responseId: json['response_id'],
        userChoice: json['user_choice'],
        userId: json['user_id']);
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'question_id': questoinId,
      'response_id': responseId,
      'user_choice': userChoice,
      'user_id': userId
    };
  }
}

List<AnswerOptionModel> typeFromJson(String str) {
  final jsonData = json.decode(str);
  return List<AnswerOptionModel>.from(
      jsonData["answers_options"].map((x) => AnswerOptionModel.fromJson(x)));
}

String typeToJson(List<AnswerOptionModel> data) => json.encode(
    {"answers_options": List<dynamic>.from(data.map((x) => x.toJson()))});
