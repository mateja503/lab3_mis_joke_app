
class Joke{
  final String type;
  final String setup;
  final String punchline;
  final int id;
  bool isFavorite = false;

  Joke({required this.type,required this.setup,required this.punchline,required this.id});

  Joke.fromJson(Map<String,dynamic> data)
    : type = data['type'] ?? " ",
      setup = data['setup'] ?? " ",
      punchline = data['punchline'] ?? " ",
      id = data['id'] ?? 0;


  Map<String,dynamic> toJson() => {
    'type':type,
    'setup':setup,
    'punchline':punchline,
    'id':id
  };

}
