import 'package:flutter/material.dart';
import 'weather_model.dart';
import 'weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // Predefined cities: name -> [latitude, longitude]
  final Map<String, List<double>> _cities = {
    'Chattogram': [22.3569, 91.7832],
    'Dhaka': [23.8103, 90.4125],
    'Sylhet': [24.8949, 91.8687],
    'Khulna': [22.8456, 89.5403],
    'Rajshahi': [24.3745, 88.6042],
  };

  final WeatherService _service = WeatherService();
  String _selectedCity = 'Chattogram';

  // This Future holds the result of the API request.
  late Future<Weather> _weatherFuture;

  @override
  void initState() {
    super.initState();
    _loadWeather(); // load weather when the screen opens
  }

  // Starts a new API request for the selected city.
  void _loadWeather() {
    final coords = _cities[_selectedCity]!;
    _weatherFuture = _service.fetchWeather(coords[0], coords[1]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Forecast'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // City dropdown
            DropdownButton<String>(
              value: _selectedCity,
              isExpanded: true,
              items: _cities.keys.map((name) {
                return DropdownMenuItem(value: name, child: Text(name));
              }).toList(),
              onChanged: (value) {
                if (value == null) return;
                // setState rebuilds the screen with the new city.
                setState(() {
                  _selectedCity = value;
                  _loadWeather();
                });
              },
            ),
            const SizedBox(height: 20),

            // FutureBuilder shows a different widget for each state:
            // loading, error, or data ready.
            Expanded(
              child: FutureBuilder<Weather>(
                future: _weatherFuture,
                builder: (context, snapshot) {
                  // 1. Still waiting for the API
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // 2. Something went wrong (no internet, server error...)
                  if (snapshot.hasError) {
                    return _buildError();
                  }

                  // 3. Data arrived successfully
                  return _buildWeather(snapshot.data!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Error message + retry button
  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.cloud_off, size: 64, color: Colors.grey),
          const SizedBox(height: 12),
          const Text(
            'Could not load weather data.\nPlease check your internet connection.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _loadWeather(); // try the request again
              });
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  // The weather card shown when data is ready
  Widget _buildWeather(Weather weather) {
    return Center(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _selectedCity,
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Icon(weather.icon, size: 80, color: Colors.orange),
              Text(
                '${weather.temperature.toStringAsFixed(1)} °C',
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              Text(weather.description, style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _infoItem(Icons.water_drop, 'Humidity', '${weather.humidity}%'),
                  _infoItem(Icons.air, 'Wind', '${weather.windSpeed} km/h'),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _infoItem(Icons.arrow_downward, 'Min',
                      '${weather.minTemp.toStringAsFixed(1)} °C'),
                  _infoItem(Icons.arrow_upward, 'Max',
                      '${weather.maxTemp.toStringAsFixed(1)} °C'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Small helper that builds one icon + label + value column.
  Widget _infoItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon),
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}