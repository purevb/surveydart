import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:survey/models/survey_model.dart';
import 'package:survey/provider/save_provider.dart';
import 'package:survey/services/survey_service.dart';
import 'package:survey/pages/survey_answer/question/test.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  // String? token;
  final String id;
  const HomePage(
      {
      // this.token,
      required this.id,
      super.key});

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
      if (surveys != null && surveys!.isNotEmpty) {
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
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // backgroundColor: const Color(0xff121212),
          // tabBackgroundColor: const Color(0xffb3b3b3),
          // padding: const EdgeInsets.all(15),
          // tabMargin: const EdgeInsets.only(bottom: 4, right: 14, left: 14),
          // selectedIndex: currentIndex,
          // onTabChange: (index) {
          //   setState(() {
          //     currentIndex = index;
          //   });
          // },
          // gap: 0,
          // tabs: const [
          //   GButton(
          //     icon: Icons.home,
          //     text: 'Home',
          //     iconColor: Color(0xffb3b3b3),
          //   ),
          //   GButton(
          //     icon: Icons.favorite,
          //     text: 'Likes',
          //     iconColor: Color(0xffb3b3b3),
          //   ),
          //   GButton(
          //     icon: Icons.search_sharp,
          //     text: 'Search',
          //     iconColor: Color(0xffb3b3b3),
          //   ),
          //   GButton(
          //     icon: Icons.settings,
          //     text: 'Settings',
          //     iconColor: Color(0xffb3b3b3),
          //   ),
          // ],
        ),
        body: isLoaded
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
                  //         Color(0xffe7e2fe),
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
                  //         Color.fromARGB(255, 183, 170, 241),
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
                  //           Color.fromARGB(255, 218, 196, 243),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                                        color: Colors.white.withOpacity(0.1))),
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
                                    Text(
                                      surveys![index].surveyName,
                                      style: const TextStyle(fontSize: 18),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
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
