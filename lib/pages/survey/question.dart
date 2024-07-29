import 'package:flutter/material.dart';
import 'package:survey/pages/questions/question_types.dart/logical_choice.dart';
import 'package:survey/pages/questions/question_types.dart/multiple_choice.dart';
import 'package:survey/pages/questions/question_types.dart/numeric_choice.dart';
import 'package:survey/pages/questions/question_types.dart/single_choice.dart';
import 'package:survey/pages/questions/question_types.dart/text_choice.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {},
            color: const Color(0xff910A67),
          ),
        ),
        backgroundColor: Colors.black,
        body: Container(
          padding: const EdgeInsets.only(right: 20, left: 10),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.centers,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        backgroundColor: Colors.black),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          size: 15,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Back",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    "1/32",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SingleChoice()));
                          },
                          style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              backgroundColor: const Color(0xff030637)),
                          child: const Text("SingleChoice"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MultipleChoice()));
                            },
                            style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                backgroundColor: const Color(0xff030637)),
                            child: const Text("MultipleChoice")),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LogicalChoice()));
                            },
                            style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                backgroundColor: const Color(0xff030637)),
                            child: const Text("LogicalChoice")),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const TextChoice()));
                            },
                            style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                backgroundColor: const Color(0xff030637)),
                            child: const Text("TextChoice")),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NumericChoice()));
                            },
                            style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                backgroundColor: const Color(0xff030637)),
                            child: const Text("NumericChoice")),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
