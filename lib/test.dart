import 'package:flutter/material.dart';
import 'package:survey/models/all_survey_model.dart';
import 'package:survey/models/survey_model.dart';
import 'package:survey/provider/question_provider.dart';
import 'package:survey/services/all_surveys_service.dart';
import 'package:survey/services/survey_service.dart';

class AnswerPage extends StatefulWidget {
  final String id;
  const AnswerPage({super.key, required this.id});
  @override
  State<AnswerPage> createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  List<AllSurvey>? allSurvey;
  List<Survey>? surveys;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getSurveyData();
  }

  Future<void> getSurveyData() async {
    try {
      surveys = await SurveyRemoteService().getSurvey();
      allSurvey = await AllSurveyRemoteService().getAllSurvey();
      if (surveys != null &&
          allSurvey != null &&
          surveys!.isNotEmpty &&
          allSurvey!.isNotEmpty) {
        setState(() {
          isLoaded = true;
        });
      } else {
        print('No surveys or questions found.');
      }
    } catch (e) {
      print('Error loading surveys: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 39, 12, 87),
                Color.fromARGB(255, 56, 22, 114)
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xffa36cfe), Color(0xffe7e2fe)],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromARGB(255, 57, 16, 122), Color(0xffe7e2fe)],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: height * 0, right: width * 0.05, left: width * 0.05),
            width: width * 0.9,
            height: height * 0.85,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18), color: Colors.white),
            child: Text(""),
          ),
          Positioned(
            top: height * 0.01,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://img.freepik.com/free-vector/abstract-business-professional-background-banner-design-multipurpose_1340-16863.jpg?size=626&ext=jpg&ga=GA1.1.1570753395.1722498379&semt=ais_hybrid',
                height: height * 0.29,
                width: width * 0.85,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
