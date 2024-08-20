import 'dart:convert';

class AnswerOptionModel {
  final String surveyId;
  final String questionId;
  final String responseId;
  final List<String> userChoice;
  final String userId;

  AnswerOptionModel({
    required this.surveyId,
    required this.questionId,
    required this.responseId,
    required this.userChoice,
    required this.userId,
  });

  factory AnswerOptionModel.fromJson(Map<String, dynamic> json) {
    return AnswerOptionModel(
      surveyId: json['survey_id'],
      questionId: json['question_id'],
      responseId: json['response_id'],
      userChoice: List<String>.from(json['user_choice']),
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'survey_id': surveyId,
      'question_id': questionId,
      'response_id': responseId,
      'user_choice': userChoice,
      'user_id': userId,
    };
  }
}

List<AnswerOptionModel> typeFromJson(String str) {
  final jsonData = json.decode(str);
  return List<AnswerOptionModel>.from(
      jsonData["aoption"].map((x) => AnswerOptionModel.fromJson(x)));
}

String typeToJson(List<AnswerOptionModel> data) =>
    json.encode({"aoption": List<dynamic>.from(data.map((x) => x.toJson()))});
