import 'package:flutter/material.dart';

// A Weather object holds the data we need from the API's JSON reply.
class Weather {
  final double temperature; // current temperature in °C
  final int humidity; // relative humidity in %
  final double windSpeed; // wind speed in km/h
  final int weatherCode; // WMO number that describes the sky (0 = clear ...)
  final double maxTemp; // today's highest temperature
  final double minTemp; // today's lowest temperature

  Weather({
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.weatherCode,
    required this.maxTemp,
    required this.minTemp,
  });

  // JSON parsing: turns the Map made by jsonDecode() into a Weather object.
  // "as num" is used because the API may send 30 (int) or 30.5 (double).
  factory Weather.fromJson(Map<String, dynamic> json) {
    final current = json['current'];
    final daily = json['daily'];

    return Weather(
      temperature: (current['temperature_2m'] as num).toDouble(),
      humidity: (current['relative_humidity_2m'] as num).toInt(),
      windSpeed: (current['wind_speed_10m'] as num).toDouble(),
      weatherCode: (current['weather_code'] as num).toInt(),
      // daily values come as lists (one item per day); [0] means today
      maxTemp: (daily['temperature_2m_max'][0] as num).toDouble(),
      minTemp: (daily['temperature_2m_min'][0] as num).toDouble(),
    );
  }

  // Converts the weather code into readable text.
  String get description {
    if (weatherCode == 0) return 'Clear sky';
    if (weatherCode == 1) return 'Mainly clear';
    if (weatherCode == 2) return 'Partly cloudy';
    if (weatherCode == 3) return 'Overcast';
    if (weatherCode == 45 || weatherCode == 48) return 'Fog';
    if (weatherCode >= 51 && weatherCode <= 57) return 'Drizzle';
    if (weatherCode >= 61 && weatherCode <= 67) return 'Rain';
    if (weatherCode >= 71 && weatherCode <= 77) return 'Snow';
    if (weatherCode >= 80 && weatherCode <= 82) return 'Rain showers';
    if (weatherCode == 85 || weatherCode == 86) return 'Snow showers';
    if (weatherCode >= 95) return 'Thunderstorm';
    return 'Unknown';
  }

  // Converts the weather code into a Flutter icon.
  IconData get icon {
    if (weatherCode == 0 || weatherCode == 1) return Icons.wb_sunny;
    if (weatherCode == 2 || weatherCode == 3) return Icons.cloud;
    if (weatherCode == 45 || weatherCode == 48) return Icons.foggy;
    if (weatherCode >= 51 && weatherCode <= 67) return Icons.water_drop;
    if (weatherCode >= 71 && weatherCode <= 77) return Icons.ac_unit;
    if (weatherCode >= 80 && weatherCode <= 86) return Icons.grain;
    if (weatherCode >= 95) return Icons.thunderstorm;
    return Icons.help_outline;
  }
}