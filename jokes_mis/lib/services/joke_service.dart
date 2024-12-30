import 'dart:convert';
import 'package:jokes_mis/model/joke.dart';
import 'api_service.dart';

class JokeService {

  static Future<List<Joke>> fetchJokesByType(String type) async {
    try {
      final response = await ApiService.getTypeJokes(type);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List<dynamic>;
        List<dynamic> jokesJson = data;
        return jokesJson.map((jokeJson) => Joke.fromJson(jokeJson)).toList();
      } else {
        throw Exception("Failed to load jokes: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("An error occurred while fetching jokes: $e");
    }
  }
}
