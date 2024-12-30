import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jokes_mis/model/joke.dart';
import 'package:jokes_mis/services/joke_service.dart';

import '../services/api_service.dart';

class JokeProvider with ChangeNotifier {
  List<Joke> _jokes = [];
  bool _isLoading = false;

  List<Joke> get jokes => _jokes;
  bool get isLoading => _isLoading;

  Joke _randomJoke = Joke(type: '', setup: '', punchline: '', id: 0);
  Joke get randomJoke => _randomJoke;


  Future<void> fetchJokesByType(String type) async {
    _isLoading = true;
    notifyListeners(); // Notify listeners about the loading state

    try {
      final response = await ApiService.getTypeJokes(type);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<dynamic> jokesJson = data;

        _jokes.addAll(jokesJson.map((jokeJson) => Joke.fromJson(jokeJson)).toList());
      } else {
        print("Failed to load jokes: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }

    _isLoading = false;
    notifyListeners(); // Notify listeners again to update the UI after data is fetched
  }


  Future<void> fetchJokesAllJokes() async {
    _isLoading = true;
    notifyListeners(); // Notify listeners about the loading state

    try {
      final response = await ApiService.getAllJokeTypes();

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data is List) {
          List<String> stringList = List<String>.from(data);
          print("String list: $stringList");
          for(String s in stringList){
            fetchJokesByType(s);
          }
        } else {
          print("Expected a List of strings, but got something else");
        }
      } else {
        print("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }

    _isLoading = false;
    notifyListeners(); // Notify listeners again to update the UI after data is fetched
  }

  Future<void> fetchRandomJoke() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService.getRandomJoke();
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        _randomJoke = Joke.fromJson(data);
        //jokes.add(randomJoke);
      } else {
        print("Failed to load joke: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

 void addFavoriteJokes(Joke joke){
    if (!jokes.contains(joke)){
      jokes.add(joke);
      notifyListeners();
    }

 }
  void toggleFavorite(Joke joke) {
    joke.isFavorite = !joke.isFavorite;
    notifyListeners();
  }


}
