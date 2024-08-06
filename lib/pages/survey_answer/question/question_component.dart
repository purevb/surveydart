import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:survey/models/all_survey_model.dart';
import 'package:survey/pages/survey_answer/answer/answer_component.dart';
import 'package:survey/provider/question_provider.dart';

class QuestionComponent extends StatefulWidget {
  final Question? question;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final int index;
  final int allIndex;

  const QuestionComponent({
    super.key,
    required this.question,
    required this.onNext,
    required this.onBack,
    required this.index,
    required this.allIndex,
  });

  @override
  State<QuestionComponent> createState() => _QuestionComponentState();
}

class _QuestionComponentState extends State<QuestionComponent> {
  int index = 0;
  int questionIndex = 0;

  @override
  void initState() {
    super.initState();
    knowNumber();
  }

  var dataProvider = QuestionProvider();

  void knowNumber() {
    setState(() {
      index == dataProvider.questionIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return widget.question != null
        ? Container(
            margin: EdgeInsets.only(
                top: height * 0.15,
                right: width * 0.05,
                left: width * 0.05,
                bottom: height * 0.01),
            width: width * 0.9,
            height: height * 0.85,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 8.0, top: 8.0, right: 8, left: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              'https://img.freepik.com/free-vector/abstract-business-professional-background-banner-design-multipurpose_1340-16863.jpg?size=626&ext=jpg&ga=GA1.1.1570753395.1722498379&semt=ais_hybrid',
                              height: height * 0.25,
                              width: width * 0.85,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            widget.question!.questionText,
                            style: const TextStyle(
                                fontSize: 27,
                                fontFamily: 'Roboto',
                                color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      StepProgressIndicator(
                        totalSteps: widget.allIndex,
                        currentStep: widget.index + 1,
                        size: 8,
                        padding: 0.001,
                        selectedColor: Colors.yellow,
                        unselectedColor: Colors.cyan,
                        roundedEdges: const Radius.circular(10),
                        selectedGradientColor: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 138, 112, 233),
                            Colors.deepOrange
                          ],
                        ),
                        unselectedGradientColor: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 189, 174, 174),
                            Colors.blue
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        height: height * 0.35,
                        child: AnswerTile(
                            typeId: widget.question!.questionTypeId,
                            answer: widget.question!.answerText
                                .map((e) => e.answerText)
                                .toList()),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: widget.onBack,
                        child: Container(
                          width: width * 0.2,
                          height: height * 0.06,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xffEEE4B1),
                                    Color(0xffC8ACD6)
                                  ]),
                              borderRadius: BorderRadius.circular(16)),
                          child: const Column(
                            children: [
                              Icon(Icons.keyboard_double_arrow_left_sharp),
                              Text(
                                "Back",
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("Questions tapped");
                        },
                        child: Container(
                          width: width * 0.2,
                          height: height * 0.06,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xffEEE4B1),
                                    Color(0xffC8ACD6)
                                  ]),
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("${widget.index + 1}/${widget.allIndex}"),
                              const Text(
                                "Questions",
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("Audience tapped");
                        },
                        child: Container(
                          width: width * 0.2,
                          height: height * 0.06,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xffEEE4B1),
                                    Color(0xffC8ACD6)
                                  ]),
                              borderRadius: BorderRadius.circular(16)),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.people),
                              Text(
                                "Audience",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w100,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.onNext,
                        child: Container(
                          width: width * 0.2,
                          height: height * 0.06,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xffEEE4B1),
                                    Color(0xffC8ACD6)
                                  ]),
                              borderRadius: BorderRadius.circular(16)),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.keyboard_double_arrow_right_sharp),
                              Text(
                                "Next",
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
