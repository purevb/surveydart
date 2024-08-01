import 'package:flutter/material.dart';
import 'package:survey/models/all_survey_model.dart';
import 'package:survey/models/survey_model.dart';
import 'package:survey/services/all_surveys_service.dart';
import 'package:survey/services/survey_service.dart';

class QuestionProvider extends ChangeNotifier {
  List<AllSurvey>? allSurvey = [];
  List<Survey>? survey = [];
  List<Question> questions = [];

  void addSurvey(AllSurvey surveys) {
    allSurvey?.add(surveys);
    notifyListeners();
  }
}
