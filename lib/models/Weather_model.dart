class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;

  Weather ({
    required this.cityName,
    required this.temperature,
    required this.mainCondition
  });
  // method to get the jeason file
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json["name"],
      temperature: json["main"]["temp"].toDoble(),
      mainCondition: json["weather"][0]["main"],
    );
  }
}