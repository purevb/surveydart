import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:survey/models/all_survey_model.dart';
import 'package:survey/pages/survey_answer/answer/answer_component.dart';
import 'package:survey/provider/question_provider.dart';
import 'package:survey/provider/save_provider.dart';

class QuestionComponent extends StatefulWidget {
  final Question? question;
  final VoidCallback? onNext;
  final VoidCallback? onBack;
  final int? index;
  final int? allIndex;

  const QuestionComponent({
    super.key,
    this.question,
    this.onNext,
    this.onBack,
    this.index,
    this.allIndex,
  });

  @override
  State<QuestionComponent> createState() => _QuestionComponentState();
}

class _QuestionComponentState extends State<QuestionComponent> {
  List<Answer>? answers = []; // Initialize as an empty list
  int index = 0;
  int questionIndex = 0;

  final textFieldController = TextEditingController();
  late Map<int, Map<int, bool>> isChecked;
  final SaveProvider saveAnswer = SaveProvider();
  late Map<int, int?> selectedAnswer;

  void getAnswers() {
    setState(() {
      answers!.addAll(widget.question!.answerText.map((e) => e).toList());
    });
  }

  @override
  void initState() {
    super.initState();
    knowNumber();
    if (widget.question != null) {
      getAnswers();
    }
    selectedAnswer = {};
    isChecked = {
      for (int i = 0; i < answers!.length; i++)
        i: {for (int j = 0; j < answers![i].answerText.length; j++) j: false}
    };
  }

  var dataProvider = QuestionProvider();

  void knowNumber() {
    setState(() {
      index == dataProvider.questionIndex;
    });
  }

  void saveCurrentAnswers() {
    if (widget.question!.questionTypeId.contains("66b19afb79959b160726b2c4")) {
      saveAnswer.saveAnswers([textFieldController.text]);
    } else if (widget.question!.questionTypeId
        .contains("669763b497492aac645169c1")) {
      List<String> selectedAnswers = [];
      for (int i = 0; i < answers!.length; i++) {
        for (int j = 0; j < answers![i].answerText.length; j++) {
          if (isChecked[i]![j] == true) {
            selectedAnswers.add(answers![i].id[j]);
          }
        }
      }
      saveAnswer.saveAnswers(selectedAnswers);
    } else {
      if (selectedAnswer[widget.index] != null) {
        saveAnswer.saveAnswers([answers![selectedAnswer[widget.index]!].id]);
      }
    }
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
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset('assets/placeholder.jpg'),
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
                        totalSteps: widget.allIndex!,
                        currentStep: widget.index! + 1,
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
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount:
                                    answers!.isEmpty ? 1 : answers!.length,
                                itemBuilder: (context, index) {
                                  if (widget.question!.questionTypeId
                                      .contains("66b19afb79959b160726b2c4")) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 8),
                                      child: TextField(
                                        controller: textFieldController,
                                        decoration: const InputDecoration(
                                          hintMaxLines: 5,
                                          helperMaxLines: 5,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 80),
                                          border: OutlineInputBorder(),
                                          labelText: 'Tanii bodol',
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            saveAnswer.saveAnswers([value]);
                                          });
                                        },
                                      ),
                                    );
                                  } else if (widget.question!.questionTypeId
                                      .contains("669763b497492aac645169c1")) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          answers![index].answerText,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Roboto',
                                          ),
                                        ),
                                        leading: Checkbox(
                                          value: isChecked[widget.index]
                                              ?[index],
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isChecked[widget.index]?[index] =
                                                  value ?? false;
                                              List<String> selectedAnswers = [];
                                              for (int i = 0;
                                                  i < isChecked.length;
                                                  i++) {
                                                if (isChecked[i]?[index] ==
                                                    true) {
                                                  selectedAnswers
                                                      .add(answers![i].id);
                                                }
                                              }
                                              saveAnswer
                                                  .saveAnswers(selectedAnswers);
                                            });
                                          },
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: RadioListTile<int>(
                                        title: Text(
                                          answers![index].answerText,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Roboto',
                                          ),
                                        ),
                                        value: index,
                                        groupValue: selectedAnswer[index],
                                        onChanged: (int? value) {
                                          setState(() {
                                            selectedAnswer[index] = value;
                                            if (value != null) {
                                              saveAnswer.saveAnswers(
                                                  [answers![value].id]);
                                            }
                                          });
                                        },
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
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
                                style: TextStyle(fontWeight: FontWeight.w500),
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
                              Text("${widget.index! + 1}/${widget.allIndex}"),
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
                        onTap: () {
                          saveCurrentAnswers();
                          widget.onNext?.call();
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
                            children: [
                              Icon(Icons.keyboard_double_arrow_right_sharp),
                              Text(
                                "Next",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
