import 'dart:convert';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:survey/models/survey_model.dart';
import 'package:survey/pages/survey/home_page.dart';
import 'package:survey/provider/save_provider.dart';
import 'package:survey/services/survey_service.dart';
import 'package:survey/pages/survey_answer/question/test.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NewHomePage extends StatefulWidget {
  // String? token;
  final String id;
  const NewHomePage(
      {
      // this.token,
      required this.id,
      super.key});

  @override
  State<NewHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<NewHomePage> {
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

  int currentIndex = 0;

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
      child: SafeArea(
        child: Scaffold(
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
          ),
          body: isLoaded
              ? SingleChildScrollView(
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: height * 1.15,
                        color: const Color(0xff121212),
                      ),
                      Positioned(
                          top: height * 0.36,
                          left: -5,
                          child: Row(
                            children: [
                              SizedBox(
                                child: Row(
                                  children: [
                                    Lottie.asset(
                                      width: 60,
                                      height: 60,
                                      "assets/star.json",
                                    ),
                                    const Text("Super",
                                        style: TextStyle(
                                            color: Color(0xffb3b3b3))),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: width * 0.68,
                              ),
                              SizedBox(
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage(id: widget.id)));
                                      },
                                      child: const Text(
                                        "All ->",
                                        style: TextStyle(
                                          color: Color(0xffb3b3b3),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                      Positioned(
                        top: height * 0.42,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 11),
                          width: width,
                          height: height * 0.2,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: surveys!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
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
                                },
                                child: Container(
                                    padding: const EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.white.withOpacity(0.1),
                                            offset: const Offset(0, 2),
                                            blurRadius: 4.0,
                                            spreadRadius: 1.0,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color:
                                                Colors.white.withOpacity(0.2))),
                                    width: width * 0.3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.network(
                                          surveys![index].imgUrl,
                                          width: width * 0.2,
                                          height: height * 0.1,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          surveys![index].surveyName,
                                          style: const TextStyle(
                                              color: Color(0xffb3b3b3)),
                                        ),
                                        Text(
                                          surveys![index].surveyDescription,
                                          style: const TextStyle(
                                              color: Color(0xffb3b3b3)),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    )),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                width: 10,
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                          top: height * 0.61,
                          left: -5,
                          child: Row(
                            children: [
                              SizedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          Lottie.asset(
                                            width: 60,
                                            height: 60,
                                            "assets/bonus2.json",
                                          ),
                                          const Text("Make money",
                                              style: TextStyle(
                                                  color: Color(0xffb3b3b3))),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.6,
                                    ),
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage(
                                                              id: widget.id)));
                                            },
                                            child: const Text(
                                              "All ->",
                                              style: TextStyle(
                                                color: Color(0xffb3b3b3),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                      Positioned(
                        top: height * 0.67,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 11),
                            width: width,
                            height: height * 0.2,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: surveys!.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
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
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.white.withOpacity(0.1),
                                              offset: const Offset(0, 2),
                                              blurRadius: 4.0,
                                              spreadRadius: 1.0,
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: Colors.white
                                                  .withOpacity(0.2))),
                                      width: width * 0.3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.network(
                                            surveys![index].imgUrl,
                                            width: width * 0.2,
                                            height: height * 0.1,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            surveys![index].surveyName,
                                            style: const TextStyle(
                                                color: Color(0xffb3b3b3)),
                                          ),
                                          Text(
                                            surveys![index].surveyDescription,
                                            style: const TextStyle(
                                                color: Color(0xffb3b3b3)),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      )),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  width: 10,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: height * 0.86,
                          left: -5,
                          child: Row(
                            children: [
                              SizedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          Lottie.asset(
                                            width: 60,
                                            height: 60,
                                            "assets/bonus2.json",
                                          ),
                                          const Text("Earn money",
                                              style: TextStyle(
                                                  color: Color(0xffb3b3b3))),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.6,
                                    ),
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage(
                                                              id: widget.id)));
                                            },
                                            child: const Text(
                                              "All ->",
                                              style: TextStyle(
                                                color: Color(0xffb3b3b3),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                      Positioned(
                        top: height * 0.92,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 11),
                          width: width,
                          height: height * 0.2,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: surveys!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
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
                                },
                                child: Container(
                                    padding: const EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.white.withOpacity(0.1),
                                            offset: const Offset(0, 2),
                                            blurRadius: 4.0,
                                            spreadRadius: 1.0,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color:
                                                Colors.white.withOpacity(0.2))),
                                    width: width * 0.3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.network(
                                          surveys![index].imgUrl,
                                          width: width * 0.2,
                                          height: height * 0.1,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          surveys![index].surveyName,
                                          style: const TextStyle(
                                              color: Color(0xffb3b3b3)),
                                        ),
                                        Text(
                                          surveys![index].surveyDescription,
                                          style: const TextStyle(
                                              color: Color(0xffb3b3b3)),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    )),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                width: 10,
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        right: width * 0.00,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        left: width * 0.00,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        left: width * 0.375,
                        top: height*0.01,
                        child: const Text("Upoint Survey",style: TextStyle(color: Colors.white,fontSize: 20),)
                      ),
                      Positioned(
                        top: height * 0.06,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: height * 0.3,
                          width: width * 0.7,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xff121212),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.1),
                                // color: Color.fromARGB(255, 1, 28, 78),
                                spreadRadius: 5,
                                blurRadius: 7,
                              ),
                            ],
                          ),
                          child: Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
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
                                },
                                child: Image.network(
                                  surveys![index].imgUrl,
                                  width: 50,
                                  height: 100,
                                ),
                              );
                            },
                            itemCount: surveys!.length,
                            viewportFraction: 0.8,
                            scale: 0.9,
                          ),
                        ),
                      ),
                      // ),
                    ],
                  ),
                )
              : Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: const Color(0xff121212),
                  child: Center(
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
