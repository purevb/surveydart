import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:survey/models/survey_model.dart';
import 'package:survey/provider/save_provider.dart';
import 'package:survey/services/survey_service.dart';
import 'package:survey/pages/survey_answer/question/test.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  // String? token;
  final String id;
  HomePage(
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
  late String responseId;
  var saveProvider = SaveProvider();
  @override
  void initState() {
    super.initState();
    // Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token!);
    // email = jwtDecodedToken['email'];
    getSurveyData();
    _handleRefresh();
  }

  Future<void> getSurveyData() async {
    try {
      surveys = await SurveyRemoteService().getSurvey();
      if (surveys != null && surveys!.isNotEmpty) {
        setState(() {
          isLoaded = true;
          saveProvider.addSurvey(surveys!);
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

  void saveResponse() async {
    prefs = await SharedPreferences.getInstance();
    var reqBody = {
      "survey_id": surveyID,
      "user_id": widget.id,
      "begin_date": beginDate.toIso8601String(),
      "end_date":
          endDateController.text.isEmpty ? null : endDateController.text,
    };

    var response = await http.post(
      Uri.parse('http://10.0.2.2:3106/api/response'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      setState(() {
        responseId = responseData['response']['_id'];
      });

      print('Response saved successfully');
    } else {
      print('Failed to save Response');
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    int currentIndex = 0;
    return LiquidPullToRefresh(
      key: _refreshKey,
      onRefresh: _handleRefresh,
      color: Colors.deepPurple,
      backgroundColor: Colors.purple[100],
      animSpeedFactor: 3,
      showChildOpacityTransition: false,
      height: 100,
      child: Scaffold(
        bottomNavigationBar: GNav(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          backgroundColor: const Color.fromARGB(255, 184, 169, 236),
          tabBackgroundColor: Colors.black.withOpacity(0.2),
          padding: const EdgeInsets.all(15),
          tabMargin: const EdgeInsets.only(bottom: 4, right: 14, left: 14),
          selectedIndex: currentIndex,
          onTabChange: (index) {
            setState(() {
              currentIndex = index;
            });
          },
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
                          Color(0xffe7e2fe),
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
                          Color.fromARGB(255, 183, 170, 241),
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
                            Color.fromARGB(255, 218, 196, 243),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: height * 0.18,
                    child: SizedBox(
                      width: width,
                      height: height * 0.7,
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1 / 1,
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AnswerPage(
                                      surveyId: surveys![index].id,
                                      userId: widget.id,
                                      responseId: responseId,
                                    ),
                                  ),
                                );
                                // saveProvider.questionId = widget.id;
                                // saveProvider.responseId = responseId;
                              },
                              child: Container(
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
                  Positioned(
                    right: width * 0.04,
                    top: height * 0.04,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    left: width * 0.04,
                    top: height * 0.04,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: height * 0.14,
                    child: const Text(
                      "All Surveys",
                      style: TextStyle(fontSize: 24, fontFamily: 'Roboto'),
                    ),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
