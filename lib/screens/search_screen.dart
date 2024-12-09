import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '/constants/app_colors.dart';
import '/constants/text_styles.dart';
import '/constants/constants.dart';
import '/views/famous_cities_weather.dart';
import '/views/gradient_container.dart';
import '/widgets/round_text_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchController;
  String _weatherInfo = '';
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
        _weatherInfo = 'Please enter a city name.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _weatherInfo = '';
    });

    try {
      final url =
          'https://api.openweathermap.org/data/2.5/weather?q=$query&appid=${Constants.apiKey}&units=metric';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _weatherInfo =
              'City: ${data['name']}\nTemperature: ${data['main']['temp']}°C\nWeather: ${data['weather'][0]['description']}';
        });
      } else {
        setState(() {
          _weatherInfo = 'City not found. Please try again.';
        });
      }
    } catch (e) {
      setState(() {
        _weatherInfo = 'An error occurred. Please try again later.';
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
            'Pick Location',
            style: TextStyles.h1,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Find the area or city that you want to know the detailed weather info at this time',
          style: TextStyles.subtitleText,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        Row(
          children: [
            Expanded(
              child: RoundTextField(
                controller: _searchController,
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    _searchWeather(); // searching func
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
          Text(
            _weatherInfo,
            style: TextStyles.bodyText,
            textAlign: TextAlign.center,
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
