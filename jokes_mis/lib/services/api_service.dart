import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService{

  static Future<http.Response> getAllJokeTypes() async {
    var url = Uri.parse("https://official-joke-api.appspot.com/types");
    var response = await http.get(url);
    if (response.statusCode == 200){
      print("Success: ${response.body}");
      var data = jsonDecode(response.body);
      print("data $data");
      return response;
    }
    else{
      throw Exception("Failed to load data!");
    }

  }

  static Future<http.Response> getTypeJokes(String type) async{
    var url = Uri.parse("https://official-joke-api.appspot.com/jokes/${type}/ten");
    final response = await http.get(url);
    if (response.statusCode == 200){
      print("Success: ${response.body}");
      var data = jsonDecode(response.body);
      print("data $data");
      return response;
    }
    else{
      print("Type: ${type}");
      throw Exception("Failed to load data!");
    }
  }

  static Future<http.Response> getRandomJoke() async{
    var url = Uri.parse("https://official-joke-api.appspot.com/jokes/random");
    var response = await http.get(url);
    if (response.statusCode == 200){
      print("Success random: ${response.body}");
      var data = jsonDecode(response.body);
      print("data $data");
      return response;
    }
    else{

      throw Exception("Failed to load data!");
    }

  }

}
