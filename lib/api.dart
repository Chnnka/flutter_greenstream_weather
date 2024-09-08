import 'constants.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  final String baseUrl = "http://api.weatherapi.com/v1/current.json";

  getCurrentWeather(String location) async {
    String apiUrl = "$baseUrl?key=$apiKey&q=$location";
    try {
      var response = await http.get((Uri.parse(apiUrl)));
      print(response.body);
    } catch (e) {}
  }
}
