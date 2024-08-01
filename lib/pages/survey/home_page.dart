import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:survey/models/survey_model.dart';
import 'package:survey/pages/survey_answer/answer_page.dart';
import 'package:survey/services/survey_service.dart';

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
        tabBackgroundColor: Colors.black.withOpacity(0.2),
        padding: const EdgeInsets.all(16),
        tabMargin: const EdgeInsets.only(bottom: 8, right: 24, left: 24),
        gap: 8,
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
            icon: Icons.settings,
            text: 'Settings',
          ),
        ],
      ),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20),
          child: Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                child: const Icon(Icons.person),
                onTap: () {
                  print("object");
                },
              );
            },
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 20),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            ),
          )
        ],
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xfffcfaff),
      ),
      backgroundColor: const Color(0xfffcfaff),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: isLoaded
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hey Charley, what subject \nyou want to join survey today?",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Roboto"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: height * 0.63,
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
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
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Image.network(
                                        surveys![index].imgUrl,
                                        width: width * 0.25,
                                        height: height * 0.25,
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
                    )
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
