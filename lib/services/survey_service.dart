import 'package:http/http.dart' as http;
import 'package:survey/models/survey_model.dart';

class SurveyRemoteService {
  Future<List<Survey>?> getSurvey() async {
    var client = http.Client();
    var uri = Uri.parse('http://10.0.2.2:3106/api/survey');

    try {
      var response = await client.get(uri);
      if (response.statusCode == 200) {
        var json = response.body;
        return surveyFromJson(json);
      } else {
        print('Server error:');
      }
    } catch (e) {
      print('Network error: $e');
    } finally {
      client.close();
    }

    return null;
  }
}
