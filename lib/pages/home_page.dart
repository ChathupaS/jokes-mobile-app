import 'package:flutter/material.dart';
import '../widgets/fetch_jokes_button.dart';
import '../services/joke_service.dart';
import '../models/joke.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Joke> jokes = [];

  // Fetch jokes from the service
  Future<void> fetchJokes() async {
    try {
      List<Joke> fetchedJokes = await JokeService().fetchJokes();
      setState(() {
        jokes = fetchedJokes;
      });
    } catch (e) {
      print('Error fetching jokes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xFF834600),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            radius: 1.2,
            colors: [
              Color(0xFF834600),
              Color(0xFF060606),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 30),
            const Center(
              child: Text(
                'Welcome to jokes app',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            FetchJokesButton(fetchJokes: fetchJokes), // Reusable Button widget
            Expanded(
              child: ListView.builder(
                itemCount: jokes.length,
                itemBuilder: (context, index) {
                  final joke = jokes[index];
                  return ListTile(
                    title: Text(
                      joke.setup != null
                          ? '${joke.setup} ${joke.delivery ?? ''}' // Use empty string if delivery is null
                          : joke.joke ?? 'No joke available', // Fallback if joke is null
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
