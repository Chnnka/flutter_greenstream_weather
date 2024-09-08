import 'package:flutter/material.dart';
import 'package:flutter_greenstream_weather/models/current_weather.dart';

class MainWeatherData extends StatelessWidget {
  const MainWeatherData({
    super.key,
    required this.response,
  });

  final ApiResponse? response;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Weather details on the left side
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  response?.current?.tempC != null
                      ? '${response?.current?.tempC?.toInt()}°C'
                      : '',
                  style: TextStyle(fontSize: 95),
                ),
                Text(
                  "Feels like ${response?.current?.feelslikeC}",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                Text(
                  response?.current?.condition?.text ?? "",
                  style: TextStyle(fontSize: 19),
                ),
                Text(
                  response?.location?.name ?? "",
                  style: TextStyle(fontSize: 22),
                ),
                Text(
                  response?.location?.country ?? "",
                ),
              ],
            ),
          ),
          //weather condition icon
          Expanded(
            flex: 1,
            child: Center(
              child: SizedBox(
                height: 200,
                child: Image.network(
                  "https:${response?.current?.condition?.icon}",
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
