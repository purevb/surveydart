import 'package:flutter/material.dart';
import 'package:survey/models/survey_model.dart';
import 'package:survey/services/survey_service.dart';

class AnswerPage extends StatefulWidget {
  final String id;
  const AnswerPage({super.key, required this.id});

  @override
  State<AnswerPage> createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  @override
  void initState() {
    super.initState();
    getSurveyData();
  }

  List<Survey>? surveys;
  var isLoaded = false;

  Future<void> getSurveyData() async {
    try {
      surveys = await SurveyRemoteService().getSurvey();
      if (surveys != null && surveys!.isNotEmpty) {
        setState(() {
          isLoaded = true;
        });
      } else {
        print('No surveys found.');
      }
    } catch (e) {
      print('Error loading surveys: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("aaaa"),
        centerTitle: true,
        backgroundColor: Colors.grey[300],
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: isLoaded
              ? ListView.builder(
                  itemCount: surveys?.length ?? 0,
                  itemBuilder: (context, index) {
                    final survey = surveys![index];
                    if (survey.id == widget.id) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Welcome back you\'ve been missed!',
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 16),
                            ),
                            Text(widget.id),
                          ],
                        ),
                      );
                    }
                    return Container();
                  },
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
