import 'dart:convert';

class AnswerModel {
  final String id;
  final String answerText;

  AnswerModel({
    required this.id,
    required this.answerText,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      id: json['_id'] as String,
      answerText: json['answer_text'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'answer_text': answerText,
      };
}

class QuestionModel {
  final String id;
  final String surveyID;
  final String questionsTypeID;
  final String questionText;
  final List<AnswerModel>? answers;
  final bool isMandatory;

  QuestionModel({
    required this.id,
    required this.surveyID,
    required this.questionsTypeID,
    required this.questionText,
    this.answers,
    required this.isMandatory,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    String questionsTypeId = json['questions_type_id']['_id'] as String;

    var answersFromJson = json['answers'] as List<dynamic>? ?? [];
    List<AnswerModel> answersList = answersFromJson
        .map((answer) => AnswerModel.fromJson(answer as Map<String, dynamic>))
        .toList();

    return QuestionModel(
      id: json['_id'] as String,
      surveyID: json['surveyID'] as String,
      questionsTypeID: questionsTypeId,
      questionText: json['question_text'] as String,
      answers: answersList.isNotEmpty ? answersList : null,
      isMandatory: json['is_Mandatory'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'surveyID': surveyID,
        'questions_type_id': questionsTypeID,
        'question_text': questionText,
        'answers': answers != null
            ? List<dynamic>.from(answers!.map((x) => x.toJson()))
            : null,
        'is_Mandatory': isMandatory,
      };
}

List<QuestionModel> questionFromJson(String str) {
  final jsonData = json.decode(str) as Map<String, dynamic>;
  return List<QuestionModel>.from(
    jsonData['question']
        .map((x) => QuestionModel.fromJson(x as Map<String, dynamic>)),
  );
}

String questionToJson(List<QuestionModel> data) =>
    json.encode({'question': List<dynamic>.from(data.map((x) => x.toJson()))});
