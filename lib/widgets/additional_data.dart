import 'package:flutter/material.dart';

class AdditionalWeatherData extends StatelessWidget {
  const AdditionalWeatherData({
    super.key,
    required this.imagePath,
    required this.title,
    required this.data,
  });

  final String imagePath;
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            width: 40,
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Color.fromARGB(137, 24, 24, 24),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            data,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
