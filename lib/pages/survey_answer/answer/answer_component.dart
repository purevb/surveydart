import 'package:flutter/material.dart';

class AnswerTile extends StatefulWidget {
  final List<String> answer;
  final String typeId;
  const AnswerTile({required this.answer, required this.typeId, super.key});

  @override
  AnswerTileState createState() => AnswerTileState();
}

class AnswerTileState extends State<AnswerTile> {
  int? selectedAnswer;
  late List<bool> _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(widget.answer.length, false);
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
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    child: TextField(
                      decoration: InputDecoration(
                        hintMaxLines: 5,
                        helperMaxLines: 5,
                        contentPadding: EdgeInsets.symmetric(vertical: 80),
                        border: OutlineInputBorder(),
                        labelText: 'Tanii bodol',
                      ),
                    ),
                  );
                } else if (widget.typeId.contains("669763b497492aac645169c1")) {
                  return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CheckboxListTile(
                        title: Text(
                          widget.answer[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        value: _isChecked[index],
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked[index] = value!;
                          });
                        },
                      ));
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
                      groupValue: selectedAnswer,
                      onChanged: (int? value) {
                        setState(() {
                          selectedAnswer = value;
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
