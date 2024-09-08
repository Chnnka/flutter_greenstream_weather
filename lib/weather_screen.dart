import 'package:flutter/material.dart';
import 'package:flutter_greenstream_weather/api.dart';
import 'package:flutter_greenstream_weather/constants.dart';
import 'package:flutter_greenstream_weather/models/current_weather.dart';
import 'package:flutter_greenstream_weather/models/forecast_model.dart';
import 'package:flutter_greenstream_weather/widgets/additional_data.dart';
import 'package:flutter_greenstream_weather/widgets/main_weather_data.dart';

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
      return Text(
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
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: 85,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          '12:00 AM',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          width: 35,
                          height: 35,
                          child: Image.asset(sunset),
                        ),
                        const Text('30 C', style: TextStyle(fontSize: 18)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 12,
                              child: Image.asset(dewdrop),
                            ),
                            const SizedBox(width: 5),
                            const Text('40%'),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
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
                  data: '40',
                ),
                AdditionalWeatherData(
                  imagePath: humidity,
                  title: 'Humidity',
                  data: '40',
                ),
                AdditionalWeatherData(
                  imagePath: wind,
                  title: 'Wind',
                  data: '40 Km/h',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width / 2.5,
                decoration: BoxDecoration(
                    color: Colors.amber[100],
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 65,
                      child: Image.asset(sunrise),
                    ),
                    Text('Sun Rise'),
                    Text('05.30 AM',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width / 2.5,
                decoration: BoxDecoration(
                    color: Colors.amber[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 65,
                      child: Image.asset(sunset),
                    ),
                    Text('Sun Set'),
                    Text(
                      '06.30 AM',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
    } catch (e) {
    } finally {
      setState(() {
        inProgress = false;
      });
    }
  }
}
