import 'package:http/http.dart' as http;
import 'package:survey/models/question_type.dart';

class QuestionRemoteService {
  Future<List<QuestionModel>?> getQuestion() async {
    var clientls = http.Client();
    var urils = Uri.parse('http://localhost:3106/api/question');
    try {
      var response = await clientls.get(urils);
      if (response.statusCode == 200) {
        var json = response.body;
        return questionFromJson(json);
      } else {
        print('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Network error: $e');
    } finally {
      clientls.close();
    }
    return null;
  }
}
