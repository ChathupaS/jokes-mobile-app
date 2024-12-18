import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class JokeScreen extends StatefulWidget {
  const JokeScreen({super.key});

  @override
  State<JokeScreen> createState() => _JokeScreenState();
}

class _JokeScreenState extends State<JokeScreen> {
  List<dynamic> jokes = []; // Store fetched jokes

  // Function to fetch jokes from the API using Dio
  Future<void> fetchJokes() async {
    try {
      Dio dio = Dio();
      final response = await dio.get(
        'https://v2.jokeapi.dev/joke/Any',
        queryParameters: {'amount': 3},
      );

      if (response.statusCode == 200) {
        setState(() {
          jokes = response.data['jokes']; // Update jokes list
        });
      } else {
        print('Failed to load jokes: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching jokes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jokes App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: fetchJokes,
              child: const Text('Fetch Jokes'),
            ),
            const SizedBox(height: 20),
            // Display jokes in a ListView
            Expanded(
              child: ListView.builder(
                itemCount: jokes.length,
                itemBuilder: (context, index) {
                  final joke = jokes[index];
                  return ListTile(
                    title: Text(
                      joke['setup'] != null ? '${joke['setup']} ${joke['delivery']}' : joke['joke'], // Display setup and delivery or single-part joke
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