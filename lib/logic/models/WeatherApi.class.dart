import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:geolocator/geolocator.dart';
import '../../constants/api_key.dart';
import '../../constants/constants.dart';
import 'Weather.class.dart';
import 'Location.class.dart';

class WeatherApi {
  static final Dio _dio = Dio()
    ..interceptors.add(DioCacheManager(CacheConfig()).interceptor);

  static Future<WeatherModel> fetchWeatherInfo(String cityName) async {
    double latitude;
    double longitude;
    String? city = '';

    if (cityName == '') {
      Position currentPosition = await LocationModel.getCurrentPosition();
      latitude = currentPosition.latitude;
      longitude = currentPosition.longitude;
    } else {
      var cityData = await getCityData(cityName);

      // Get the latitude and longitude.
      latitude = cityData['lat'];
      longitude = cityData['lon'];
      city = cityData['name'];
    }

    var url = Uri.parse(
        '$weatherUrl?lat=${latitude.toString()}&lon=${longitude.toString()}&units=metric&appid=$apiKey');

    var response = await _dio.getUri(
      url,
      options: buildCacheOptions(const Duration(hours: 3)),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson =
          response.data as Map<String, dynamic>;

      if (city != '') {
        decodedJson['name'] = city;
      }

      return WeatherModel.fromMap(decodedJson);
    } else if (response.statusCode == 404) {
      return Future.error('Ville non trouvée');
    } else {
      return Future.error(
          'Erreur lors de la récupération des informations météo');
    }
  }

  //Récupérer le nom de la ville
  static Future<Map<String, dynamic>> getCityData(String cityName) async {
    var urlCity = Uri.parse(
        'http://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=1&appid=$apiKey');
    var responsibility = await _dio.getUri(
      urlCity,
      options: buildCacheOptions(const Duration(days: 1)),
    );

    if (responsibility.data.isEmpty) {
      return Future.error('Ville non trouvée');
    }

    // Get the first element of the list.
    return responsibility.data[0];
  }

  // Obtenir la météo sous 5 jours
  static Future<List<WeatherModel>> fetchFiveDayForecast(
      String cityName) async {
    double latitude;
    double longitude;

    if (cityName == '') {
      Position currentPosition = await LocationModel.getCurrentPosition();
      latitude = currentPosition.latitude;
      longitude = currentPosition.longitude;
    } else {
      var cityData = await getCityData(cityName);

      // Get the latitude and longitude.
      latitude = cityData['lat'];
      longitude = cityData['lon'];
    }

    var url = Uri.parse(
        'http://api.openweathermap.org/data/2.5/forecast?lat=${latitude.toString()}&lon=${longitude.toString()}&units=metric&appid=$apiKey');
    var response = await _dio.getUri(
      url,
      options: buildCacheOptions(const Duration(hours: 3)),
    );

    if (response.statusCode == 200) {
      final List<dynamic> decodedJsonList =
          response.data['list'] as List<dynamic>;

      // This assumes you have a fromMap method in your WeatherModel class.
      return decodedJsonList
          .map((dynamic item) =>
              WeatherModel.fromMap(item as Map<String, dynamic>))
          .toList();
    } else if (response.statusCode == 404) {
      return Future.error('Ville non trouvée');
    } else {
      return Future.error(
          'Erreur lors de la récupération des informations météo');
    }
  }
}
