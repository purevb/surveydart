// Dart side
import 'dart:convert';

class Response {
  final String id;
  final String surveyId;
  final String userId;
  final DateTime beginDate;
  final DateTime endDate;

  Response(
      {required this.id,
      required this.surveyId,
      required this.userId,
      required this.beginDate,
      required this.endDate});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
        id: json['_id'],
        surveyId: json['survey_id'],
        userId: json['user_id'],
        beginDate: json['begin_date'],
        endDate: json['end_date']);
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'survey_id': surveyId,
      'user_id': userId,
      'begin_date': beginDate,
      'end_date': endDate
    };
  }
}

List<Response> typeFromJson(String str) {
  final jsonData = json.decode(str);
  return List<Response>.from(
      jsonData["response"].map((x) => Response.fromJson(x)));
}

String typeToJson(List<Response> data) =>
    json.encode({"response": List<dynamic>.from(data.map((x) => x.toJson()))});
