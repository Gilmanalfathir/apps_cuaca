class FamousCity {
  final String name;
  final double lat;
  final double lon;

  const FamousCity({
    required this.name,
    required this.lat,
    required this.lon,
  });
}

// List of famous cities as a constant
List<FamousCity> famousCities = const [
  FamousCity(name: 'Tokyo', lat: 35.6833, lon: 139.7667),
  FamousCity(name: 'New Delhi', lat: 28.5833, lon: 77.2),
  FamousCity(name: 'Paris', lat: 48.85, lon: 2.3333),
  FamousCity(name: 'London', lat: 51.4833, lon: -0.0833),
  FamousCity(name: 'New York', lat: 40.7167, lon: -74.0167),
  FamousCity(name: 'Jakarta', lat: -6.2088, lon: 106.8456),
  FamousCity(name: 'Bandung', lat: -6.9175, lon: 107.6191),
  FamousCity(name: 'Sumedang', lat: -6.8556, lon: 107.9228),
  FamousCity(name: 'Bali', lat: -8.3405, lon: 115.0920),
  FamousCity(name: 'Makassar', lat: -5.1477, lon: 119.4327),
];