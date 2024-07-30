// import 'package:flutter/material.dart';
// import 'package:survey/pages/survey/question.dart';

// class SurveyPage extends StatelessWidget {
//   const SurveyPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           "Survey App",
//         ),
//         foregroundColor: Colors.white,
//         backgroundColor: Colors.black,
//       ),
//       backgroundColor: Colors.black,
//       body: Padding(
//         padding: const EdgeInsets.only(left: 20, right: 20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               "XXX TEST",
//               style: TextStyle(color: Colors.white, fontSize: 48),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const Text(
//               "Introduction: Lorem ipsum dolor sit amet consectetur. Quisque nisl magnis orci tortor iaculis lectus turpis. Orci blandit a at amet risus. Gravida id congue ac ullamcorper eu. At morbi risus magna nisl pulvinar at at integer nullam.",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 14,
//               ),
//             ),
//             const SizedBox(
//               height: 40,
//             ),
//             SizedBox(
//                 width: 120,
//                 height: 120,
//                 child: Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(100),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.amber,
//                           blurRadius: 30.0,
//                           spreadRadius: 2.0,
//                         )
//                       ]),
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xff5956fe)),
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const QuizPage()));
//                     },
//                     child: const Text(
//                       "START",
//                       style: TextStyle(color: Colors.white, fontSize: 16),
//                     ),
//                   ),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }
// // onPressed: () {
// // }
