import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:survey/animation.dart';
import 'package:survey/models/all_survey_model.dart';
import 'package:survey/models/answer_options_model.dart';
import 'package:survey/pages/survey/home_page.dart';
import 'package:survey/provider/save_provider.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class SaveAnswer extends StatefulWidget {
  List<Question>? mySurveysQuestion = [];
  final String surveyId;
  // final String responseId;
  final String userId;
  SaveAnswer(
      {required this.surveyId,
      // required this.responseId,
      required this.userId,
      required this.mySurveysQuestion,
      super.key});

  @override
  State<SaveAnswer> createState() => SaveResponseState();
}

class SaveResponseState extends State<SaveAnswer> {
  late String email;
  String? name;

  // var saveProvider = SaveProvider();

  void collectSaveQuestions() {
    // saveProvider.saveMyResponse();
    List<AnswerOptionModel> savedOptions = [];

    Provider.of<SaveProvider>(context, listen: false)
        .savedMyAnswers
        .forEach((questionId, answers) {
      if (answers.isNotEmpty) {
        AnswerOptionModel aoption = AnswerOptionModel(
          surveyId: Provider.of<SaveProvider>(context, listen: false).surveyId,
          questionId: questionId,
          responseId:
              Provider.of<SaveProvider>(context, listen: false).responseId,
          userId: widget.userId,
          userChoice: answers,
        );
        savedOptions.add(aoption);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('answers cant be null')),
        );
      }
    });
    saveAllResponses(savedOptions);
  }

  Future<void> saveAllResponses(List<AnswerOptionModel> answers) async {
    final url = Uri.parse('http://10.0.2.2:3106/api/aoptionses');
    try {
      final answersJson = answers.map((r) => r.toJson()).toList();
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'aoption': answersJson}),
      );

      print('Post response: ${response.body}');

      if (response.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AnimationPage(id: widget.userId)));
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => HomePage(id: widget.userId),
        //   ),
        // );
        var reqBody = {"end_date": DateTime.now().toIso8601String()};
        var id = Provider.of<SaveProvider>(context, listen: false).responseId;
        print('Sending PUT request to update endDate: ${reqBody['end_date']}');
        var updateResponse = await http.put(
          Uri.parse('http://10.0.2.2:3106/api/updateResponse/$id'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody),
        );
        if (updateResponse.statusCode == 200) {
          print('EndDate updated successfully.');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content:
                    Text('Answers saved and endDate updated successfully')),
          );
        } else {
          print('Failed to update EndDate: ${updateResponse.statusCode}');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update endDate')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save answers')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error occurred while saving answers')),
      );
      print('Error: $e');
    }
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Container(
          //   decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //       colors: [Color.fromARGB(255, 187, 178, 202), Color(0xffe7e2fe)],
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
          Container(
            color: const Color(0xff121212),
          ),
          Positioned(
            top: height * 0.18,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              width: width,
              height: height * 0.6,
              child: GridView.builder(
                padding: EdgeInsets.zero,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1,
                ),
                itemCount: widget.mySurveysQuestion!.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             const QuestionComponent()));
                      },
                      child: Container(
                        color: const Color(0xffb3b3b3),
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              Provider.of<SaveProvider>(context, listen: false)
                                  .responseId,
                              // widget.mySurveysQuestion![index].questionText,
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
            top: height * 0.8,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffb3b3b3)),
                onPressed: () {
                  // print(
                  //     "${Provider.of<SaveProvider>(context, listen: false).savedMyAnswers.values.toList()}+sda");
                  // saveAllResponses(saveProvider.saveResponse);
                  collectSaveQuestions();
                  Provider.of<SaveProvider>(context, listen: false)
                      .savedMyAnswers
                      .clear();
                },
                // print(saveAnswer.savedMyAnswers.values.toList());
                child: const Text(
                  "Save Button",
                  style: TextStyle(color: Colors.black),
                )),
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
      ),
    );
  }
}
