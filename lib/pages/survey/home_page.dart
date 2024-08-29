import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:survey/models/survey_model.dart';
import 'package:survey/models/user_model.dart';
import 'package:survey/provider/save_provider.dart';
import 'package:survey/services/survey_service.dart';
import 'package:survey/pages/survey_answer/question/test.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  // String? token;
  late User user;

  final String id;
  HomePage({required this.user, required this.id, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UniqueKey _refreshKey = UniqueKey();
  final beginDateController = TextEditingController();
  final endDateController = TextEditingController();
  late SharedPreferences prefs;
  late String email;
  String? name;
  List<Survey>? surveys;
  var isLoaded = false;
  late String surveyID;
  late DateTime beginDate;
  String responseId = '';
  var saveProvider = SaveProvider();

  @override
  void initState() {
    super.initState();
    // Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token!);
    // email = jwtDecodedToken['email'];
    responseId = "";
    getSurveyData();
    _handleRefresh();
  }

  Future<void> getSurveyData() async {
    try {
      surveys = await SurveyRemoteService().getSurvey();
      if (surveys!.isNotEmpty) {
        setState(() {
          isLoaded = true;
          // saveProvider.addSurvey(surveys!);
        });
      } else {
        print('No surveys found.');
      }
    } catch (e) {
      print('Error loading surveys: $e');
    }
  }

  Future<void> _handleRefresh() async {
    await getSurveyData();
    return await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> saveResponse() async {
    prefs = await SharedPreferences.getInstance();
    var reqBody = {
      "survey_id": surveyID,
      "user_id": widget.id,
      "begin_date": beginDate.toIso8601String(),
      "end_date":
          endDateController.text.isEmpty ? null : endDateController.text,
    };

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3106/api/response'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        setState(() {
          responseId = responseData['response']['_id'];
          Provider.of<SaveProvider>(context, listen: false).responseId =
              responseId;
        });

        print('Response saved successfully');
      } else {
        print('Failed to save Response');
        print(response.body);
      }
    } catch (e) {
      print('Error saving response: $e');
    }
  }

  int currentIndex = 0;
  Future<void> _dialogAnswerBuilder(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          backgroundColor: Color(0xff121212),
          title: Text(
            "You cannot participate again",
            style: TextStyle(color: Color(0xffb3b3b3)),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return LiquidPullToRefresh(
      key: _refreshKey,
      onRefresh: _handleRefresh,
      color: const Color(0xff121212),
      backgroundColor: Colors.white,
      animSpeedFactor: 3,
      showChildOpacityTransition: false,
      height: 100,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff121212),
          foregroundColor: const Color(0xffb3b3b3),
          title: const Text(
            "AllSurveys",
            style: TextStyle(color: Color(0xffb3b3b3)),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomNavigationBar(
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
        ),
        body: isLoaded
            ? Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    color: const Color(0xff121212),
                  ),
                  Positioned(
                    top: height * 0.01,
                    child: SizedBox(
                      width: width,
                      height: height * 0.75,
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1 / 1.1,
                        ),
                        itemCount: surveys!.length,
                        itemBuilder: (context, index) {
                          if (widget.user.particatedSurveys!.any((surveyList) =>
                              surveyList.contains(surveys![index].id))) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: GestureDetector(
                                onTap: () => _dialogAnswerBuilder(context),
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.1),
                                          offset: const Offset(0, 2),
                                          blurRadius: 4.0,
                                          spreadRadius: 0.0,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color:
                                              Colors.white.withOpacity(0.1))),
                                  padding: const EdgeInsets.all(25),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Image.network(
                                          surveys![index].imgUrl,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        height: height * 0.02,
                                        width: width * 0.4,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: const Text(
                                          "Participated",
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Text(
                                        surveys![index].surveyName,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Color(0xffb3b3b3)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    surveyID = surveys![index].id;
                                    beginDate = DateTime.now();
                                  });
                                  saveResponse();
                                  Provider.of<SaveProvider>(context,
                                          listen: false)
                                      .surveyId = surveys![index].id;

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AnswerPage(
                                        surveyId: surveys![index].id,
                                        userId: widget.id,
                                      ),
                                    ),
                                  );
                                  // saveProvider.questionId = widget.id;
                                  // saveProvider.responseId = responseId;
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.1),
                                          offset: const Offset(0, 2),
                                          blurRadius: 4.0,
                                          spreadRadius: 0.0,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color:
                                              Colors.white.withOpacity(0.1))),
                                  padding: const EdgeInsets.all(25),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Image.network(
                                          surveys![index].imgUrl,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        height: height * 0.02,
                                        width: width * 0.4,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: const Text(
                                          "New",
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Text(
                                        surveys![index].surveyName,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Color(0xffb3b3b3)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        },
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
