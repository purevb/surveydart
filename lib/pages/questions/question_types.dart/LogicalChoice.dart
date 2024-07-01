import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LogicalChoice extends StatefulWidget {
  const LogicalChoice({super.key});

  @override
  State<LogicalChoice> createState() => _LogicalChoiceState();
}

Future<List<Answer>> fetchAnswers() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:3106/api/answer'));

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.map((answer) => Answer.fromJson(answer)).toList();
  } else {
    throw Exception('Failed to load answers.');
  }
}

List<String> options = ['Yes', 'No'];

class _LogicalChoiceState extends State<LogicalChoice> {
  late Future<List<Answer>> futureAnswer;
  String currentOption = '';

  @override
  void initState() {
    super.initState();
    futureAnswer = fetchAnswers();
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
        body: Container(
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
                  image: DecorationImage(image: AssetImage('assets/eq.png')),
                ),
              ),
              Container(
                  child: Text(
                "Энэ зураг танд таалагдаж байна уу ?",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18),
              )),
              FutureBuilder<List<Answer>>(
                  future: futureAnswer,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                snapshot.data![index].answerText,
                                style: TextStyle(color: Colors.white),
                              ),
                              leading: Radio(
                                value: options[index],
                                groupValue: currentOption,
                                onChanged: (value) {
                                  setState(() {
                                    currentOption = value.toString();
                                  });
                                },
                              ),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class Answer {
  final int answersId;
  final String questionsId;
  final String answerText;

  const Answer({
    required this.answersId,
    required this.questionsId,
    required this.answerText,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      answersId: json['answers_id'],
      questionsId: json['questions_id'],
      answerText: json['answer_text'],
    );
  }
}
