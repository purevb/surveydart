import 'package:flutter/material.dart';
import 'package:survey/models/all_survey_model.dart';
import 'package:survey/models/survey_model.dart';

class SaveProvider extends ChangeNotifier {
  List<Survey>? allSurvey = [];
  void addSurvey(List<Survey> surveys) {
    allSurvey?.addAll(surveys);
    notifyListeners();
  }
}
