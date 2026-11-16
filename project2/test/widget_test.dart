import 'package:flutter_test/flutter_test.dart';
import 'package:project2/weather_model.dart';

void main() {
  // Tests JSON parsing with fake data (no internet needed).
  test('Weather.fromJson reads the API data correctly', () {
    final fakeJson = {
      'current': {
        'temperature_2m': 30.5,
        'relative_humidity_2m': 80,
        'wind_speed_10m': 12.3,
        'weather_code': 3,
      },
      'daily': {
        'temperature_2m_max': [33.0],
        'temperature_2m_min': [25.0],
      },
    };

    final weather = Weather.fromJson(fakeJson);

    expect(weather.temperature, 30.5);
    expect(weather.humidity, 80);
    expect(weather.windSpeed, 12.3);
    expect(weather.maxTemp, 33.0);
    expect(weather.minTemp, 25.0);
    expect(weather.description, 'Overcast');
  });
}