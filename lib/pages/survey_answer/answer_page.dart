// import 'package:flutter/material.dart';
// import 'package:survey/models/all_survey_model.dart';
// import 'package:survey/models/survey_model.dart';
// import 'package:survey/pages/survey_answer/answer/answer_component.dart';
// import 'package:survey/services/all_surveys_service.dart';
// import 'package:survey/services/survey_service.dart';

// class AnswerPage extends StatefulWidget {
//   final String id;
//   const AnswerPage({super.key, required this.id});

//   @override
//   State<AnswerPage> createState() => _AnswerPageState();
// }

// class _AnswerPageState extends State<AnswerPage> {
//   List<AllSurvey>? allSurvey;
//   List<Survey>? surveys;
//   // var isLoaded = false;

//   @override
//   void initState() {
//     super.initState();
//     // getSurveyData();
//   }

//   // Future<void> getSurveyData() async {
//   //   try {
//   //     surveys = await SurveyRemoteService().getSurvey();
//   //     allSurvey = await AllSurveyRemoteService().getAllSurvey();
//   //     if (surveys != null &&
//   //         allSurvey != null &&
//   //         surveys!.isNotEmpty &&
//   //         allSurvey!.isNotEmpty) {
//   //       setState(() {
//   //         isLoaded = true;
//   //       });
//   //     } else {
//   //       print('No surveys or questions found.');
//   //     }
//   //   } catch (e) {
//   //     print('Error loading surveys: $e');
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Survey"),
//         centerTitle: true,
//         backgroundColor: Colors.grey[300],
//       ),
//       backgroundColor: Colors.grey[300],
//       body: SafeArea(
//           child: ListView.builder(
//         itemCount: allSurvey!.length,
//         itemBuilder: (context, index) {
//           if (widget.id == allSurvey![index].id) {
//             var survey = allSurvey![index];
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 for (var question in survey.question)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ListTile(
//                           contentPadding:
//                               const EdgeInsets.symmetric(horizontal: 25),
//                           title: Text(
//                             question.questionText,
//                             style: TextStyle(
//                                 color: Colors.grey[700],
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'Roboto'),
//                           ),
//                         ),
//                         const SizedBox(height: 4.0),
//                         ...question.answerText.map(
//                           (answer) => Padding(
//                             padding: const EdgeInsets.only(bottom: 4.0),
//                             child: AnswerTile(answer: answer.answerText),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//               ],
//             );
//           } else {
//             return Container();
//           }
//         },
//       )),
//     );
//   }
// }
