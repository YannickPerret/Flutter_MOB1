import 'package:flutter/material.dart';
import 'Routes/router.dart';

void main() => runApp(const WeatherApp(
      location: '',
    ));

class WeatherApp extends StatelessWidget {
  final String location;
  const WeatherApp({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        fontFamily: 'OpenSans-Regular',
        cardColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ).copyWith(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
        useMaterial3: true,
      ),
    );
  }
}
