import 'package:http/http.dart' as http;
import 'package:survey/models/question_type.dart';

class TypesRemoteService {
  Future<List<QuestionType>> getType() async {
    var client = http.Client();
    var uri = Uri.parse('http://10.0.2.2:3106/api/type');

    try {
      var response = await client.get(uri);
      if (response.statusCode == 200) {
        var json = response.body;
        return typeFromJson(json);
      } else {
        print('Server error: ${response.statusCode}');
        throw Exception('Failed to load types from API');
      }
    } catch (e) {
      print('Network error: $e');
      throw e;
    } finally {
      client.close();
    }
  }
}
