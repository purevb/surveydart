import 'package:http/http.dart' as http;
import 'package:survey/models/all_survey_model.dart';

class AllSurveyRemoteService {
  final String baseUrl = 'http://10.0.2.2:3106/api';

  Future<List<AllSurvey>?> getAllSurvey() async {
    var client = http.Client();
    var uri = Uri.parse('$baseUrl/surveyQuestions');
    try {
      var response = await client.get(uri);
      if (response.statusCode == 200) {
        var json = response.body;
        return allSurveyFromJson(json);
      } else {
        print('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Network error: $e');
    } finally {
      client.close();
    }
    return null;
  }
}
