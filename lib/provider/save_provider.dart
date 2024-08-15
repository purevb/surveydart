import 'package:flutter/material.dart';
import 'package:survey/models/answer_options_model.dart';
import 'package:survey/models/survey_model.dart';

class SaveProvider extends ChangeNotifier {
  List<Survey>? allSurvey = [];
  List<String>? savedMyAnswer = [];
  List<AnswerOptionModel>? saveResponse = [];
  void addSurvey(List<Survey> surveys) {
    allSurvey?.addAll(surveys);
    notifyListeners();
  }

  void saveAnswers(List<String> answers) {
    savedMyAnswer?.addAll(answers);
    notifyListeners();
  }
}
