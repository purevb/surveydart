import 'package:http/http.dart' as http;
import 'package:survey/models/survey_model.dart';

class SurveyRemoteService {
  Future<List<Survey>?> getSurvey() async {
    var clients = http.Client();
    var uris = Uri.parse('http://192.168.10.115:3106/api/survey');
    try {
      var response = await clients.get(uris);
      if (response.statusCode == 200) {
        var json = response.body;
        return surveyFromJson(json);
      } else {
        print('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Network error: $e');
    } finally {
      clients.close();
    }
    return null;
  }
}
