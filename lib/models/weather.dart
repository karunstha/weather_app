class Weather {
  final String city;
  final String country;
  final int temperature;
  final String weatherType;
  final int humidity;
  final double windSpeed;
  final int feelsLike;
  final int uvIndex;

  Weather({
    required this.city,
    required this.country,
    required this.temperature,
    required this.weatherType,
    required this.humidity,
    required this.windSpeed,
    required this.feelsLike,
    this.uvIndex = 0,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final mainJson = json['main'];
    final windJson = json['wind'];

    return Weather(
      city: json['name'],
      country: json['sys']['country'],
      temperature: mainJson['temp'].toInt(),
      humidity: mainJson['humidity'].toInt(),
      windSpeed: windJson['speed'],
      feelsLike: mainJson['feels_like'].toInt(),
      weatherType: json['weather'][0]['main'],
    );
  }

  Weather copyWith({
    String? city,
    String? country,
    int? temperature,
    String? weatherType,
    int? humidity,
    double? windSpeed,
    int? feelsLike,
    int? uvIndex,
  }) {
    return Weather(
      city: city ?? this.city,
      country: country ?? this.country,
      temperature: temperature ?? this.temperature,
      weatherType: weatherType ?? this.weatherType,
      humidity: humidity ?? this.humidity,
      windSpeed: windSpeed ?? this.windSpeed,
      feelsLike: feelsLike ?? this.feelsLike,
      uvIndex: uvIndex ?? this.uvIndex,
    );
  }
}
