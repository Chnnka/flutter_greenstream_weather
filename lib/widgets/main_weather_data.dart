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
    final currentData = response?.current!;
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
              children: [
                Text(
                  '${currentData?.tempC?.toInt()}°c',
                  style: const TextStyle(
                      fontSize: 95, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Feels like ${currentData?.feelslikeC}",
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
                Text(
                  currentData?.condition?.text ?? "",
                  style: const TextStyle(fontSize: 19),
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
                  "https:${currentData?.condition?.icon}",
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
