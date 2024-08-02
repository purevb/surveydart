import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:survey/models/all_survey_model.dart';
import 'package:survey/models/question_model.dart';
import 'package:survey/models/survey_model.dart';
import 'package:survey/pages/survey_answer/answer/answer_component.dart';
import 'package:survey/provider/question_provider.dart';
import 'package:survey/services/all_surveys_service.dart';
import 'package:survey/services/question_service.dart';
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
  List<QuestionModel>? questions;
  var isLoaded = false;
  var dataProvider = QuestionProvider();
  QuestionModel? mySurvey;

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

      if (surveys != null &&
          allSurvey != null &&
          surveys!.isNotEmpty &&
          allSurvey!.isNotEmpty &&
          questions != null &&
          questions!.isNotEmpty) {
        setState(() {
          isLoaded = true;
          dataProvider.addSurvey(surveys!);
          dataProvider.addQuestion(questions!);
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
    if (dataProvider.questions != null && dataProvider.questions!.isNotEmpty) {
      for (var question in dataProvider.questions!) {
        if (widget.id == question.surveyID) {
          setState(() {
            mySurvey = question;
          });
          print(mySurvey);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomNavigationBar: GNav(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        backgroundColor: Color.fromARGB(255, 184, 169, 236),
        tabBackgroundColor: Colors.black.withOpacity(0.2),
        padding: const EdgeInsets.all(15),
        tabMargin: const EdgeInsets.only(bottom: 4, right: 14, left: 14),
        gap: 0,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.favorite,
            text: 'Likes',
          ),
          GButton(
            icon: Icons.search_sharp,
            text: 'Search',
          ),
          GButton(
            icon: Icons.settings,
            text: 'Settings',
          ),
        ],
      ),
      body: isLoaded
          ? Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 187, 178, 202),
                        Color(0xffe7e2fe)
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 57, 16, 122),
                        Color.fromARGB(255, 183, 170, 241)
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -80,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.center,
                        end: AlignmentDirectional.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 57, 16, 122),
                          Color.fromARGB(255, 218, 196, 243)
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: height * 0.15,
                      right: width * 0.05,
                      left: width * 0.05,
                      bottom: height * 0.01),
                  width: width * 0.9,
                  height: height * 0.85,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        'https://img.freepik.com/free-vector/abstract-business-professional-background-banner-design-multipurpose_1340-16863.jpg?size=626&ext=jpg&ga=GA1.1.1570753395.1722498379&semt=ais_hybrid',
                                        height: height * 0.25,
                                        width: width * 0.85,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    if (mySurvey != null)
                                      Text(
                                        mySurvey!.questionText,
                                        style: const TextStyle(
                                            fontSize: 27,
                                            fontFamily: 'Roboto',
                                            color: Colors.white),
                                      ),
                                  ],
                                ),
                                if (mySurvey != null)
                                  AnswerTile(
                                      answer: mySurvey!.answers!
                                          .map((e) => e.answerText)
                                          .toList()),
                                if (mySurvey != null)
                                  Text(mySurvey!.questionText)
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print("Back tapped");
                                },
                                child: Container(
                                  width: width * 0.2,
                                  height: height * 0.06,
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xffEEE4B1),
                                            Color(0xffC8ACD6)
                                          ]),
                                      borderRadius: BorderRadius.circular(16)),
                                  child: const Column(
                                    children: [
                                      Icon(Icons
                                          .keyboard_double_arrow_left_sharp),
                                      Text(
                                        "Back",
                                        style: TextStyle(fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print("Questions tapped");
                                },
                                child: Container(
                                  width: width * 0.2,
                                  height: height * 0.06,
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xffEEE4B1),
                                            Color(0xffC8ACD6)
                                          ]),
                                      borderRadius: BorderRadius.circular(16)),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.person),
                                      Text(
                                        "Questions",
                                        style: TextStyle(fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print("Audience tapped");
                                },
                                child: Container(
                                  width: width * 0.2,
                                  height: height * 0.06,
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xffEEE4B1),
                                            Color(0xffC8ACD6)
                                          ]),
                                      borderRadius: BorderRadius.circular(16)),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.people),
                                      Text(
                                        "Audience",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w100,
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print("Next tapped");
                                },
                                child: Container(
                                  width: width * 0.2,
                                  height: height * 0.06,
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xffEEE4B1),
                                            Color(0xffC8ACD6)
                                          ]),
                                      borderRadius: BorderRadius.circular(16)),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons
                                          .keyboard_double_arrow_right_sharp),
                                      Text(
                                        "Next",
                                        style: TextStyle(fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: height * 0.04,
                  left: 0,
                  child: IconButton(
                    onPressed: () {
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
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
