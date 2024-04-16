// import 'dart:convert';

// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';

// import '../models/Weather_model.dart';
// import'package:http/http.dart' as http;
// class WeatherService {
//   static const BASE_URL ="https://api.openweathermap.org/data/2.5/weather";
//   final String apiKey;

//   WeatherService(this.apiKey);


//   Future<Weather> getWeather(String cityName) async{
//     final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=&units=metric'));
//     if(response.statusCode == 200){
//       return Weather.fromJson(jsonDecode(response.body));
//     }else{
//       throw Exception("Error to load weather");
//     }
//   }
//   Future<String> getCurrentCity() async{
//     LocationPermission permission = await Geolocator.checkPermission();
//     if(permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high );
//       List<Placemark> placemark =
//        await placemarkFromCoordinates(position.latitude,position.longitude);
//       String? city = placemark[0].locality;
//       return city?? "";

//   }
// }
import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../models/Weather_model.dart';

class WeatherService {
  static const BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    // This send a request to the weather service
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));
    // if it giev 200 it means everthing is ok else it throws error
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error to load weather");
    }
  }
// This help us fine the current city we are
  Future<String> getCurrentCity() async {
    // this check if we have permission to to know the location
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    // This find the lattitude and longitude og the location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    // This get the city name of the current loction given
    List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
    String? city = placemark[0].locality;
    return city ?? "";
  }
}
