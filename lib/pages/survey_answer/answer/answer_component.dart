import 'package:flutter/material.dart';

class AnswerTile extends StatefulWidget {
  final String answer;
  const AnswerTile({required this.answer, super.key});

  @override
  State<AnswerTile> createState() => _AnswerTileState();
}

class _AnswerTileState extends State<AnswerTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.3)),
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.answer,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, fontFamily: 'Roboto'),
            ),
            const Radio(value: null, groupValue: null, onChanged: null),
          ],
        ));
  }
}
