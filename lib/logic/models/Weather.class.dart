class WeatherModel {
  int temp;
  int lowTemp;
  int highTemp;
  String city;
  String desc;
  int condition;

  WeatherModel({
    required this.highTemp,
    required this.temp,
    required this.lowTemp,
    required this.city,
    required this.desc,
    required this.condition,
  });

  WeatherModel.fromMap(Map<String, dynamic> json)
      : temp = double.parse(json['main']['temp'].toString()).round(),
        lowTemp = double.parse(json['main']['temp_min'].toString()).round(),
        highTemp = double.parse(json['main']['temp_max'].toString()).round(),
        city = json['name'],
        desc = json['weather'][0]['description'],
        condition = json['weather'][0]['id'];

  String getIcon() {
    if (condition < 300) {
      return 'thunder';
    } else if (condition < 400) {
      return 'drizzle';
    } else if (condition == 500) {
      return 'rain';
    } else if (condition < 600) {
      return 'heavy_rain';
    } else if (condition < 700) {
      return 'snow';
    } else if (condition < 800) {
      return 'fog';
    } else if (condition == 800) {
      return 'sun';
    } else if (condition <= 804) {
      return 'cloud';
    } else {
      return 'thermometer';
    }
  }
}
