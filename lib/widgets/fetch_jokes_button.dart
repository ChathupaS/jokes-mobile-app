import 'package:flutter/material.dart';

class FetchJokesButton extends StatelessWidget {
  final Future<void> Function() fetchJokes;

  const FetchJokesButton({super.key, required this.fetchJokes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: fetchJokes, // Trigger fetchJokes function passed from parent
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: const Text('Fetch Jokes'),
      ),
    );
  }
}
