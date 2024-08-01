import 'dart:convert';

class Survey {
  String id;
  String surveyName;
  String surveyDescription;
  DateTime surveyStartDate;
  DateTime surveyEndDate;
  bool surveyStatus;
  String imgUrl;

  Survey({
    required this.id,
    required this.surveyName,
    required this.surveyDescription,
    required this.surveyStartDate,
    required this.surveyEndDate,
    required this.surveyStatus,
    required this.imgUrl,
  });

  factory Survey.fromJson(Map<String, dynamic> json) {
    return Survey(
      id: json['_id'] ?? '',
      surveyName: json['survey_name'] ?? '',
      surveyDescription: json['survey_description'] ?? '',
      surveyStartDate: json['survey_start_date'] != null
          ? DateTime.parse(json['survey_start_date'])
          : DateTime.now(),
      surveyEndDate: json['survey_end_date'] != null
          ? DateTime.parse(json['survey_end_date'])
          : DateTime.now(),
      surveyStatus: json['survey_status'] ?? false,
      imgUrl: json['img_url'] ?? '',
    );
  }
}

List<Survey> surveyFromJson(String str) {
  final jsonData = json.decode(str);
  if (jsonData != null && jsonData['surveys'] != null) {
    return List<Survey>.from(
        jsonData['surveys'].map((item) => Survey.fromJson(item)));
  } else {
    return [];
  }
}
