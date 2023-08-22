import 'dart:convert';
import 'package:fast_trivia/models/category.dart';
import 'package:fast_trivia/models/question.dart';
import 'package:http/http.dart' as http;

const String baseUrl = "https://64e34aacbac46e480e788a2e.mockapi.io/api/";

Future<List<Question>> getQuestions(
    Category category, int? total, String? difficulty) async {
  String url = "$baseUrl${category.id}";
  print(url);

  http.Response res = await http.get(Uri.parse(url));
  List<Map<String, dynamic>> questions =
      List<Map<String, dynamic>>.from(json.decode(res.body));
  return Question.fromData(questions);
}
