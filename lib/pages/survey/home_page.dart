import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:survey/models/survey_model.dart';
import 'package:survey/provider/question_provider.dart';
import 'package:survey/services/survey_service.dart';
import 'package:survey/test.dart';

class HomePage extends StatefulWidget {
  final String token;
  const HomePage({required this.token, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      // appBar: AppBar(
      //   leading: Padding(
      //     padding: const EdgeInsets.only(top: 20, left: 20),
      //     child: Builder(
      //       builder: (BuildContext context) {
      //         return GestureDetector(
      //           child: const Icon(Icons.person),
      //           onTap: () {
      //             print("object");
      //           },
      //         );
      //       },
      //     ),
      //   ),
      //   actions: <Widget>[
      //     Padding(
      //       padding: const EdgeInsets.only(top: 20, right: 20),
      //
      //   ],
      //   automaticallyImplyLeading: false,
      //   backgroundColor: const Color(0xfffcfaff),
      // ),
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
                  child: Container(
                    width: width,
                    height: height * 0.7,
                    child: GridView.builder(
                      physics: ClampingScrollPhysics(),
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
                    icon: const Icon(Icons.menu),
                  ),
                ),
                Positioned(
                  left: width * 0.04,
                  top: height * 0.04,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.person),
                  ),
                ),
                Positioned(
                    top: height * 0.14,
                    child: Text(
                      "All Surveys",
                      style: TextStyle(fontSize: 24, fontFamily: 'Roboto'),
                    ))
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
