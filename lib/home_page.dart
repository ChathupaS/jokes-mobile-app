import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; // Import Dio for API calls

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> jokes = []; // Store fetched jokes

  // Function to fetch jokes from the API using Dio
  Future<void> fetchJokes() async {
    try {
      Dio dio = Dio();
      final response = await dio.get(
        'https://v2.jokeapi.dev/joke/Any',
        queryParameters: {'amount': 5},
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
      // AppBar added here
      appBar: AppBar(
        title: Text(widget.title), // Use the title from the widget's constructor
        backgroundColor: const Color(0xFF834600), // Set appBar color to match the gradient
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            radius: 1.2,
            colors: [
              Color(0xFF834600), // Orange color
              Color(0xFF060606), // Dark gray
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Align to the top
          children: <Widget>[
            // Add some space after the AppBar
            const SizedBox(height: 30), // 30px space after the AppBar

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
            // Button to trigger fetching jokes
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: fetchJokes, // Call fetchJokes on press
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Fetch Jokes'),
              ),
            ),
            // Display jokes in a ListView
            Expanded(
              child: ListView.builder(
                itemCount: jokes.length,
                itemBuilder: (context, index) {
                  final joke = jokes[index];
                  return ListTile(
                    title: Text(
                      joke['setup'] != null ? '${joke['setup']} ${joke['delivery']}' : joke['joke'], // Display setup and delivery or single-part joke
                      style: const TextStyle(color: Colors.white), // Set text color to white
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

void main() {
  runApp(const MaterialApp(
    title: 'Joke App',
    home: MyHomePage(title: 'Jokes App'),
  ));
}
