import 'package:flutter/material.dart';

class AnswerTile extends StatefulWidget {
  final List<String> answer;
  const AnswerTile({required this.answer, super.key});

  @override
  AnswerTileState createState() => AnswerTileState();
}

class AnswerTileState extends State<AnswerTile> {
  int? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.answer.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5), // Adjust margin
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
      },
    );
  }
}
