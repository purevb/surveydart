import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:survey/pages/questions/question_types.dart/LogicalChoice.dart';
import 'package:survey/pages/questions/question_types.dart/MultipleChoice.dart';
import 'package:survey/pages/questions/question_types.dart/NumericChoice.dart';
import 'package:survey/pages/questions/question_types.dart/SingleChoice.dart';
import 'package:survey/pages/questions/question_types.dart/TextChoice.dart';

class QuizPage extends StatelessWidget {
  QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.home),
            onPressed: () {},
            color: Color(0xff910A67),
          ),
        ),
        backgroundColor: Colors.black,
        body: Container(
          padding: EdgeInsets.only(right: 20, left: 10),
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
                        padding: EdgeInsets.symmetric(horizontal: 0),
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
                  Text(
                    "1/32",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
              Container(
                child: SingleChildScrollView(
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
                                      builder: (context) => SingleChoice()));
                            },
                            child: Text("SingleChoice"),
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                backgroundColor: Color(0xff030637)),
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
                                            MultipleChoice()));
                              },
                              child: Text("MultipleChoice"),
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  backgroundColor: Color(0xff030637))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LogicalChoice()));
                              },
                              child: Text("LogicalChoice"),
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  backgroundColor: Color(0xff030637))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TextChoice()));
                              },
                              child: Text("TextChoice"),
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  backgroundColor: Color(0xff030637))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NumericChoice()));
                              },
                              child: Text("NumericChoice"),
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  backgroundColor: Color(0xff030637))),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
