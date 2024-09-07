import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  bool inProgress = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              const SizedBox(height: 10),
              _buildSearchWidget(),
              Row(
                children: [
                  Column(
                    children: [
                      Text('21 C'),
                      Text('Feels like 23 C'),
                      Text('Partly Cloudy'),
                      Text('Kandy'),
                      Text('Sri Lanka'),
                    ],
                  ),
                  SizedBox(width: 50, child: Image.asset("assets/wind.png")),
                ],
              ),
            ],
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

  _getWeatherData(String location) {
    setState(() {
      inProgress = true;
    });
  }
}
