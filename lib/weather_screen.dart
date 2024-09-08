import 'package:flutter/material.dart';
import 'package:flutter_greenstream_weather/api.dart';
import 'package:flutter_greenstream_weather/constants.dart';
import 'package:flutter_greenstream_weather/models/current_weather.dart';
import 'package:flutter_greenstream_weather/widgets/additional_data.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  ApiResponse? response;
  bool inProgress = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 25),
              _buildSearchWidget(),
              const SizedBox(height: 20),
              //main weather details
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //temp
                        Text(
                          '21°c',
                          style: TextStyle(
                              fontSize: 90,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto'),
                        ),
                        Text(
                          'Feels like 23 °c',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        //condition
                        Text(
                          'Partly Cloudy',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        //location
                        Text(
                          'Kandy',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Sri Lanka',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    //weather condition image
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2.6,
                        height: 200,
                        child: Image.asset("assets/wind.png"),
                      ),
                    ),
                  ],
                ),
              ),
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

  _getWeatherData(String location) async {
    setState(() {
      inProgress = true;
    });

    try {
      response = await WeatherApi().getCurrentWeather(location);
    } catch (e) {
    } finally {
      setState(() {
        inProgress = false;
      });
    }
  }
}
