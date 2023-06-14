import 'package:flutter/material.dart';
import 'package:weatherapp/views/input_location.dart';
import 'package:weatherapp/views/show_weather.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (context) => ShowWeather(
                  location: args != null ? args as String : "",
                ));
      case "/location":
        return MaterialPageRoute(builder: (context) => InputLocation());
      default:
        return _errorPage(settings);
    }
  }

  static Route<dynamic> _errorPage(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text('No Route defined for ${settings.name}'),
        ),
      ),
    );
  }
}
