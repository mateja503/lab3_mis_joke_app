import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/joke.dart';
import '../providers/joke_provider.dart';
import '../providers/joke_provider.dart';

class JokeItem extends StatefulWidget {
  const JokeItem({super.key, required this.joke});
  final Joke joke;

  @override
  State<JokeItem> createState() => _JokeItemState();
}

class _JokeItemState extends State<JokeItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          Icons.label_important_outlined,
          color: Colors.amber,
          size: 30,
        ),
        title: Text(
          widget.joke.setup,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            widget.joke.punchline,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        trailing: IconButton(
          icon: Icon(
            widget.joke.isFavorite
                ? Icons.favorite
                : Icons.favorite_border,
            color: Colors.redAccent,
          ),
          onPressed: () {
            // Toggle the favorite status using the provider
            Provider.of<JokeProvider>(context, listen: false).toggleFavorite(widget.joke);

            if (widget.joke.isFavorite){
              Provider.of<JokeProvider>(context, listen: false).addFavoriteJokes(widget.joke);
            }

            // Optionally show a snackbar to notify the user
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(widget.joke.isFavorite? "The joke has been saved to favorites" : "The joke is removed from the favorites"),
              ),
            );
          },
        ),
      ),
    );
  }
}
