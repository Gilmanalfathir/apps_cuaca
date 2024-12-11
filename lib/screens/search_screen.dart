import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '/constants/app_colors.dart';
import '/constants/text_styles.dart';
import '/constants/constants.dart';
import '/views/famous_cities_weather.dart';
import '/views/gradient_container.dart';
import '/widgets/round_text_field.dart';
import '/utils/get_weather_icons.dart';
import '/screens/weather_detail_screen.dart'; // Pastikan Anda sudah import WeatherDetailScreen

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchController;
  String _weatherInfo = '';
  String? _weatherIcon;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  Future<void> _searchWeather() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      setState(() {
        _weatherInfo = 'Masukkan nama kota.';
        _weatherIcon = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _weatherInfo = '';
      _weatherIcon = null;
    });

    try {
      final url =
          'https://api.openweathermap.org/data/2.5/weather?q=$query&appid=${Constants.apiKey}&units=metric&lang=id';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final weatherCode = data['weather'][0]['id']; // Get weather code

        setState(() {
          _weatherInfo =
              '${data['main']['temp'].round()}°C\n${data['weather'][0]['description']}\n${data['name']}';
          _weatherIcon =
              getWeatherIcon(weatherCode: weatherCode); // Get weather icon
        });
      } else {
        setState(() {
          _weatherInfo = 'Kota tidak ditemukan. Coba lagi!';
          _weatherIcon = null;
        });
      }
    } catch (e) {
      setState(() {
        _weatherInfo = 'An error occurred. Please try again later.';
        _weatherIcon = null;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      children: [
        const Align(
          alignment: Alignment.center,
          child: Text(
            'Cari Lokasi',
            style: TextStyles.h1,
          ),
        ),
        const SizedBox(height: 40),
        Row(
          children: [
            Expanded(
              child: RoundTextField(
                controller: _searchController,
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    _searchWeather(); // searching function
                  }
                },
              ),
            ),
            const SizedBox(width: 15),
            GestureDetector(
              onTap: _searchWeather,
              child: const LocationIcon(),
            ),
          ],
        ),
        const SizedBox(height: 30),
        if (_isLoading)
          const CircularProgressIndicator()
        else if (_weatherInfo.isNotEmpty)
          InkWell(
            onTap: () {
              // Navigate to detail page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WeatherDetailScreen(
                    cityName: _searchController.text.trim(), // set city name
                  ),
                ),
              );
            },
            child: Material(
              color: AppColors.skyBlue,
              elevation: 12,
              borderRadius: BorderRadius.circular(25.0),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Column for weather icon, temperature, and description
                    Row(
                      children: [
                        // Weather icon with increased size
                        if (_weatherIcon != null)
                          Image.asset(
                            _weatherIcon!,
                            width: 100, // Increase size here (adjust as needed)
                          ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Checking if there are enough parts in _weatherInfo
                            if (_weatherInfo.isNotEmpty)
                              Text(
                                _weatherInfo.contains('\n')
                                    ? _weatherInfo.split('\n')[0] // Temperature
                                    : _weatherInfo,
                                style: TextStyles.h2.copyWith(
                                    color: Colors.white.withOpacity(0.9)),
                              ),
                            const SizedBox(height: 10),
                            if (_weatherInfo.contains('\n'))
                              Text(
                                _weatherInfo.split('\n').length > 1
                                    ? _weatherInfo
                                        .split('\n')[1] // Weather description
                                    : '',
                                style: TextStyles.h3.copyWith(
                                    color: Colors.white.withOpacity(0.8)),
                              ),
                          ],
                        ),
                      ],
                    ),
                    // Column for the city name placed at the far right
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Check if the name exists in the API response
                        if (_weatherInfo.isNotEmpty)
                          Text(
                            _weatherInfo.split('\n').length > 2
                                ? _weatherInfo.split('\n')[2] // City name
                                : '',
                            style: TextStyles.h1.copyWith(color: Colors.white),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        const SizedBox(height: 30),
        const FamousCitiesWeather(),
      ],
    );
  }
}

class LocationIcon extends StatelessWidget {
  const LocationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        color: AppColors.royalBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(
        Icons.location_on_outlined,
        color: AppColors.slate,
      ),
    );
  }
}
