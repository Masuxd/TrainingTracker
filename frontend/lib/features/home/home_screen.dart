import 'package:flutter/material.dart';
import 'package:frontend/features/home/exercise_page.dart'; // kello

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigoi Exercise sivulle
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ExercisePage()),
            );
          },
          child: const Text("Start an exercise"),
        ),
      ),
    );
  }
}