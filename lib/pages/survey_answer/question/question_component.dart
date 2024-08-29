import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:survey/models/all_survey_model.dart';
import 'package:survey/pages/survey_answer/answer/answer_component.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
// import 'package:survey/provider/save_provider.dart';

class QuestionComponent extends StatefulWidget {
  final String surveyId;
  // final String responseId;
  final String userId;
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
    required this.surveyId,
    // required this.responseId,
    required this.userId,
  });

  @override
  State<QuestionComponent> createState() => _QuestionComponentState();
}

class _QuestionComponentState extends State<QuestionComponent> {
  late bool usedOnNext = false;
  late bool usedOnBack = false;
  final GlobalKey<AnswerTileState> answerTileKey = GlobalKey<AnswerTileState>();
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
              bottom: height * 0.01,
            ),
            width: width * 0.9,
            height: height * 0.85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white.withOpacity(0.15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              'https://images.unsplash.com/photo-1595418917831-ef942bd9f9ec?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
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
                              color: Colors.white,
                            ),
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
                        padding: 0.0001,
                        selectedColor: Colors.yellow,
                        unselectedColor: Colors.cyan,
                        roundedEdges: const Radius.circular(10),
                        selectedGradientColor: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 16, 207, 32),
                            Color.fromARGB(255, 16, 207, 32)
                          ],
                        ),
                        unselectedGradientColor: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 106, 167, 148),
                            Color.fromARGB(255, 3, 0, 12)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      SizedBox(
                        height: height * 0.35,
                        child: AnswerTile(
                          key: answerTileKey,
                          allIndex: widget.allIndex!,
                          index: widget.index!,
                          onBack: usedOnBack,
                          onNext: usedOnNext,
                          typeId: widget.question!.questionTypeId,
                          questionId: widget.question!.id,
                          // responseId: widget.responseId,
                          userId: widget.userId,
                          answer: widget.question!.answerText
                              .map((e) => e)
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (widget.onBack != null) {
                              widget.onBack!();
                              usedOnBack = true;
                              answerTileKey.currentState?.saveCurrentAnswers();
                            }
                          });
                        },
                        child: Container(
                          width: width * 0.2,
                          height: height * 0.05,
                          decoration: BoxDecoration(
                              color: const Color(0xff1db954),
                              borderRadius: BorderRadius.circular(5)),
                          child: const Column(
                            children: [
                              Icon(Icons.keyboard_double_arrow_left_sharp),
                              Text(
                                "Back",
                                style: TextStyle(fontSize: 15),
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
                          height: height * 0.05,
                          decoration: BoxDecoration(
                              color: const Color(0xff1db954),
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("${widget.index! + 1}/${widget.allIndex}"),
                              const Text(
                                "Questions",
                                style: TextStyle(fontSize: 15),
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
                          height: height * 0.05,
                          decoration: BoxDecoration(
                              color: const Color(0xff1db954),
                              borderRadius: BorderRadius.circular(5)),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.people),
                              Text(
                                "Audience",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w100,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (widget.onNext != null) {
                              widget.onNext!();
                              usedOnNext = true;
                              answerTileKey.currentState?.saveCurrentAnswers();
                            }
                          });
                        },
                        child: Container(
                          width: width * 0.2,
                          height: height * 0.05,
                          decoration: BoxDecoration(
                              color: const Color(0xff1db954),
                              borderRadius: BorderRadius.circular(5)),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.keyboard_double_arrow_right_sharp),
                              Text(
                                "Next",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
