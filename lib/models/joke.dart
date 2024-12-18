class Joke {
  final String? setup;
  final String? delivery;
  final String? joke;

  Joke({this.setup, this.delivery, this.joke});

  // Factory method to create a Joke object from JSON
  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      setup: json['setup'],
      delivery: json['delivery'],
      joke: json['joke'],
    );
  }
}
