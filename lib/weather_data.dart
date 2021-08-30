import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherData {
  final String apiKey = 'dfdcceafcc7524308f81f110861c22a6';
  late final String cityName;
  late bool error = false;
  late String temp;
  late String description;
  late String country;
  late String windSpeed;
  late String icon;

  WeatherData({required this.cityName});

  Future<void> getData() async {
    String apiURL =
        'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&mode=json&units=metric';
    try {
      final res = await http.get(Uri.parse(apiURL));
      final data = await jsonDecode(res.body);
      temp = data['main']['temp'].toString();
      description = data['weather'][0]['description'].toString();
      icon = data['weather'][0]['icon'].toString();
      country = data['name'].toString();
      windSpeed = data['wind']['speed'].toString();
    } catch (err) {
      print(err);
      error = true;
    }
  }
}
