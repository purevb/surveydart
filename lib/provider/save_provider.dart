import 'package:flutter/material.dart';
import 'package:survey/models/answer_options_model.dart';
import 'package:survey/models/survey_model.dart';

class SaveProvider extends ChangeNotifier {
  List<Survey> allSurvey = [];
  Map<String, List<String>> savedMyAnswers = {};
  List<AnswerOptionModel> saveResponse = [];
  String questionIds = "";
  String userId = "";
  String surveyId = "";
  String responseId = "";

  void addSurvey(List<Survey> surveys) {
    allSurvey.addAll(surveys);
    notifyListeners();
  }

  void saveAnswers(String questionId, List<String> answers) {
    bool hasNewAnswer = false;

    if (!savedMyAnswers.containsKey(questionId)) {
      savedMyAnswers[questionId] = [];
    }
    for (String answer in answers) {
      if (!savedMyAnswers[questionId]!.contains(answer)) {
        savedMyAnswers[questionId]!.add(answer);
        hasNewAnswer = true;
      }
    }

    if (hasNewAnswer) {
      notifyListeners();
    }
  }

  // void saveMyResponse() {
  //   List<AnswerOptionModel> savedOptions = [];

  //   savedMyAnswers.forEach((questionId, answers) {
  //     AnswerOptionModel aoption = AnswerOptionModel(
  //       questionId: questionId,
  //       responseId: responseId,
  //       userId: userId,
  //       userChoice: answers,
  //     );
  //     savedOptions.add(aoption);
  //   });
  //   saveResponse.addAll(savedOptions);
  //   notifyListeners();
  // }
}
