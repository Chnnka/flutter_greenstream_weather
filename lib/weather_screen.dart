import 'package:flutter/material.dart';
import 'package:flutter_greenstream_weather/api.dart';
import 'package:flutter_greenstream_weather/utils/constants.dart';
import 'package:flutter_greenstream_weather/models/current_weather.dart';
import 'package:flutter_greenstream_weather/models/forecast_model.dart';

import 'package:flutter_greenstream_weather/widgets/additional_data.dart';
import 'package:flutter_greenstream_weather/widgets/hourly_data.dart';
import 'package:flutter_greenstream_weather/widgets/main_weather_data.dart';
import 'package:flutter_greenstream_weather/widgets/sunrise_sunset_data.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  ApiResponse? response;
  ForecastResponse? forecast_response;
  bool inProgress = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 25),
                _buildSearchWidget(),
                const SizedBox(height: 20),
                if (inProgress)
                  const CircularProgressIndicator()
                else
                  _buildWeatherWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchWidget() {
    return SearchBar(
      hintText: 'Search for location',
      onSubmitted: (value) {
        _getWeatherData(value);
      },
    );
  }

  Widget _buildWeatherWidget() {
    if (response == null) {
      return const Text(
        'Search for your location',
        style: TextStyle(
          color: Colors.black26,
        ),
      );
    } else {
      return Column(
        children: [
          //main weather details
          MainWeatherData(response: response),
          const SizedBox(height: 20),
          //24 hour forecast details - (hourlyforcast)
          const Text('24-Hour Forecast'),
          HourlyCard(forecast_response: forecast_response),
          const SizedBox(height: 20),
          //additional weather data
          Card(
            elevation: 0,
            color: Colors.grey[350],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AdditionalWeatherData(
                  imagePath: uvIndex,
                  title: 'UV Index',
                  data: "${response?.current?.uv}",
                ),
                AdditionalWeatherData(
                  imagePath: humidity,
                  title: 'Humidity',
                  data: "${response?.current?.humidity}",
                ),
                AdditionalWeatherData(
                  imagePath: wind,
                  title: 'Wind',
                  data: "${response?.current?.windKph}",
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          //sun rise and sunset
          SunriseSet(context: context, forecast_response: forecast_response),
        ],
      );
    }
  }

  _getWeatherData(String location) async {
    setState(() {
      inProgress = true;
    });

    try {
      response = await WeatherApi().getCurrentWeather(location);
      forecast_response = await ForecastApi().getCurrentWeather(location);
    } finally {
      setState(() {
        inProgress = false;
      });
    }
  }
}
