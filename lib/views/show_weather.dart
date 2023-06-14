import 'dart:ui';

import 'package:flutter/material.dart';
import '../logic/models/Weather.class.dart';
import '../logic/models/WeatherApi.class.dart';
import 'package:intl/intl.dart';

class ShowWeather extends StatefulWidget {
  final String location;

  const ShowWeather({Key? key, required this.location}) : super(key: key);

  @override
  State<ShowWeather> createState() => _ShowWeatherState();
}

class _ShowWeatherState extends State<ShowWeather> {
  late Future<WeatherModel> _weatherData;

  Future<WeatherModel> getData(String cityName) async {
    return await WeatherApi.fetchWeatherInfo(cityName);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _weatherData = getData(widget.location);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WeatherModel>(
      future: _weatherData,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            print(snapshot.error.toString());
            if (snapshot.error.toString() == 'Ville non trouvée') {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Ville non trouvée',
                      style: TextStyle(color: Colors.white),
                    ),
                    ElevatedButton(
                      child: const Text('Retour'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Une erreur est survenue, merci de réessayer plus tard',
                      style: TextStyle(color: Colors.white),
                    ),
                    ElevatedButton(
                      child: const Text('Retour'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            }
          } else {
            final data = snapshot.data!;
            return Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/background/${data.getIcon()}.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                    child: Container(
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ),
                ),
                Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.near_me,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 5.0,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 2.0,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ],
                      ),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.pushNamed(context, '/', arguments: "");
                      },
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.my_location,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(0.5, 0.5),
                              blurRadius: 1.0,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            Shadow(
                              offset: Offset(0.5, 0.5),
                              blurRadius: 1.0,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ],
                        ),
                        color: Colors.black,
                        onPressed: () {
                          Navigator.pushNamed(context, '/location');
                        },
                      ),
                    ],
                  ),
                  body: SafeArea(
                    child: Center(
                      child: Flex(
                        direction: Axis.vertical,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(data.city,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 3.0,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                    Shadow(
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 8.0,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ],
                                )),
                          ),
                          Expanded(
                            flex: 1,
                            child:
                                Text(DateFormat('EEEE').format(DateTime.now()),
                                    style: const TextStyle(
                                      fontSize: 25,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(1.0, 1.0),
                                          blurRadius: 2.0,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                        Shadow(
                                          offset: Offset(1.0, 1.0),
                                          blurRadius: 2.0,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ],
                                    )),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            flex: 3,
                            child: Image.asset(
                                'assets/images/${data.getIcon()}.png'),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            flex: 1,
                            child: Text("${data.temp}°",
                                style: const TextStyle(
                                  fontSize: 70,
                                  fontWeight: FontWeight.w700,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 3.0,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                    Shadow(
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 8.0,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ],
                                )),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            flex: 1,
                            child: Text(data.desc,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 3.0,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                    Shadow(
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 8.0,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ],
                                )),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                    'assets/images/thermometer_low.png'),
                                Text("${data.lowTemp}°",
                                    style: const TextStyle(
                                      fontSize: 30,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 3.0,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                        Shadow(
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 8.0,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ],
                                    )),
                                Image.asset(
                                    'assets/images/thermometer_high.png'),
                                Text(
                                  "${data.highTemp}°",
                                  style: const TextStyle(
                                    fontSize: 30,
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(2.0, 2.0),
                                        blurRadius: 3.0,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                      Shadow(
                                        offset: Offset(2.0, 2.0),
                                        blurRadius: 8.0,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Text('Erreur inattendue');
        }
      },
    );
  }
}
