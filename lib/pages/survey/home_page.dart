import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:survey/models/survey_model.dart';
import 'package:survey/services/survey_service.dart';
import 'package:survey/pages/survey_answer/question/test.dart';

class HomePage extends StatefulWidget {
  final String token;
  const HomePage({required this.token, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UniqueKey _refreshKey = UniqueKey();

  void refresh() {
    setState(() {
      _refreshKey = UniqueKey();
    });
  }

  late String email;
  String? name;
  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
    getSurveyData();
  }

  List<Survey>? surveys;
  var isLoaded = false;

  Future<void> getSurveyData() async {
    try {
      surveys = await SurveyRemoteService().getSurvey();

      // Provider.of<QuestionProvider>(context).survey!.addAll(surveys!);
      if (surveys != null && surveys!.isNotEmpty) {
        setState(() {
          isLoaded = true;
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int currentIndex = 0;
    return LiquidPullToRefresh(
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
          // onTabChange: (index) {
          //   setState(() {
          //     currentIndex = index;
          //   });
          // },
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
                              onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AnswerPage(id: surveys![index].id)))
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
                      ))
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
