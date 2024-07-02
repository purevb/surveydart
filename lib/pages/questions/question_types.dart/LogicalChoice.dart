import 'package:flutter/material.dart';
import 'package:survey/models/answer.dart';
import 'package:survey/models/question.dart';
import 'package:survey/services/answer_remote_service.dart';
import 'package:survey/services/question_remote_service.dart';

class LogicalChoice extends StatefulWidget {
  const LogicalChoice({super.key});

  @override
  State<LogicalChoice> createState() => _LogicalChoiceState();
}

class _LogicalChoiceState extends State<LogicalChoice> {
  List<Answer>? answers;
  List<Question>? questions;
  // String logicalChoiceQuestionTypeID = "665e90954026f697ef6234e9";

  String currentOption = '';
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    answers = await RemoteService().getAnswer();
    questions = await QuestionRemoteService().getQuestion();
    print(questions![0].questionsTypeID.toString());
    if (answers != null && questions != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
        body: isLoaded
            ? Container(
                padding: const EdgeInsets.only(right: 20, left: 10),
                child: Column(
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
                            backgroundColor: Colors.black,
                          ),
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
                        ),
                      ],
                    ),
                    Container(
                      width: width * 0.9,
                      height: height * 0.3,
                      decoration: const BoxDecoration(
                        image:
                            DecorationImage(image: AssetImage('assets/eq.png')),
                      ),
                    ),
                    if (questions != null && questions!.isNotEmpty)
                      Container(
                        child: Text(
                          questions![1].questionText ?? "No question available",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                      ),
                    Visibility(
                      visible: isLoaded,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: answers?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                title: Text(
                                  answers![index].answerText,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                leading: Radio(
                                  value: answers![index].answerText,
                                  groupValue: currentOption,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        currentOption = value.toString();
                                      },
                                    );
                                  },
                                ),
                              )
                            ],
                          );
                        },
                      ),
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
