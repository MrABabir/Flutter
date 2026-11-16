import 'package:flutter/material.dart';
import 'weather_screen.dart'; // our new weather screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        // Your original red theme colour is kept.
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 238, 10, 29),
        ),
      ),
      // The first screen shown when the app opens.
      home: const WeatherScreen(),
    );
  }
}