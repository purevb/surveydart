import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey/models/all_survey_model.dart';
import 'package:survey/provider/save_provider.dart';

class AnswerTile extends StatefulWidget {
  final String questionId;
  // final String responseId;
  final String userId;
  final List<Answer> answer;
  final String typeId;
  final bool? onNext;
  final bool? onBack;
  final int index;

  const AnswerTile({
    required this.index,
    required this.onNext,
    required this.onBack,
    required this.answer,
    required this.typeId,
    required this.questionId,
    // required this.responseId,
    required this.userId,
    super.key,
  });

  @override
  AnswerTileState createState() => AnswerTileState();
}

class AnswerTileState extends State<AnswerTile> {
  final textFieldController = TextEditingController();
  late Map<int, Map<int, bool>> isChecked;
  var saveAnswer = SaveProvider();
  late Map<int, int?> selectedAnswer;
  late String text = "";
  @override
  void initState() {
    super.initState();
    selectedAnswer = {};
    isChecked = {
      for (int i = 0; i < widget.answer.length; i++)
        i: {for (int j = 0; j < widget.answer.length; j++) j: false}
    };
    text = "";
  }

  void saveCurrentAnswers() {
    if (widget.typeId.contains("66b19afb79959b160726b2c4")) {
      if (widget.onBack == true || widget.onNext == true) {
        Provider.of<SaveProvider>(context, listen: false)
            .saveAnswers(widget.questionId, [textFieldController.text]);
      }
    } else if (widget.typeId.contains("669763b497492aac645169c1")) {
      List<String> selectedAnswers = [];
      for (int i = 0; i < widget.answer.length; i++) {
        if (isChecked[widget.index]![i] == true) {
          selectedAnswers.add(widget.answer[i].id);
        }
      }
      Provider.of<SaveProvider>(context, listen: false)
          .saveAnswers(widget.questionId, selectedAnswers);
    } else {
      if (selectedAnswer[widget.index] != null) {
        Provider.of<SaveProvider>(context, listen: false).saveAnswers(
            widget.questionId,
            [widget.answer[selectedAnswer[widget.index]!].id]);
      }
    }
    print(
        '${Provider.of<SaveProvider>(context, listen: false).savedMyAnswers.values.toList()}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: widget.answer.isEmpty ? 1 : widget.answer.length,
              itemBuilder: (context, index) {
                if (widget.typeId.contains("66b19afb79959b160726b2c4")) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    child: TextField(
                      controller: textFieldController,
                      decoration: const InputDecoration(
                        hintMaxLines: 5,
                        helperMaxLines: 5,
                        contentPadding: EdgeInsets.symmetric(vertical: 80),
                        border: OutlineInputBorder(),
                        labelText: 'Your Opinion',
                      ),
                      onChanged: (value) {
                        setState(() {
                          text = value;
                        });
                      },
                      onSubmitted: (value) {
                        setState(() {
                          Provider.of<SaveProvider>(context, listen: false)
                              .saveAnswers(widget.questionId, [text]);
                          // saveAnswer.saveAnswers(widget.questionId, [text]);
                        });
                      },
                    ),
                  );
                } else if (widget.typeId.contains("669763b497492aac645169c1")) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(
                        widget.answer[index].answerText,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      leading: Checkbox(
                        value: isChecked[widget.index]?[index],
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked[widget.index]?[index] = value ?? false;
                            List<String> selectedAnswers = [];
                            for (int i = 0; i < isChecked.length; i++) {
                              if (isChecked[i]?[index] == true) {
                                selectedAnswers.add(widget.answer[i].id);
                              }
                            }
                            saveAnswer.saveAnswers(
                                widget.questionId, selectedAnswers);
                          });
                        },
                      ),
                    ),
                  );
                } else {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: RadioListTile<int>(
                      title: Text(
                        widget.answer[index].answerText,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      value: index,
                      groupValue: selectedAnswer[widget.index],
                      onChanged: (int? value) {
                        setState(() {
                          selectedAnswer[widget.index] = value;
                          if (value != null) {
                            saveAnswer.saveAnswers(
                                widget.questionId, [widget.answer[value].id]);
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
    );
  }
}
