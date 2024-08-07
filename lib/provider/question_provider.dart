import 'package:flutter/material.dart';
import 'package:survey/models/all_survey_model.dart';
import 'package:survey/models/question_model.dart';
import 'package:survey/models/survey_model.dart';

class QuestionProvider extends ChangeNotifier {
  List<AllSurvey>? allSurvey = [];
  List<Survey>? survey = [];
  List<QuestionModel>? questions = [];
  // List<Question>? surveyQuestions = [];
  int questionIndex = 0;

  void addSurvey(List<Survey> surveys) {
    survey?.addAll(surveys);
    notifyListeners();
  }

  void addQuestion(List<QuestionModel> newQuestions) {
    questions?.addAll(newQuestions);
    notifyListeners();
  }

  void addAllSurvey(List<AllSurvey> newSurveys) {
    allSurvey?.addAll(newSurveys);
    notifyListeners();
  }

  void saveAllAnswer() {}
}
