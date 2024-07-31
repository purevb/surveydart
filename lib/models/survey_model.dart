import 'dart:convert';

class Survey {
  final String id;
  String surveyName;
  String surveyDescription;
  DateTime surveyStartDate;
  DateTime surveyEndDate;
  bool surveyStatus;
  String imgUrl;

  Survey(
      {required this.id,
      required this.surveyName,
      required this.surveyDescription,
      required this.surveyStartDate,
      required this.surveyEndDate,
      required this.surveyStatus,
      required this.imgUrl});

  factory Survey.fromJson(Map<String, dynamic> json) {
    return Survey(
      id: json['_id'],
      surveyName: json['survey_name'],
      surveyDescription: json['survey_description'],
      surveyStartDate: DateTime.parse(json['survey_start_date']),
      surveyEndDate: DateTime.parse(json['survey_end_date']),
      surveyStatus: json['survey_status'],
      imgUrl: json['img_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'survey_name': surveyName,
      'survey_description': surveyDescription,
      'survey_start_date': surveyStartDate.toIso8601String(),
      'survey_end_date': surveyEndDate.toIso8601String(),
      'survey_status': surveyStatus,
    };
  }
}

List<Survey> surveyFromJson(String str) {
  final jsonData = json.decode(str);
  return List<Survey>.from(jsonData["surveys"].map((x) => Survey.fromJson(x)));
}

String surveyToJson(List<Survey> data) =>
    json.encode({"surveys": List<dynamic>.from(data.map((x) => x.toJson()))});
