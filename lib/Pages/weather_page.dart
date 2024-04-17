import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/Weather_model.dart';
import 'package:weather_app/Service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}): super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}
// This is the brain of our weather page
class _WeatherPageState extends State<WeatherPage> {
  // apikey is our weather helper so we can get the weather
  final _weatherService = WeatherService("183d3f058fe8b1ac7da916cddb1743dd");
  Weather? _weather;   
  // fetch weather information using the weather healper
  _fetchWeather() async {
    // get current city
    String cityName = await _weatherService.getCurrentCity();
    // we are trying to get the weather information of the city providewd by the weather helper
    try{
      final weather = await _weatherService.getWeather(cityName); 
      setState(() {
        _weather=weather;
      });
    }
    // if everything goes well it show us the weather else it print error
    catch(e){
      print(e);
    }
  }
  // weather  
  String getWeatherAnimation(String? mainCondition){
    if(mainCondition == null) return 'assets/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainny.json';
       case 'thunderstorm':
        return 'assets/main.json'; 
        case 'clear':
          return 'assets/sunny.json';
          default:
            return 'assets/sunny.json';
    }    
  }
  @override
  void initState(){
    super.initState();
    _fetchWeather();
  }
  // the weather is been displayed
  @override  
  Widget build(BuildContext context) {
    // we use scaffold to give our weather a structure
    return Scaffold (
      // Every items are centered in the screen
      backgroundColor: Colors.grey[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // the city and the weather temperature is show using text widgets and if we dont have the weathr yet it show us loading weather.
          children: [
            Text(_weather?.cityName ?? "Loading weather.....",
            // ignore: prefer_const_constructors
            style: TextStyle(
              fontSize:24,
              fontWeight:FontWeight.bold,
              color:Colors.white,
            ),
            ),
            // animation
            SizedBox(height: 20),
           Lottie.asset(getWeatherAnimation(_weather?.mainCondition )),
              // Temperature
            Text('${_weather?.temperature.round()}\u{00B0}C',
            // ignore: prefer_const_constructors
            style:TextStyle(
              fontSize:24,
              fontWeight: FontWeight.bold,
              color:Colors.red,

            ),
            ),
            // weather condition
               Text(_weather?.mainCondition ?? "",
                 // ignore: prefer_const_constructors
                 style:TextStyle(
              fontSize:32,
              fontWeight: FontWeight.bold,
              color:Color.fromARGB(255, 15, 226, 139),
                 ),
               ),

          
          ],
        )
      )
    );
  }
}