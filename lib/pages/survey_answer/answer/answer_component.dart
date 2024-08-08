import 'package:flutter/material.dart';
import 'package:survey/provider/save_provider.dart';

class AnswerTile extends StatefulWidget {
  final List<String> answer;
  final String typeId;
  final VoidCallback? onNext;
  final VoidCallback? onBack;
  final int index;

  const AnswerTile({
    required this.index,
    required this.onNext,
    required this.onBack,
    required this.answer,
    required this.typeId,
    super.key,
  });

  @override
  AnswerTileState createState() => AnswerTileState();
}

class AnswerTileState extends State<AnswerTile> {
  final textFieldController = TextEditingController();
  late List<bool> _isChecked;
  var saveAnswer = SaveProvider();
  late Map<int, int?> selectedAnswer;

  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(widget.answer.length, false);
    selectedAnswer = {};
  }

  void saveCurrentAnswers() {
    if (widget.typeId.contains("66b19afb79959b160726b2c4")) {
      saveAnswer.saveAnswers([textFieldController.text]);
    } else if (widget.typeId.contains("669763b497492aac645169c1")) {
      List<String> selectedAnswers = [];
      for (int i = 0; i < _isChecked.length; i++) {
        if (_isChecked[i]) {
          selectedAnswers.add(widget.answer[i]);
        }
      }
      saveAnswer.saveAnswers(selectedAnswers);
    } else {
      if (selectedAnswer[widget.index] != null) {
        saveAnswer.saveAnswers([widget.answer[selectedAnswer[widget.index]!]]);
      }
    }
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
                        labelText: 'Tanii bodol',
                      ),
                      onChanged: (value) {
                        setState(() {
                          saveAnswer.saveAnswers([value]);
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
                        widget.answer[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      leading: Checkbox(
                        value: _isChecked[index],
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked[index] = value!;
                            List<String> selectedAnswers = [];
                            for (int i = 0; i < _isChecked.length; i++) {
                              if (_isChecked[i]) {
                                selectedAnswers.add(widget.answer[i]);
                              }
                            }
                            saveAnswer.saveAnswers(selectedAnswers);
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
                        widget.answer[index],
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
                            saveAnswer.saveAnswers([widget.answer[value]]);
                          }
                        });
                      },
                    ),
                  );
                }
              },
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     ElevatedButton(
          //       onPressed: () {
          //         saveCurrentAnswers();
          //         if (widget.onBack != null) widget.onBack!();
          //       },
          //       child: const Text('Back'),
          //     ),
          //     ElevatedButton(
          //       onPressed: () {
          //         saveCurrentAnswers();
          //         if (widget.onNext != null) widget.onNext!();
          //       },
          //       child: const Text('Next'),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
