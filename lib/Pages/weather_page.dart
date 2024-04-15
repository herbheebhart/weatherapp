import 'package:flutter/material.dart';
import 'package:weather_app/models/Weather_model.dart';
import 'package:weather_app/Service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // apikey
  final _weatherService = WeatherService("183d3f058fe8b1ac7da916cddb1743dd");
  Weather? _weather;   
  // fetch weather
  _fetchWeather() async {
    // get current cuity
    String cityName = await _weatherService.getCurrentCity();
    try{
      final weather = await _weatherService.getWeather(cityName); 
      setState(() {
        _weather=weather;
      });
    }
    catch(e){
      print(e);
    }
  }
  @override
  void initState(){
    super.initState();
    _fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "Loading weather....."),
            Text('${_weather?.temperature.round()}0C')
          ],
        )
      )
    );
  }
}