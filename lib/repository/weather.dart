import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weatherapp/services/appstate.dart';
import 'package:weatherapp/utils/urls.dart';

import '../models/weather.dart';

class WeatherRepository {
  late Dio _dio;

  WeatherRepository() {
    _dio = AppState.getState().dioClient.dio;
  }

  Future<Weather?> fetchWeather(String city) async {
    try {
      final response = await _dio.get(APIUrls.weather, queryParameters: {
        'q': city,
        'units': 'metric',
        'appid': dotenv.env['API_KEY'],
      });

      final uvResponse = await _dio.get('/uvi', queryParameters: {
        'lat': response.data['coord']['lat'],
        'lon': response.data['coord']['lon'],
        'appid': dotenv.env['API_KEY'],
      });

      if (response.statusCode == 200) {
        return Weather.fromJson(response.data).copyWith(
          uvIndex: uvResponse.data['value'].toInt(),
        );
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
