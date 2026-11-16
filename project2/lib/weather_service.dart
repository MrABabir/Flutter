import 'dart:convert'; // for jsonDecode
import 'package:http/http.dart' as http; // for sending the request
import 'weather_model.dart';

// This class talks to the Open-Meteo API.
class WeatherService {
  // "async" + "Future": the answer is not ready immediately,
  // so we promise to return a Weather object later.
  Future<Weather> fetchWeather(double latitude, double longitude) async {
    // Build the API address (URL) with the city's coordinates.
    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast'
      '?latitude=$latitude&longitude=$longitude'
      '&current=temperature_2m,relative_humidity_2m,weather_code,wind_speed_10m'
      '&daily=temperature_2m_max,temperature_2m_min'
      '&timezone=auto',
    );

    // "await" waits for the server's reply (max 10 seconds).
    final response = await http.get(url).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      // 200 = success. Convert the JSON text into a Map, then into Weather.
      final data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } else {
      // Any other status code is an error. FutureBuilder will catch this.
      throw Exception('Server error: ${response.statusCode}');
    }
  }
}