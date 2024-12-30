import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider
import 'package:jokes_mis/widgets/joke_item.dart';
import '../model/joke.dart';
import '../providers/joke_provider.dart'; // Import JokeProvider

class FavoriteJokes extends StatefulWidget {
  @override
  State<FavoriteJokes> createState() => _FavoriteJokes();
}

class _FavoriteJokes extends State<FavoriteJokes> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;

    if (
        Provider.of<JokeProvider>(context, listen: false).jokes.isEmpty) {
      // Fetch jokes only if they are not already available
      Provider.of<JokeProvider>(context, listen: false).fetchJokesAllJokes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Jokes"),
      ),
      body: Consumer<JokeProvider>(
        builder: (context, jokeProvider, child) {
          // Check if the jokes are still loading
          if (jokeProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          // Check if no jokes were found
          if (jokeProvider.jokes.isEmpty) {
            return Center(child: Text("No jokes found."));
          }
          final List<Joke> filteredJokes = jokeProvider.jokes.where((j) => j.isFavorite).toList();
          // Display jokes in a ListView
          return ListView.builder(
            itemCount: filteredJokes.length,
            itemBuilder: (context, index) {
              return JokeItem(joke: filteredJokes[index]);
            },
          );
        },
      ),
    );
  }
}
