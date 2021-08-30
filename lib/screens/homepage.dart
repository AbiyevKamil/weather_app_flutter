import 'package:flutter/material.dart';
import 'package:weather_app/weather_data.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final inputController = TextEditingController();
  late String country;
  late String temp;
  late String description;
  late String windSpeed;
  late String icon;
  bool hasError = true;

  @override
  void dispose() {
    super.dispose();
    inputController.dispose();
  }

  void _sendRequest(String cityName) async {
    WeatherData weatherData = WeatherData(cityName: cityName);
    await weatherData.getData();
    setState(() {
      country = weatherData.country;
      temp = weatherData.temp;
      description = weatherData.description;
      windSpeed = weatherData.windSpeed;
      hasError = weatherData.error;
      icon = weatherData.icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.white,
                      controller: inputController,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.grey[900],
                        filled: true,
                        hintText: 'Search for city or country',
                        hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.grey[900],
                    child: TextButton(
                      onPressed: () {
                        if (inputController.text.isNotEmpty)
                          _sendRequest(inputController.text);
                        else {
                          setState(() {
                            hasError = true;
                          });
                        }
                      },
                      child: Text(
                        'Search',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Container(
                  color: Colors.grey[100],
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Expanded(
                      child: Center(
                        child: hasError
                            ? Text(
                                'Search for city or country',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0,
                                  color: Colors.grey[900],
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Temp: $temp °C',
                                    style: TextStyle(
                                      fontSize: 28.0,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2.0,
                                      color: Colors.grey[900],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  Text(
                                    'Country: ${country.toUpperCase()}',
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2.0,
                                      color: Colors.grey[900],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 25.0),
                                  Text(
                                    'Wind: ${windSpeed.toUpperCase()} m/h',
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2.0,
                                      color: Colors.grey[900],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 25.0),
                                  Image.network(
                                    'http://openweathermap.org/img/wn/$icon.png',
                                    color: Colors.grey[900],
                                  ),
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  Text(
                                    '${description.toUpperCase()}',
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2.0,
                                      color: Colors.grey[900],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
