import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:survey/models/all_survey_model.dart';
import 'package:survey/models/question_model.dart';
import 'package:survey/models/survey_model.dart';
import 'package:survey/pages/survey_answer/question/question_component.dart';
import 'package:survey/pages/survey_answer/question/save_answer.dart';
import 'package:survey/provider/save_provider.dart';
import 'package:survey/services/all_surveys_service.dart';
import 'package:survey/services/question_service.dart';
import 'package:survey/services/survey_service.dart';

class AnswerPage extends StatefulWidget {
  final String surveyId;
  // final String responseId;
  final String userId;
  const AnswerPage(
      {super.key,
      required this.surveyId,
      // required this.responseId,
      required this.userId});

  @override
  State<AnswerPage> createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  List<AllSurvey>? allSurvey;
  List<Survey>? surveys;
  List<QuestionModel>? questions;
  var isLoaded = false;
  // var dataProvider = QuestionProvider();
  AllSurvey? myAllSurvey;
  List<Question>? mySurveysQuestion = [];
  int questionIndex = 0;

  @override
  void initState() {
    super.initState();
    getSurveyData();
  }

  Future<void> getSurveyData() async {
    try {
      surveys = await SurveyRemoteService().getSurvey();
      allSurvey = await AllSurveyRemoteService().getAllSurvey();
      questions = await QuestionRemoteService().getQuestion();

      if (surveys!.isNotEmpty &&
          allSurvey!.isNotEmpty &&
          questions!.isNotEmpty) {
        setState(() {
          isLoaded = true;
        });
        checkSurvey();
      } else {
        print('No surveys or questions found.');
      }
    } catch (e) {
      print('Error loading surveys: $e');
    }
  }

  void checkSurvey() {
    if (allSurvey != null && allSurvey!.isNotEmpty) {
      for (var surveyId in allSurvey!) {
        if (widget.surveyId == surveyId.id) {
          setState(() {
            myAllSurvey = surveyId;
          });
          extractSurvey(myAllSurvey!);
          print(surveyId);
        }
      }
    }
  }

  void extractSurvey(AllSurvey myAllSurvey) {
    if (allSurvey != null && allSurvey!.isNotEmpty) {
      setState(() {
        mySurveysQuestion!.addAll(myAllSurvey.question);
      });
    }
  }

  void nextQuestion() {
    if (questionIndex < mySurveysQuestion!.length - 1) {
      setState(() {
        questionIndex++;
      });
    } else {
      print("No more questions.");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SaveAnswer(
            mySurveysQuestion: mySurveysQuestion,
            surveyId: widget.surveyId,
            userId: widget.userId,
            // responseId: widget.responseId,
          ),
        ),
      );
    }
  }

  void previousQuestion() {
    if (questionIndex > 0) {
      setState(() {
        questionIndex--;
      });
      // print(mySurveysQuestion![questionIndex].questionTypeId.toString());
    } else {
      print("No more questions.");
      // print(mySurveysQuestion![questionIndex].questionTypeId.toString());
    }
  }

  Future<void> _handleRefresh() async {
    await getSurveyData();
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return LiquidPullToRefresh(
      color: Colors.deepPurple,
      backgroundColor: Colors.purple[100],
      animSpeedFactor: 6,
      showChildOpacityTransition: false,
      height: 100,
      onRefresh: _handleRefresh,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomNavigationBar(
          // unselectedIconCol: ,
          unselectedItemColor: const Color(0xffb3b3b3),
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Color(0xff121212)),
            BottomNavigationBarItem(
                icon: Icon(Icons.music_note),
                label: 'Music',
                backgroundColor: Color(0xffb3b3b3)),
            BottomNavigationBarItem(
                icon: Icon(Icons.newspaper),
                label: 'News',
                backgroundColor: Color(0xffb3b3b3)),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_sharp),
                label: 'Settings',
                backgroundColor: Color(0xffb3b3b3)),
          ],
          // GNav(

          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   backgroundColor: const Color.fromARGB(255, 184, 169, 236),
          //   tabBackgroundColor: Colors.black.withOpacity(0.2),
          //   padding: const EdgeInsets.all(15),
          //   tabMargin: const EdgeInsets.only(bottom: 4, right: 14, left: 14),
          //   gap: 0,
          //   tabs: const [
          //     GButton(
          //       icon: Icons.home,
          //       text: 'Home',
          //     ),
          //     GButton(
          //       icon: Icons.favorite,
          //       text: 'Likes',
          //     ),
          //     GButton(
          //       icon: Icons.search_sharp,
          //       text: 'Search',
          //     ),
          //     GButton(
          //       icon: Icons.settings,
          //       text: 'Settings',
          //     ),
          //   ],
        ),
        body: isLoaded && myAllSurvey != null && mySurveysQuestion!.isNotEmpty
            ? Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    color: const Color(0xff121212),
                  ),
                  // Container(
                  //   decoration: const BoxDecoration(
                  //     gradient: LinearGradient(
                  //       begin: Alignment.topCenter,
                  //       end: Alignment.bottomCenter,
                  //       colors: [
                  //         Color.fromARGB(255, 187, 178, 202),
                  //         Color(0xffe7e2fe)
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   decoration: const BoxDecoration(
                  //     shape: BoxShape.rectangle,
                  //     gradient: LinearGradient(
                  //       begin: Alignment.topCenter,
                  //       end: Alignment.bottomCenter,
                  //       colors: [
                  //         Color.fromARGB(255, 57, 16, 122),
                  //         Color.fromARGB(255, 183, 170, 241)
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Positioned(
                  //   top: -80,
                  //   child: Container(
                  //     height: 200,
                  //     width: 200,
                  //     decoration: const BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       gradient: LinearGradient(
                  //         begin: Alignment.center,
                  //         end: AlignmentDirectional.bottomCenter,
                  //         colors: [
                  //           Color.fromARGB(255, 57, 16, 122),
                  //           Color.fromARGB(255, 218, 196, 243)
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  QuestionComponent(
                      question: mySurveysQuestion![questionIndex],
                      surveyId: widget.surveyId,
                      // responseId: widget.responseId,
                      userId: widget.userId,
                      onNext: nextQuestion,
                      onBack: previousQuestion,
                      index: questionIndex,
                      allIndex: mySurveysQuestion!.length),
                  Positioned(
                    top: height * 0.04,
                    left: 0,
                    child: IconButton(
                      onPressed: () {
                        Provider.of<SaveProvider>(context, listen: false)
                            .savedMyAnswers
                            .clear();

                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: height * 0.04,
                    right: 0,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.storm,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            : Container(
                width: double.infinity,
                height: double.infinity,
                color: const Color(0xff121212),
                child: Center(
                  child: SizedBox(
                    child: SizedBox(
                        child: Lottie.asset("assets/refresher.json",
                            width: 100, height: 100)),
                  ),
                ),
              ),
      ),
    );
  }
}
