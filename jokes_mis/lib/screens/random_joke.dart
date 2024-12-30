import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jokes_mis/widgets/joke_item.dart';
import 'package:provider/provider.dart';

import '../model/joke.dart';
import '../providers/joke_provider.dart';
import '../services/api_service.dart';


class RandomJoke extends StatefulWidget {
  const RandomJoke({super.key});

  @override
  State<RandomJoke> createState() => _RandomJokeState();
}

class _RandomJokeState extends State<RandomJoke> {

  Joke joke = new Joke(type: '',setup: '',punchline: '',id: 0);


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Call the provider method after the build phase
      Provider.of<JokeProvider>(context, listen: false).fetchRandomJoke();

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Random Joke"),
      ),
      body: Consumer<JokeProvider>(
            builder: (context, jokeProvider, child) {

              Joke joke = jokeProvider.randomJoke;


              return JokeItem(joke: joke);
        }

      )
    );
  }
}
