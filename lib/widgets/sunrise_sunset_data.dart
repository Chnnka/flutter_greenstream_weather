import 'package:flutter/material.dart';
import 'package:flutter_greenstream_weather/utils/constants.dart';
import 'package:flutter_greenstream_weather/models/forecast_model.dart';

class SunriseSet extends StatelessWidget {
  const SunriseSet({
    super.key,
    required this.context,
    required this.forecast_response,
  });

  final BuildContext context;
  final ForecastResponse? forecast_response;

  @override
  Widget build(BuildContext context) {
    return Row(
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
              const SizedBox(height: 10),
              const Text('Sun Rise'),
              Text(forecast_response!.forecast!.forecastday![0].astro!.sunrise!,
                  style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
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
              const SizedBox(height: 10),
              const Text('Sun Set'),
              Text(
                forecast_response!.forecast!.forecastday![0].astro!.sunset!,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
