import 'package:flutter/material.dart';
import 'package:flutter_greenstream_weather/utils/constants.dart';
import 'package:flutter_greenstream_weather/models/forecast_model.dart';
import 'package:flutter_greenstream_weather/utils/time_formatter.dart';

class HourlyCard extends StatelessWidget {
  const HourlyCard({
    super.key,
    required this.forecast_response,
  });

  final ForecastResponse? forecast_response;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecast_response?.forecast!.forecastday![0].hour!.length,
        itemBuilder: (BuildContext context, int index) {
          final hourData =
              forecast_response?.forecast!.forecastday![0].hour![index];
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
                  Text(
                    formatTime(hourData!.time!),
                    style: const TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    width: 35,
                    height: 35,
                    child: Image.network("https:${hourData.condition!.icon}"),
                  ),
                  Text('${hourData.tempC}°c',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange[900])),
                  //chance of rain
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 12,
                        child: Image.asset(dewdrop),
                      ),
                      const SizedBox(width: 5),
                      Text('${hourData.chanceOfRain?.toString()}%'),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
