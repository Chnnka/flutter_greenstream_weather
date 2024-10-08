import 'dart:convert';

import 'package:flutter_greenstream_weather/models/current_weather.dart';
import 'package:flutter_greenstream_weather/models/forecast_model.dart';

import 'utils/constants.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  final String baseUrl = "http://api.weatherapi.com/v1/current.json";

  Future<ApiResponse> getCurrentWeather(String location) async {
    String apiUrl = "$baseUrl?key=$apiKey&q=$location";
    try {
      final response = await http.get((Uri.parse(apiUrl)));
      if (response.statusCode == 200) {
        // print(response.body);
        return ApiResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Failed to load weather data');
    }
  }
}

class ForecastApi {
  final String baseUrl = "http://api.weatherapi.com/v1/forecast.json";

  Future<ForecastResponse> getCurrentWeather(String location) async {
    String apiUrl = "$baseUrl?key=$apiKey&q=$location";
    try {
      final response = await http.get((Uri.parse(apiUrl)));
      if (response.statusCode == 200) {
        return ForecastResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Failed to load weather data');
    }
  }
}
